// Generated by blinkc.js

package com.pantor.blink.msg.blink;

public class FieldDef extends Annotated
{
  public java.lang.String getName () { return m_Name; }
  public void setName (java.lang.String v) { m_Name = v; }
  public int getId () { return m_Id; }
  public boolean hasId () { return has_Id; }
  public void clearId () { has_Id = false; }
  public void setId (int v) { m_Id = v; has_Id = true; }
  public TypeDef getType () { return m_Type; }
  public void setType (TypeDef v) { m_Type = v; }
  public boolean getOptional () { return m_Optional; }
  public void setOptional (boolean v) { m_Optional = v; }
  
  private boolean has_Id;
  
  private java.lang.String m_Name;
  private int m_Id;
  private TypeDef m_Type;
  private boolean m_Optional;
}

