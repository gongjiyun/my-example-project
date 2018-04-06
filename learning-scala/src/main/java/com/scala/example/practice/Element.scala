package com.scala.example.practice

abstract class Element {
  
  def content:Array[String];
  
  def addEle(el:String):Unit = {};
  
  def length:Long = content.length;
  
  def length2():Long = content.length;
  
}