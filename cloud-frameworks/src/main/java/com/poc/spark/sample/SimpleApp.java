package com.poc.spark.sample;

import java.io.Serializable;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.Function;

public class SimpleApp implements IConsoleExecutor, Serializable{

	private static final long serialVersionUID = 1L;

	public void execute(String[] args) throws Exception{
		String logFile = "file://" + SPARK_HOME + "README.md"; // Should be some file on your system
		SparkConf conf = new SparkConf();
		conf.setAppName("Simple Application");
		conf.setSparkHome(SPARK_HOME);
		conf.setMaster(SPARK_MASTER);

		JavaSparkContext sc = new JavaSparkContext(conf);
		sc.setLogLevel("ALL");

		JavaRDD<String> logData = sc.textFile(logFile).cache();

		long numAs = logData.filter(new Function<String, Boolean>() {
			private static final long serialVersionUID = 1L;

			public Boolean call(String s) {
				return s.contains("a");
			}
		}).count();

		long numBs = logData.filter(new Function<String, Boolean>() {
			private static final long serialVersionUID = 1L;

			public Boolean call(String s) {
				return s.contains("b");
			}
		}).count();

		sc.close();
		System.out.println("Lines with a: " + numAs + ", lines with b: " + numBs);
	}
	

}
