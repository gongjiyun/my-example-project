package com.scala.example

import com.scala.example.ch4.Rational

/**
  * Created by Administrator on 2017-1-20.
  */
object Tester {

  def main(args: Array[String]): Unit = {
    val optional1 = new Rational(10);
    val optional2 = new Rational(4, 11);

    println("Less than " + (optional1 lessThan optional2));

  }

}
