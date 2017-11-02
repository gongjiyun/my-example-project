package com.scala.example.io

import scala.io.Source
import scala.reflect.io.File
import java.io.PrintWriter
import java.io.File
import scala.reflect.io.File

/**
  * Created by Administrator on 2017-1-12.
  */
class FileOperator {

  def readFile(args: Array[String]): Unit = {
    val buffer: scala.io.BufferedSource = Source.fromFile("/usr/logs/xxooframe-log.log")(scala.io.Codec.fallbackSystemCodec);
    //buffer.getLines().foreach((line: String) => println(line));
    
    def widthOfLength(s: String) = s.length;

    val lines = buffer.getLines.toList;
    val longest = lines.reduceLeft(
      (a, b) => if (a.length > b.length) {
        a;
      } else {
        b;
      }
    );

    val maxWidth = widthOfLength(longest);

    for (line <- lines) {
      var numberSpace = maxWidth - widthOfLength(line);
      val padding = " " * numberSpace;
      System.out.println(padding + "|" + line)
    }

    buffer.close()
  }
  
  def listFile(path:String): Unit = {
    val fileDir:scala.reflect.io.File = scala.reflect.io.File.apply(path);
    fileDir.ifDirectory((f) => {
      val listFile = f.list;
      for(file <- listFile){
        println(file.toString())        
      }
    });
    
    //var dir:Directory = fileDir.toDirectory;
    
  }
  
  def withPrintWriter(file:java.io.File)(op:PrintWriter => Unit){
    val writer = new PrintWriter(file);
    try{
     op(writer);
    }    
    finally {
      writer.close()
    }
  }


}
