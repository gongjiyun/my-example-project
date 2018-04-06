package com.learning.example.nio;

import java.nio.CharBuffer;

import org.junit.Test;

public class BufferTest {

	private static String[] strings = { "A random string value",
			"The product of an infinite number of monkeys",
			"Hey hey we're the Monkees",
			"Opening act for the Monkees: Jimi Hendrix",
			"'Scuse me while I kiss this fly", "Help Me! Help Me!", };
	private static int index = 0;

	public static void main(String[] argv) throws Exception {
		CharBuffer buffer = CharBuffer.allocate(100);
		while (fillBuffer(buffer)) {
			buffer.flip();
			drainBuffer(buffer);
			buffer.clear();
		}
	}

	private static void drainBuffer(CharBuffer buffer) {
		while (buffer.hasRemaining()) {
			System.out.print(buffer.get());
		}
		System.out.println("");
	}

	private static boolean fillBuffer(CharBuffer buffer) {
		if (index >= strings.length) {
			return (false);
		}
		String string = strings[index++];
		for (int i = 0; i < string.length(); i++) {
			buffer.put(string.charAt(i));
		}

		return (true);
	}
	
	@Test
	public void testCompare(){
		CharBuffer buffer1 = CharBuffer.allocate(100);
		buffer1.put("abcdefg");
		buffer1.flip();
		buffer1.position(1).mark();
		
		CharBuffer buffer2 = CharBuffer.allocate(100);
		buffer2.put("abcdefg");
		buffer2.flip();
		System.out.println(buffer2.get());
		
		System.out.println(buffer1.equals(buffer2));
		
	}

}
