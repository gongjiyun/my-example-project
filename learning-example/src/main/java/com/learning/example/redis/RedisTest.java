package com.learning.example.redis;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.ByteBuffer;
import java.nio.channels.ByteChannel;

import com.learning.example.Constants;

import redis.clients.jedis.Jedis;

public class RedisTest {

	private static final int PORT = 6379;
	
	private static Jedis redis = new Jedis(Constants.LINUX_HOST, PORT);
	
	public static void main(String[] args) throws Exception{
		redis.connect();
		System.out.println("keys -> " + redis.keys("*"));
		redis.close();
	}
	

	public void saveImages() throws Exception{

		FileInputStream fin = new FileInputStream(new File("/1443162979251.jpg"));
		ByteChannel channel = fin.getChannel();
		ByteBuffer bff = ByteBuffer.allocate(1024);
		
		ByteArrayOutputStream boutstream = new ByteArrayOutputStream();
		
		while(channel.read(bff)>0){
			bff.flip();
			byte[] bit = new byte[1024];
			bff.get(bit, 0, bff.limit());
			boutstream.write(bit);
			bff.clear();
		}
		
		redis.set("1443162979251".getBytes(), boutstream.toByteArray());
		boutstream.close();
		
		redis.close();
		fin.close();
	}
	

	public void getImages() throws Exception{
		FileOutputStream fout = new FileOutputStream(new File("/output.jpg"));
		
		byte[] bytes = new byte[1024];
		ByteArrayInputStream binstream = new ByteArrayInputStream(redis.get("1443162979251".getBytes()));

		while(binstream.read(bytes)!=-1){
			fout.write(bytes, 0, bytes.length);
			fout.flush();
		}

		binstream.close();
		
		redis.close();
		fout.close();
	}


}
