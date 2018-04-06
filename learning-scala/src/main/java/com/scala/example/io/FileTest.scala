package com.scala.example.io

import java.io.File
import java.io.PrintWriter

/**
  * Created by Administrator on 2017-1-12.
  */
object FileTest {

  def main(args: Array[String]): Unit = {
    var fileReader = new FileOperator();
    fileReader.withPrintWriter(new File("/usr/logs/xxooframe-log.log"))(writer => writer.println("new line"));
    fileReader.readFile(null);
    fileReader.listFile(".");

  }

}
