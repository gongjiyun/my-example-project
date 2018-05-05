package com.xcloud.hadoop.mpr;

import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

public class SampleMpr extends Configured implements Tool{

	@Override
	public int run(String[] arg0) throws Exception {
		if(arg0.length!=2){
			ToolRunner.printGenericCommandUsage(System.err);
			return -1;
		}
		System.out.println("SampleMpr run ...");
		
		
		System.out.println("SampleMpr run end");
		return 0;
	}
	
	public static void main(String[] args) throws Exception {
		int exitCode = ToolRunner.run(new SampleMpr(), args);
		System.exit(exitCode);
	}
}
