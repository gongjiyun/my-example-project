package com.poc.hadoop.mpr;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.WritableComparator;

public class RawTextPair extends WritableComparator {
	
	private Text name;
	private Text group;


	@Override
	public int compare(byte[] arg0, int arg1, int arg2, byte[] arg3, int arg4,
			int arg5) {
		
		// TODO Auto-generated method stub
		return super.compare(arg0, arg1, arg2, arg3, arg4, arg5);
	}
}
