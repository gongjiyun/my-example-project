package com.jiyun.example.nio;

import java.nio.CharBuffer;

public class CharBufferTest {

	public static void main(String[] args) {
		CharBuffer buffer = CharBuffer.allocate(10);
		buffer.put("o");
		buffer.put("o");
		buffer.put("o");
		buffer.put("o");
		buffer.put("o");
		buffer.put("o");
		buffer.put("o");
		buffer.put("x");
		buffer.flip();
		System.out.println(buffer.length());
		while(buffer.hasRemaining()){
			System.out.println(buffer.get());
		}
		System.out.println(buffer.length());
		
	}

}
