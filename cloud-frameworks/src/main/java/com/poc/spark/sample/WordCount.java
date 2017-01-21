package com.poc.spark.sample;


import java.io.Serializable;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;

public class WordCount implements IConsoleExecutor, Serializable{

	private static final long serialVersionUID = 1L;
	private JavaSparkContext sc;

	public void execute(String[] args) throws Exception{
		//String logFile = "file://" + SPARK_HOME + "README.md"; // Should be some file on your system
		String logFile = args[0];
		SparkConf conf = new SparkConf();

		conf.setAppName("Word Count Application");
		conf.setSparkHome(SPARK_HOME);
		conf.setMaster(SPARK_MASTER);
		conf.setJars(new String[]{"/app/jars/cloud-frameworks-1.0-SNAPSHOT.jar", "/app/jars/common-utils-1.0-SNAPSHOT.jar"});

		sc = new JavaSparkContext(conf);
		sc.setLogLevel("ALL");

		JavaRDD<String> logData = sc.textFile(logFile).cache();

		long count = logData.map((s) ->{
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
		}).count();
		

		sc.close();
		System.out.println("word count: " + count);
	}
	

}
