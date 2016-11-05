package com.poc.spark.sample;


import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.Function;

import java.io.Serializable;

public class WordCount implements IConsoleExecutor, Serializable{

	private static final long serialVersionUID = 1L;

	public void execute(String[] args) throws Exception{
		//String logFile = "file://" + SPARK_HOME + "README.md"; // Should be some file on your system
		String logFile = "file://" + args[0];
		SparkConf conf = new SparkConf();

		conf.setAppName("Word Count Application");
		conf.setSparkHome(SPARK_HOME);
		conf.setMaster(SPARK_MASTER);

		JavaSparkContext sc = new JavaSparkContext(conf);

		sc.setLogLevel("ALL");

		JavaRDD<String> logData = sc.textFile(logFile).cache();

		JavaRDD<String> maps = logData.map((s) ->{
				String[] keystr = s.split(" ");
				if(keystr!=null){
					for(int i=0; i<keystr.length; i++){
						String word = keystr[i].trim();
						if(word!=null && !"".equals(word.trim())){
							return word;
						}
					}
				}
				return null;
		});

		long numBs = logData.filter(new Function<String, Boolean>() {
			private static final long serialVersionUID = 1L;

			public Boolean call(String s) {
				return s.contains("b");
			}
		}).count();

		sc.close();
		System.out.println("Lines with a: " + maps.count() + ", lines with b: " + numBs);
	}
	

}
