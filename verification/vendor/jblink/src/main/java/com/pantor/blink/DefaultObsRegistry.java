// Copyright (c) 2013, Pantor Engineering AB
//
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
//
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimer in the documentation and/or other materials provided
//    with the distribution.
//
//  * Neither the name of Pantor Engineering AB nor the names of its
//    contributors may be used to endorse or promote products derived
//    from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//
// IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
// OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
// LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
// USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
// DAMAGE.

package com.pantor.blink;

import java.util.HashMap;
import java.util.ArrayList;
import java.lang.reflect.Method;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Modifier;
import java.lang.annotation.Annotation;
import java.util.concurrent.atomic.AtomicInteger;

public final class DefaultObsRegistry implements ObserverRegistry 
{
   public enum LoadMode
   {
      Public, Privileged
   }

   /**
      Creates an observer registry that allows type specific observers
      to registered in number of ways.

      <p>The most convenient way of register a set of type specific
      observers is to use the {@code addObserver} method that takes a
      POJO argument. The registry will autodetect methods on the
      supplied object based on their signature and a prefix of the
      method name.</p>

      <p>In the following example the registry will recognize two type
      specific observer methods: {@code onFoo} and {@code onBar} based
      on the prefix "on" and their argument types. It will also
      recognize the {@code onAny} method as a fallback observer that
      will receive any object that was not matched by any more
      specific observer.</p>
      
      <pre>{@code
public class MyObserver
{
public void onFoo (Foo msg) { ... }
public void onBar (Bar msg) { ... }
public void onAny (Object msg) { ... }
}
}

// ...

reg.addObserver (new MyObserver ());</pre>

      <p>By default the registry requires all methods of an POJO
      observer to have public visibility. This also allows any
      internally generated classes to be loaded by a private class
      loader that can garbage collected when not needed
      anymore. However, if you like to have more restricted visibility
      on your observer methods, you must specify {@code
      LoadMode.Privileged} when creating the registry. In this case
      any generated classes will be loaded by the class loader of the
      specified POJO observer. Since the class loader of the observer
      typically is the main class loader of the whole application, the
      generated classes will never be garbage collected, even when
      they are not used anymore.</p>
      
      @param om the object model
      @param loadMode specifies how to load dynamically generated
      internal classes
    */
   
   public DefaultObsRegistry (ObjectModel om, LoadMode loadMode)
   {
      this.om = om;
      this.loadMode = loadMode;

      if (om != null)
      {
         this.dload = new DynClassLoader ();
         this.omDep = new Dependent (om) {
               @Override
               public void onDependeeChanged () throws BlinkException
               {
                  dirty = true;
               }
            };
      }
      else
      {
         this.dload = null;
         this.omDep = null;
      }
   }

   public DefaultObsRegistry ()
   {
      this (null, LoadMode.Public);
   }

   public DefaultObsRegistry (ObjectModel om)
   {
      this (om, LoadMode.Public);
   }

   public DefaultObsRegistry (LoadMode loadMode)
   {
      this (null, loadMode);
   }

   @Override
   public Observer findObserver (Class<?> type) throws BlinkException
   {
      if (om != null)
      {
         ObjectModel.GroupBinding bnd = findGroupBinding (type);
         if (bnd != null)
            return findObserver (bnd.getGroup ());
      }

      return null;
   }

   @Override
   public Observer findObserver (Schema.Group g) throws BlinkException

   {
      Observer obs = innerFindObserver (g);
      if (obs == null)
      {
         flush ();
         obs = innerFindObserver (g);
      }
      return obs;
   }

   private Observer innerFindObserver (Schema.Group g) throws BlinkException
   {
      Observer obs = obsByName.get (g.getName ());
      if (obs != null)
         return obs;
      else
         return findInAncestry (g.getSuperGroup ());
   }

   @Override
   public Observer findDirectObserver (Class<?> type) throws BlinkException
   {
      if (om != null)
      {
         ObjectModel.GroupBinding bnd = findGroupBinding (type);
         if (bnd != null)
            return findDirectObserver (bnd.getGroup ());
      }

      return null;
   }

   @Override
   public Observer findDirectObserver (Schema.Group g) throws BlinkException

   {
      Observer obs = innerFindDirectObserver (g);
      if (obs == null)
      {
         flush ();
         obs = innerFindDirectObserver (g);
      }
      return obs;
   }

   private Observer innerFindDirectObserver (Schema.Group g)
      throws BlinkException

   {
      return obsByName.get (g.getName ());
   }

   private static class PendObs
   {
      PendObs (Method method, Object obs)
      {
         this.method = method;
         this.obs = obs;
      }
      
      final Method method;
      final Object obs;
   }
   
   private void flush () throws BlinkException
   {
      if (dirty)
      {
         dirty = false;
         if (! pendObservers.isEmpty ())
         {
            ArrayList<PendObs> putbacks = null;

            for (PendObs pend : pendObservers)
               if (! addObserver (pend.method, pend.obs))
               {
                  if (putbacks == null)
                     putbacks = new ArrayList<PendObs> ();
                  putbacks.add (pend);
               }

            pendObservers.clear ();

            if (putbacks != null)
               pendObservers.addAll (putbacks);
         }
      }
   }
   
   @Override
   public Observer getFallbackObserver ()
   {
      return fallback;
   }
   
   public void addObserver (NsName name, Observer obs)
   {
      obsByName.put (name, obs);
   }
   
   public void addObserver (Object obs) throws BlinkException
   {
      addObserver (obs, "on");
   }

   public void addObserver (Object obs, String prefix) throws BlinkException
   {
      if (om != null)
      {
         for (Method m : obs.getClass ().getMethods ())
            if (m.getName ().startsWith (prefix))
               pendObservers.add (new PendObs (m, obs));
      }
      else
         throw new RuntimeException ("DefaultObsRegistry: Cannot add " +
                                     "dynamic observer if no data model is " +
                                     "specified: " + obs.getClass ());
   }

   public void addObserver (Object obs, Class<? extends Annotation> annot)
      throws BlinkException
   {
      if (om != null)
      {
         for (Method m : obs.getClass ().getMethods ())
            if (m.isAnnotationPresent (annot))
               pendObservers.add (new PendObs (m, obs));
      }
      else
         throw new RuntimeException ("DefaultObsRegistry: Cannot add " +
                                     "dynamic observer if no data model is " +
                                     "specified: " + obs.getClass ());
   }

   public void setLoadMode (LoadMode loadMode)
   {
      this.loadMode = loadMode;
   }
   
   private boolean addObserver (Method m, Object obs) throws BlinkException
   {
      if (m.getReturnType () == void.class &&
          ! Modifier.isStatic (m.getModifiers ()))
      {
         m.setAccessible (true);
         
         Class<?> [] prms = m.getParameterTypes ();

         if (prms.length == 1)
         {
            ObjectModel.GroupBinding bnd = findGroupBinding (prms [0]);
            if (bnd != null)
            {
               obsByName.put (bnd.getGroup ().getName (),
                              createDynObs (m, obs, false));
               return true;
            }
         }
         else
         {
            if (prms.length == 2 && prms [1] == Schema.Group.class)
            {
               ObjectModel.GroupBinding bnd = findGroupBinding (prms [0]);
               if (bnd != null)
               {
                  obsByName.put (bnd.getGroup ().getName (),
                                 createDynObs (m, obs, true));
                  return true;
               }
            }
         }

         // Test for fallback void onAny (Object o) or
         // void onAny (Object o, Schema.Group g)
   
         if (prms.length > 0)
         {
            if (prms [0] == Object.class)
            {
               if (prms.length == 1)
               {
                  fallback = createDynObs (m, obs, false);
                  return true;
               }
               else
               {
                  if (prms.length == 2 && prms [1] == Schema.Group.class)
                  {
                     fallback = createDynObs (m, obs, true);
                     return true;
                  }
               }
            }
         }
      }

      return false;
   }

   private ObjectModel.GroupBinding findGroupBinding (Class<?> c)
      throws BlinkException
   {
      try
      {
         return om.getGroupBinding (c);
      }
      catch (BlinkException.NoBinding e)
      {
         return null;
      }
   }

   // public final class <T>+<method>_obs implements Observer
   // {
   //    <T>+<method>_obs (T obs)
   //    {
   //       this.obs = obs;
   //    }
   //
   //    public void onObj (Object o, Schema.Group g)
   //    {
   //       obs.<method> (o); // or obs.<method> (o, g)
   //    }
   //
   //    private final T obs;
   // }
   
   private Observer createDynObs (Method m, Object obs, boolean withGroup)
      throws BlinkException.Binding
   {
      Class c = obs.getClass ();
      String obsName = makeUnique (c.getName () + "+" + m.getName () + "_obs");
      String obsDescr = "L" + DynClass.toInternal (c) + ";";
      String onObjSig = "(Ljava/lang/Object;Lcom/pantor/blink/Schema$Group;)V";
      DynClass dc = new DynClass (obsName);
      dc.setFlags (DynClass.ClassFlag.Final);
      dc.addInterface ("com.pantor.blink.Observer");

      dc.addField ("obs", obsDescr, DynClass.FieldFlag.Private,
                   DynClass.FieldFlag.Final);
      
      // Constructor

      dc.startPublicMethod ("<init>", "(" + obsDescr + ")V")
         .aload0 ()
         .invokeSpecial ("java.lang.Object", "<init>", "()V") // super ()
         .aload0 ()
         .aload1 ()
         .putField (obsName, "obs", obsDescr)
         .return_ ().setMaxStack (2).endMethod ();

      // void onObj (Object, Schema.Group g)

      dc.startPublicMethod ("onObj", onObjSig)
         .aload0 () // this
         .getField (obsName, "obs", obsDescr)
         .aload1 () // obj
         .checkCast (m.getParameterTypes () [0]);
      if (withGroup)
         dc.aload2 (); // group

      dc.invoke (m)
         .return_ ().setMaxStack (2 + (withGroup ? 1 : 0)).endMethod ();

      return createInstance (dc, obs);
   }

   private Observer createInstance (DynClass dc, Object obs)
      throws BlinkException.Binding
   {
      try
      {
         Class<?> obsClass;
         Class<?> pojoObsClass = obs.getClass ();
         if (loadMode == LoadMode.Privileged)
            obsClass = dload.loadPrivileged (dc, pojoObsClass);
         else
            obsClass = dload.load (dc);
         Constructor<?> ctor = obsClass.getConstructor (pojoObsClass);
         return (Observer)ctor.newInstance (obs);
      }
      catch (NoSuchMethodException e)
      {
         throw new BlinkException.Binding (e);
      }
      catch (InstantiationException e)
      {
         throw new BlinkException.Binding (e);
      }
      catch (IllegalAccessException e)
      {
         throw new BlinkException.Binding (e);
      }
      catch (InvocationTargetException e)
      {
         throw new BlinkException.Binding (e);
      }
   }
   
   private Observer findInAncestry (Schema.Group g)
   {
      if (g != null)
      {
         Observer obs = obsByName.get (g.getName ());
         if (obs != null)
         {
            obsByName.put (g.getName (), obs);
            return obs;
         }
         else
            return findInAncestry (g.getSuperGroup ());
      }
      else
         return fallback;
   }

   private static String makeUnique (String s)
   {
      return s + uniqueId.getAndIncrement ();
   }

   private LoadMode loadMode;
   private final HashMap<NsName, Observer> obsByName =
      new HashMap <NsName, Observer> ();
   private final ObjectModel om;
   private final DynClassLoader dload;
   private final Dependent omDep;
   private final ArrayList<PendObs> pendObservers = new ArrayList<PendObs> ();
   private Observer fallback;
   private static AtomicInteger uniqueId = new AtomicInteger ();
   private boolean dirty = true;
}
