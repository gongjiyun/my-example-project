package com.poc.spark.sample;

public interface ConsoleExecutor {
	public final static String SPARK_HOME = "/usr/local/spark-1.6.1/";
	public final static String SPARK_MASTER = "";
	
	public void execute(String[] args) throws Exception;

}
