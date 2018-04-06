package com.learning.example.nio.netty;

import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.nio.NioServerSocketChannel;


public class DispacherServer {

	    private int port;

	    public DispacherServer(int port) {
	        this.port = port;
	    }

	    public void run() throws Exception {
	    	
	        EventLoopGroup bossGroup = new NioEventLoopGroup(); // (1)
	        EventLoopGroup workerGroup = new NioEventLoopGroup();
	        try {
	            io.netty.bootstrap.ServerBootstrap b = new io.netty.bootstrap.ServerBootstrap(); // (2)
	            b.group(bossGroup, workerGroup).channel(NioServerSocketChannel.class) // (3)
	             .childHandler(new ChannelInitializer<io.netty.channel.socket.SocketChannel>() { // (4)
	                 @Override
	                 public void initChannel(io.netty.channel.socket.SocketChannel ch) throws Exception {
	                     ch.pipeline().addLast(new DiscardServerHandler());
	                 }
	             })
	             .option(ChannelOption.SO_BACKLOG, 128)          // (5)
	             .childOption(ChannelOption.SO_KEEPALIVE, true); // (6)

	            // Bind and start to accept incoming connections.
	            ChannelFuture f = b.bind(port).sync(); // (7)

	            // Wait until the server socket is closed.
	            // In this example, this does not happen, but you can do that to gracefully
	            // shut down your server.
	            f.channel().closeFuture().sync();
	        } finally {
	            workerGroup.shutdownGracefully();
	            bossGroup.shutdownGracefully();
	        }
	    }

	    public static void main(String[] args) throws Exception {
	        int port;
	        if (args.length > 0) {
	            port = Integer.parseInt(args[0]);
	        } else {
	            port = 8080;
	        }
	        new DispacherServer(port).run();
	    }
	}


