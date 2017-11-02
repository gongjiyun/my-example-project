package com.xxooframe.spark.sample;


import java.util.StringTokenizer;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.Function2;
import org.apache.spark.api.java.function.PairFunction;
import org.apache.spark.api.java.function.VoidFunction;

import scala.Tuple2;

public class IpCount implements IConsoleExecutor{

	/**
	 * spark submit shell
	 */
	private static final long serialVersionUID = 4845832945425812801L;

	public void execute(String[] args) throws Exception{
		String logFile = args[0];
		SparkConf conf = new SparkConf();
		conf.setAppName("save2HDFS");
		
		JavaSparkContext sc = new JavaSparkContext(conf);
		sc.setLogLevel("ALL");

		JavaRDD<String> logData = sc.textFile(logFile).cache();

		/*JavaPairRDD<String, Long> collection = logData.mapPartitionsToPair(new PairFlatMapFunction<Iterator<String>, String, Long>() {
			private static final long serialVersionUID = 1L;

			@Override
			public Iterator<Tuple2<String, Long>> call(Iterator<String> arg0) throws Exception {
				List<Tuple2<String, Long>> result = new ArrayList<Tuple2<String, Long>>();
				while(arg0.hasNext()){
					String str = arg0.next();
					Tuple2<String, Long> t = Tuple2.apply(str, 1L);
					result.add(t);
				}
				return result.iterator();
			}

		});*/
		
		JavaPairRDD<String, Long> collection = logData.mapToPair(new PairFunction<String, String, Long>() {
			private static final long serialVersionUID = 6426733012162229981L;

	        public Tuple2<String, Long> call(String value) throws Exception {
	        	StringTokenizer itr = new StringTokenizer(value.toString());
	            return new Tuple2<String, Long>(itr.nextElement().toString(), 1L);
	        }
	    });
		
		/*JavaPairRDD<String, Long> collection = logData.mapToPair((s) -> {
			return new Tuple2<String, Long>(s, 1L);
	    });*/
		
		collection = collection.reduceByKey(new Function2<Long, Long, Long>() {
			private static final long serialVersionUID = -2389930225158985969L;
			public Long call(Long arg0, Long arg1) throws Exception {
				long v1 = arg0.longValue();
				long v2 = arg1.longValue();
				return v1 + v2;
			}
			
		});

		
		collection.foreach(new VoidFunction<Tuple2<String,Long>>(){

			private static final long serialVersionUID = -8752163892038614711L;

			@Override
			public void call(Tuple2<String, Long> arg0) throws Exception {
				System.out.println(arg0._1 + " : " + arg0._2);
			}
			
		});
		
		collection.repartition(1).saveAsTextFile("/usr/spark/ipcount");

		sc.close();
	}
	

}
