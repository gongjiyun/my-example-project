package com.poc.spark.sample;

public interface IConsoleExecutor {
	public final static String SPARK_HOME = "/usr/local/spark-1.6.1/";
	public final static String SPARK_MASTER = "local";
	
	public void execute(String[] args) throws Exception;

}
