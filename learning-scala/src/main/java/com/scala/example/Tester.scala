package com.scala.example;

import com.scala.example.practice.Rational

/**
  * Created by Administrator on 2017-1-20.
  */
object Tester {

  def main(args: Array[String]): Unit = {
    val optional1 = new Rational(10);
    val optional2 = new Rational(4, 11);

    if(!args.isEmpty){
      println(args(0))
    }
    
    //println("Less than " + (optional1 lessThan optional2));
    
    this.testYield();

  }
  
  def g():Int = {try return 1 finally return 2};
  
  def testswitch(value:String):Unit = {
    val res = 
      value match {
        case "apple" => "apple1";
        case "orange" => "orange1";
        case _ => "nothing";
      }
    println(res);
  }
  
  def testYield():Unit = {
    val arr:Array[String] = new Array[String](3);
    arr(0) = "test1";
    arr(1) = "test2";
    arr(2) = "test3";
    def resstr = for {
      a <- arr;
      if a.startsWith("test")
    } yield (a + "XXX")
    
    resstr.foreach(a => println(a))
  }
  

}
