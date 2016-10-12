package mytest.nio;

import java.nio.ByteBuffer;

public class ByteBufferTest {

	public static void main(String[] args) {
		String test = "ABCDEFGHI";
			
		ByteBuffer bf = ByteBuffer.allocate(1024);
		System.out.println(bf.toString());
		bf.put((byte)'J');
		bf.put((byte)'K');
		bf.flip();
		System.out.println("-------------");
		while(bf.hasRemaining()){
			System.out.println((char)bf.get());
		}
		System.out.println("-------------");
	}

}
