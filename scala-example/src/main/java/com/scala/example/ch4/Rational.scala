package com.scala.example.ch4

/**
  * Created by Administrator on 2017-1-20.
  */
class Rational(n:Int, d:Int) {

  def this(n:Int) = this(n, 1);

  def g:Int = gcd(n, d);

  require(d!=0);

  val number:Int = n / g;
  val demon:Int = d / g;

  override def toString: String = number + "/" + demon;

  def add(that:Rational): Rational = {
    return new Rational(that.number * demon + that.demon * number , that.demon * demon);
  }

  def lessThan(that:Rational):Boolean = {
    this.number < that.demon;
  }

  def * (that:Rational):Rational = {
    return new Rational(that.number * number, that.demon * demon);
  }

  def gcd(a:Int, b:Int):Int = {
    if(b == 0){
      return a;
    }
    return gcd(b, b%a);
  }
}
