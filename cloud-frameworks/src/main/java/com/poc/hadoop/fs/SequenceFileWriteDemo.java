package com.xxooframe.hadoop.fs;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileContext;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.SequenceFile;
import org.apache.hadoop.io.Text;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;

import com.xxooframe.framework.constants.ServerConstants;
import com.xxooframe.hadoop.util.ConfigurationClass;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class SequenceFileWriteDemo {
	private static Configuration conf = ConfigurationClass.getCongfiguration();

	@Test()
	public void write() throws Exception{
		System.out.println("write start");
		String uri = "hdfs://" + ServerConstants.SERVER_HOST + ":" + "9000" + "/usr/output/_sequence0.seq";
		Path path = new Path(uri);
		FileSystem fs = FileSystem.get(conf);
		FileContext fc = FileContext.getFileContext(conf);
		
		IntWritable key = new IntWritable(1);
		Text value = new Text("test demo");
		
		//SequenceFile.Writer writer = SequenceFile.createWriter(conf, new SequenceFile.Writer.Option.);
		SequenceFile.Writer writer = SequenceFile.createWriter(fs, conf, path, IntWritable.class, Text.class);
		writer.append(key, value);
		writer.append(key, value);	
		writer.close();
		System.out.println("write end");
	}
	
	@Test
	public void read() throws Exception{
		System.out.println("read start");
		String uri = "hdfs://" + ServerConstants.SERVER_HOST + ":" + "9000" + "/usr/output/_sequence0.seq";
		Path path = new Path(uri);
		FileSystem fs = FileSystem.get(conf);
		FileContext fc = FileContext.getFileContext(conf);

		IntWritable key = new IntWritable();
		Text value = new Text();
		SequenceFile.Reader reader = new SequenceFile.Reader(fs, path, conf);
        while(reader.next(key, value)){
            System.out.println(key);
            System.out.println(value);
        }
        reader.close();
        System.out.println("write end");
	}
}
