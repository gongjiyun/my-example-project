package com.scala.example.practice.pck1 {
  
  abstract class SampleC1{
    val v1:String = "test";
    val v2:Int = 0;
  }
  
  package p0 {
    class SampleC2{
      val v1:String = "test";
      val v2:Int = 0;
    }
  }
  
  package p1 {
    class P1c (p1:String, p2:String) {
      
    }
    
    package p11 {
      class Pc1c11 {
        
        def test():Unit = {
          println("test");
        }
        
        val pc0 = new p11.Pc2c11();
        val pc1 = new P1c("1", "2");
        val pc2 = new p0.SampleC2();
        
      }
      
      class Pc2c11 extends SampleC1{
        
      }
    }
  }
  
}