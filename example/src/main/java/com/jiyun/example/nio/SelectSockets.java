package com.jiyun.example.nio;

import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.nio.ByteBuffer;
import java.nio.channels.Channels;
import java.nio.channels.SelectableChannel;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.nio.channels.WritableByteChannel;
import java.util.Iterator;

public class SelectSockets {
	public static int PORT_NUMBER = 1234;

	public static void main(String[] argv) throws Exception {
		new SelectSockets().go(argv);
	}

	public void go(String[] argv) throws Exception {
		int port = PORT_NUMBER;
		if (argv.length > 0) { // Override default listen port
			port = Integer.parseInt(argv[0]);
		}
		System.out.println("Listening on port " + port); 
		ServerSocketChannel serverChannel = ServerSocketChannel.open();
		ServerSocket serverSocket = serverChannel.socket();

		Selector selector = Selector.open();

		serverSocket.bind(new InetSocketAddress(port));

		serverChannel.configureBlocking(false);

		serverChannel.register(selector, SelectionKey.OP_ACCEPT);
		while (true) {
			// This may block for a long time. Upon returning, the
			// selected set contains keys of the ready channels.
			int n = selector.select();
			if (n == 0) {
				continue; // nothing to do
			}
			// Get an iterator over the set of selected keys
			Iterator it = selector.selectedKeys().iterator();
			// Look at each key in the selected set
			while (it.hasNext()) {
				SelectionKey key = (SelectionKey) it.next();
				if (key.isAcceptable()) {
					ServerSocketChannel server = (ServerSocketChannel) key
							.channel();
					SocketChannel channel = server.accept();
					registerChannel(selector, channel, SelectionKey.OP_READ);
					sayHello(channel);
				}
				
				// Is there data to read on this channel?
				if (key.isReadable()) {
					readDataFromSocket(key);
				}
				// Remove key from selected set; it's been handled
				it.remove();
			}
		}
	}

	// ---------------------------------------------------------- /** *
	// Register the given channel with the given selector for the given *
	// operations of interest */

	protected void registerChannel(Selector selector,
			SelectableChannel channel, int ops) throws Exception {
		if (channel == null) {
			return;
		}
		channel.configureBlocking(false);
		// Register it with the selector
		channel.register(selector, ops);
	}

	// ----------------------------------------------------------
	// Use the same byte buffer for all channels. A single thread is
	// servicing all the channels, so no danger of concurrent acccess.
	private ByteBuffer buffer = ByteBuffer.allocateDirect(1024);

	protected void readDataFromSocket(SelectionKey key) throws Exception {
		SocketChannel socketChannel = (SocketChannel) key.channel();
		int count;
		buffer.clear();
		// Empty buffer
		// Loop while data is available; channel is nonblocking
		
		WritableByteChannel wc = Channels.newChannel(System.out);
		while ((count = socketChannel.read(buffer)) > 0) {
			buffer.flip();
			// Make buffer readable
			// Send the data; don't assume it goes all at once
			
			/*while (buffer.hasRemaining()) {
				socketChannel.write(buffer);
			}*/

			while(buffer.hasRemaining()){
				wc.write(buffer);
			}
			
			//wc.close();
			
			// WARNING: the above loop is evil. Because
			// it's writing back to the same nonblocking
			// channel it read the data from, this code can
			// potentially spin in a busy loop. In real life
			// you'd do something more useful than this.
			buffer.clear();
			// Empty buffer
		}
		if (count < 0) {
			// Close channel on EOF, invalidates the key
			socketChannel.close();
		}
	}

	// ----------------------------------------------------------
	/**
	 * * Spew a greeting to the incoming client connection. * * @param channel *
	 * The newly connected SocketChannel to say hello to.
	 */
	private void sayHello(SocketChannel channel) throws Exception {
		buffer.clear();
		buffer.put("Hi there!\r\n".getBytes());
		buffer.flip();
		channel.write(buffer);
	}

}