package com.scala.example.practice;

object MultiTest {

  def increase(more: Int) = (x: Int) => (x + more)

  def main(args: Array[String]): Unit = {
    val make10 = increase(100);
    val make9999 = increase(9999);
    println(make10.apply(12))
    println(make9999(20))
  }
  

}