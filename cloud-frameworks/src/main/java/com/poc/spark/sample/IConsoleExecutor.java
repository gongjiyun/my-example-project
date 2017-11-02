package com.xxooframe.spark.sample;

import java.io.Serializable;

public interface IConsoleExecutor extends Serializable{
	public final static String SPARK_HOME = "/usr/local/spark-2.0.0-bin-hadoop2.6/";
	public final static String SPARK_MASTER = "spark://master:7077";
	
	public void execute(String[] args) throws Exception;

}
