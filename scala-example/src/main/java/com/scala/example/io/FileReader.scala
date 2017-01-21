package com.scala.example.io

import scala.io.Source;

/**
  * Created by Administrator on 2017-1-12.
  */
class FileReader {

  def readFile(args: Array[String]): Unit = {
    val buffer: scala.io.BufferedSource = Source.fromFile("/usr/logs/poc-log.log")(scala.io.Codec.fallbackSystemCodec);
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
      //println(padding + "|" + line)
    }

    buffer.close()
  }


}
