package com.jiyun.example.nio;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.nio.ByteBuffer;
import java.nio.channels.SelectableChannel;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

public class SelectSocketsThreadPool {
	public static int PORT_NUMBER = 1234;
	private static final int MAX_THREADS = 5;
	private ThreadPool pool = new ThreadPool(MAX_THREADS);

	// -------------------------------------------------------------
	public static void main(String[] argv) throws Exception {
		new SelectSocketsThreadPool().go(argv);
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
				}// Is there data to read on this channel?
				if (key.isReadable()) {
					readDataFromSocket(key);
				}
				// Remove key from selected set; it's been handled
				it.remove();
			}
		}
	}

	protected void registerChannel(Selector selector,
			SelectableChannel channel, int ops) throws Exception {
		if (channel == null) {
			return;
		}
		channel.configureBlocking(false);
		// Register it with the selector
		channel.register(selector, ops);
	}

	private void sayHello(SocketChannel channel) throws Exception {
		buffer.clear();
		buffer.put("Hi there!\r\n".getBytes());
		buffer.flip();
		channel.write(buffer);
	}

	protected void readDataFromSocket(SelectionKey key) throws Exception {

		WorkerThread worker = pool.getWorker();
		if (worker == null) {
			// No threads available. Do nothing. The selection
			// loop will keep calling this method until a
			// thread becomes available. This design could
			// be improved.
			return;
		}
		// Invoking this wakes up the worker thread, then returns
		worker.serviceChannel(key);
	}

	private class ThreadPool {
		List idle = new LinkedList();

		ThreadPool(int poolSize) { // Fill up the pool with worker threads
			for (int i = 0; i < poolSize; i++) {
				WorkerThread thread = new WorkerThread(this); // Set thread name
																// for
																// debugging.
																// Start it.
				thread.setName("Worker" + (i + 1));
				thread.start();
				idle.add(thread);
			}
		}

		/** * Find an idle worker thread, if any. Could return null. */
		WorkerThread getWorker() {
			WorkerThread worker = null;
			synchronized (idle) {
				if (idle.size() > 0) {
					worker = (WorkerThread) idle.remove(0);
				}
			}
			return (worker);
		}

		/** * Called by the worker thread to return itself to the idle pool. */
		void returnWorker(WorkerThread worker) {
			synchronized (idle) {
				idle.add(worker);
			}
		}
	}

	private ByteBuffer buffer = ByteBuffer.allocateDirect(1024);

	private class WorkerThread extends Thread {
		private ByteBuffer buffer = ByteBuffer.allocate(1024);
		private ThreadPool pool;
		private SelectionKey key;

		WorkerThread(ThreadPool pool) {
			this.pool = pool;
		}

		public synchronized void run() {
			System.out.println(this.getName() + " is ready");
			while (true) {
				try { // Sleep and release object lock
					this.wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
					// Clear interrupt status
					this.interrupted();
				}
				if (key == null) {
					continue; // just in case
				}
				System.out.println(this.getName() + " has been awakened");
				try {
					drainChannel(key);
				} catch (Exception e) {
					System.out.println("Caught '" + e + "' closing channel");
					// Close channel and nudge selector
					try {
						key.channel().close();
					} catch (IOException ex) {
						ex.printStackTrace();
					}
					key.selector().wakeup();
				}
				key = null;
				// Done. Ready for more. Return to pool
				this.pool.returnWorker(this);
			}
		}

		synchronized void serviceChannel(SelectionKey key) {
			this.key = key;
			key.interestOps(key.interestOps() & (~SelectionKey.OP_READ));
			this.notify();
			// Awaken the thread
		}

		void drainChannel(SelectionKey key) throws Exception {
			SocketChannel channel = (SocketChannel) key.channel();
			int count;
			buffer.clear();
			// Empty buffer
			// Loop while data is available; channel is nonblocking
			while ((count = channel.read(buffer)) > 0) {
				buffer.flip(); // make buffer readable
				// Send the data; may not go all at once
				while (buffer.hasRemaining()) {
					channel.write(buffer);
				}
				// WARNING: the above loop is evil.
				// See comments in superclass.
				buffer.clear();
				// Empty buffer
			}
			if (count < 0) { // Close channel on EOF; invalidates the key
				channel.close();
				return;
			}// Resume interest in OP_READ
			key.interestOps(key.interestOps() | SelectionKey.OP_READ);
			// Cycle the selector so this key is active again
			key.selector().wakeup();
		}
	}

}
