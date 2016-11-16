package com.jiyun.example.nio;

import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SocketChannel;

public class ConnectAsync {

	public static void main(String[] args) throws Exception {
		String host = "localhost";
		int port = 1234;

		InetSocketAddress addr = new InetSocketAddress(host, port);
		SocketChannel sc = SocketChannel.open();
		sc.configureBlocking(false);
		System.out.println("initiating connection");
		sc.connect(addr);
		while (!sc.finishConnect()) {
			doSomethingUseful();
		}
		System.out.println("connection established");
		
		sc.write(ByteBuffer.wrap("hello world!\n .......".getBytes()));

		ByteBuffer buf = ByteBuffer.allocate(1024);

		int numBytesRead;
		while ((numBytesRead = sc.read(buf)) != -1) {
			if (numBytesRead == 0) {
				try {
					Thread.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				continue;
			}

			buf.flip();
			while (buf.remaining() > 0) {
				System.out.print((char) buf.get());
			}
			buf.clear();
		}
		
		sc.close();
		System.out.println("connection close");
	}

	private static void doSomethingUseful() {
		// System.out.println("doing something useless");
	}
}
