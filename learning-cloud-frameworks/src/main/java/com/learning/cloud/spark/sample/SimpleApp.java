package com.learning.cloud.spark.sample;

import java.io.Serializable;

import com.learning.cloud.framework.constants.ServerConstants;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.Function;

public class SimpleApp implements IConsoleExecutor, Serializable{

	private static final long serialVersionUID = 1L;

	public void execute(String[] args) throws Exception{
		String logFile = args[0];
		SparkConf conf = new SparkConf();
		conf.setAppName("Simple Application");
		conf.setSparkHome(SPARK_HOME);
		conf.setMaster(SPARK_MASTER);
		conf.setJars(new String[]{"/app/jars/cloud-frameworks-1.0-SNAPSHOT.jar", "/app/jars/common-utils-1.0-SNAPSHOT.jar"});

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
	
	@org.junit.Test
	public void test() throws Exception{
		SimpleApp app = new SimpleApp();
		app.execute(new String[]{"hdfs://" + ServerConstants.SERVER_HOST + ":9000" + "/usr/access_2013_05_31.log"});
	}

}
