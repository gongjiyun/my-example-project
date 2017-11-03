package com.xcloud.hadoop.mpr;

import java.io.IOException;
import java.net.URI;
import java.util.StringTokenizer;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.util.GenericOptionsParser;

import com.xcloud.framework.constants.ServerConstants;
import com.xcloud.hadoop.util.ConfigurationClass;

public class CountIP {
	public static class TokenizerMapper extends org.apache.hadoop.mapreduce.Mapper<Object, Text, Text, IntWritable> {
		private static final Log LOG = LogFactory.getLog(TokenizerMapper.class);
		private final static IntWritable one = new IntWritable(1);
		private Text word = new Text();

		@Override
		public void map(Object key, Text value, Context context)
				throws IOException, InterruptedException {
			StringTokenizer itr = new StringTokenizer(value.toString());
			context.setStatus("key=" + key.toString() + " value=" + value.toString());
			if (itr.hasMoreTokens()) {
				word.set(itr.nextToken());
				context.write(word, one);
			}
		}

		
		/*		
		public void map(Object key, Text value,
				OutputCollector<Text, IntWritable> output, Reporter reporter)
				throws IOException {
			LOG.info("key=" + key.toString() + " value=" + value.toString());
			StringTokenizer itr = new StringTokenizer(value.toString());
			while (itr.hasMoreTokens()) {
				word.set(itr.nextToken());
				output.collect(word, one);
			}	
		}*/
	}

	public static class IntSumReducer extends
			org.apache.hadoop.mapreduce.Reducer<Text, IntWritable, Text, IntWritable> {
		private static final Log LOG = LogFactory.getLog(IntSumReducer.class);
		private IntWritable result = new IntWritable();

		@Override
		public void reduce(Text key, Iterable<IntWritable> values,
				Context context) throws IOException, InterruptedException {
			int sum = 0;
			for (IntWritable val : values) {
				sum += val.get();
			}
			
			result.set(sum);
			LOG.info(context.getStatus());
			context.write(key, result);
		}

		/*public void reduce(Text key, Iterator<IntWritable> values,
				OutputCollector<Text, IntWritable> output, Reporter reporter)
				throws IOException {
			int sum = 0;
			while(values.hasNext()){
				sum += values.next().get();
			}
			result.set(sum);
			LOG.info("RESULT ##### key=" + key.toString() + " value=" + sum);
			output.collect(key, result);
		}*/
	}

	public static void main(String[] args) throws Exception {
		URI uri = new URI("hdfs://" + ServerConstants.SERVER_HOST + ":" + "9000");
		Configuration conf = ConfigurationClass.getCongfiguration();        
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		if (otherArgs.length != 2) {
			System.err.println("Usage: wordcount <in> <out>");
			System.exit(2);
		}
		Job jconfig = Job.getInstance(conf);
		jconfig.setJarByClass(CountIP.class);
		jconfig.setMapperClass(TokenizerMapper.class);
		jconfig.setCombinerClass(IntSumReducer.class);
		jconfig.setReducerClass(IntSumReducer.class);
		jconfig.setOutputKeyClass(Text.class);
		jconfig.setOutputValueClass(IntWritable.class);
		org.apache.hadoop.mapreduce.lib.input.FileInputFormat.addInputPath(jconfig, new Path(otherArgs[0]));
		org.apache.hadoop.mapreduce.lib.output.FileOutputFormat.setOutputPath(jconfig, new Path(otherArgs[1]));
		
		System.out.println("JOB DONE");
		System.exit(jconfig.waitForCompletion(true) ? 0 : 1);
	}
}
