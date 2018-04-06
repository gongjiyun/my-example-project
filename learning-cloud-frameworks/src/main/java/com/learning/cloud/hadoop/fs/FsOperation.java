package com.learning.cloud.hadoop.fs;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URI;

import com.learning.cloud.framework.constants.ServerConstants;
import com.learning.cloud.hadoop.util.ConfigurationClass;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.fs.PathFilter;
import org.apache.hadoop.io.IOUtils;
import org.junit.Test;

public class FsOperation {
	
	private static Configuration conf = ConfigurationClass.getCongfiguration();

	public static void main(String[] args) throws Exception {
		FsOperation fsop = new FsOperation();
		fsop.listFileStatus();
	}
	
	@Test
	public void listFileStatus() throws Exception {        
        Path path = new Path("/usr/example/input");
        FileSystem fs = FileSystem.newInstance(conf);
        System.out.println(FileSystem.getDefaultUri(conf));
        
        /*RemoteIterator<LocatedFileStatus> itfs = fs.listFiles(path, true);
        while(itfs.hasNext()){
        	LocatedFileStatus lfs = itfs.next();
        	System.out.println(lfs.toString());
        }*/
        
        System.out.println("##############################");
        FileStatus[] filestatuses = fs.listStatus(path, new PathFilter() {
			@Override
			public boolean accept(Path path) {
				return true;
				//return path.toString().matches(".*/tmp");
			}
		});
        for(FileStatus fss : filestatuses){
        	System.out.println(fss.toString());
        }
        
	}
	
	
	public void putFiles() throws Exception{
		//URI uri = new URI("hdfs://" + HadoopUtilConstants.SERVER_HOST + ":" + "9000");
        FileSystem fs = FileSystem.get(conf);
		try {
			System.out.println("put files to " + fs.getUri() + "/usr/example/input/");
			//fs.copyFromLocalFile(new Path("file:///usr/example/input/test.jpg"), new Path("/usr/example/input/"));
			//fs.moveFromLocalFile(new Path("file:///usr/example/input/test.jpg"), new Path("/usr/example/input/"));
			
			System.out.println("get files from " + fs.getUri() + "/usr/example/input");
			if(!fs.exists(new Path("/usr/example/input/test.jpg"))){
				System.out.println("file not exist");
				return;
			}
			
			FSDataInputStream fin = fs.open(new Path("/usr/example/input/test.jpg"));
			FileOutputStream fos = new FileOutputStream("/usr/example/input/test.jpg");
			IOUtils.copyBytes(fin, fos, 2048, true);
			
			//throw exception of permission
			//fs.copyToLocalFile(true, new Path("/usr/example/input/test.jpg"), new Path("file:///usr/example/output/"));
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
