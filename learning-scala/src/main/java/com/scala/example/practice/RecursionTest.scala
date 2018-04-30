package com.scala.example.practice;

object RecursionTest {
  
  def main(args: Array[String]): Unit = {
    println(tailRec(20, 1, 2));
  }
  
  
  /**
   * 1, 2, 3, 5, 8...an = (n-1)+n-2
   */
  def tailRec(n:Int, acc1:Int, acc2:Int):Int = {
    if(n<2){
      return acc2;
    }else{
      return tailRec(n-1, acc2, acc1 + acc2);
    }
  }
  
}