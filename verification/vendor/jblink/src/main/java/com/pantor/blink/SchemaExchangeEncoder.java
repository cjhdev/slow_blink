// Copyright (c) 2015, Pantor Engineering AB
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

import java.util.List;
import java.util.ArrayList;
import java.util.HashSet;

public final class SchemaExchangeEncoder
{
   public SchemaExchangeEncoder (Schema schema)
   {
      this.schema = schema;
      this.builder = new SchemaMsgBuilder (schema);
      this.pendingDefs = new ArrayList<Object> ();
      this.declared = new HashSet<Long> ();
   }

   public boolean declare (Schema.Group g)
      throws BlinkException
   {
      if (! declared.contains (g.getTypeId ()))
      {
         builder.buildTransitive (g.getName (), declared, pendingDefs);
         return true;
      }
      else
         return false;
   }

   public void clear ()
      throws BlinkException
   {
      declared.clear ();
      declareBuiltins ();
   }

   private void declareBuiltins ()
      throws BlinkException
   {
      for (Schema.Group g : schema.getGroups ())
         if (g.getName ().getNs ().equals ("Blink"))
            declared.add (g.getTypeId ());
   }
   
   public boolean hasPendingDefs ()
   {
      return ! pendingDefs.isEmpty ();
   }
   
   public List<Object> flushPendingDefs ()
   {
      List<Object> tmp = pendingDefs;
      pendingDefs = new ArrayList<Object> ();
      return tmp;
   }

   private final Schema schema; 
   private final SchemaMsgBuilder builder;
   private final HashSet<Long> declared;
   private ArrayList<Object> pendingDefs;
}
