package com.poc.hadoop.fs;

import java.io.InputStream;
import java.net.URI;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;

import com.poc.framework.constants.ServerConstants;
import com.poc.hadoop.util.ConfigurationClass;

public class CopyFile2HDFS {
	
	private static Configuration conf = ConfigurationClass.getCongfiguration();

	public static void main(String[] args) throws Exception {   
		CopyFile2HDFS instance = new CopyFile2HDFS();
		instance.putFiles();
	}
	

	
	public void putFiles() throws Exception{
		URI uri = new URI("hdfs://" + ServerConstants.SERVER_HOST + ":" + "9000");
        FileSystem fs = FileSystem.get(uri, conf);
		try {
			System.out.println("put files to " + fs.getUri() + "/usr/example/input/");
			fs.copyFromLocalFile(new Path("file:///apps/hadoop-2.6.4/etc/hadoop/capacity-scheduler.xml"), new Path("/usr/example/input/"));
			fs.copyFromLocalFile(new Path("file:///apps/hadoop-2.6.4/etc/hadoop/core-site.xml"), new Path("/usr/example/input/"));
			fs.copyFromLocalFile(new Path("file:///apps/hadoop-2.6.4/etc/hadoop/hdfs-site.xml"), new Path("/usr/example/input/"));
			fs.copyFromLocalFile(new Path("file:///apps/hadoop-2.6.4/etc/hadoop/httpfs-site.xml"), new Path("/usr/example/input/"));
			fs.copyFromLocalFile(new Path("file:///apps/hadoop-2.6.4/etc/hadoop/kms-site.xml"), new Path("/usr/example/input/"));
			fs.copyFromLocalFile(new Path("file:///apps/hadoop-2.6.4/etc/hadoop/yarn-site.xml"), new Path("/usr/example/input/"));
			fs.copyFromLocalFile(new Path("file:///apps/hadoop-2.6.4/etc/hadoop/kms-site.xml"), new Path("/usr/example/input/"));
			fs.copyFromLocalFile(new Path("file:///apps/hadoop-2.6.4/etc/hadoop/kms-acls.xml"), new Path("/usr/example/input/"));
			fs.copyFromLocalFile(new Path("file:///apps/hadoop-2.6.4/etc/hadoop/hadoop-policy.xml"), new Path("/usr/example/input/"));
		} catch (Exception e) {
			e.printStackTrace();
		}
        
	}

	
	public void deleteFiles() throws Exception{
		URI uri = new URI("hdfs://" + ServerConstants.SERVER_HOST + ":" + "9000");
        FileSystem fs = FileSystem.get(uri, conf);
        Path output = new Path("/usr/example/output/");
		try {
			System.out.println("/usr/example/output is directory : " + fs.isDirectory(output));
			FileStatus[] filestatuses = fs.listStatus(output);
			//FileStatus[] filestatuses = fs.globStatus(output);
	        for(FileStatus fss : filestatuses){
	        	System.out.println("delete path......" + fss.toString());
	        	fs.delete(fss.getPath(), true);
	        	System.out.println("delete done");
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
        
	}

	public void testURLAPI() throws Exception{
		URI uri = new URI("hdfs://" + ServerConstants.SERVER_HOST + ":" + "9000" 
				+ "/usr/input/log4j.properties");
        FileSystem fs = FileSystem.get(uri, conf);
		InputStream in = null;
		try {
	        in = fs.open(new Path(uri));
	        IOUtils.copyBytes(in, System.out, 4096, false);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			IOUtils.closeStream(in);
		}
        
	}

}
