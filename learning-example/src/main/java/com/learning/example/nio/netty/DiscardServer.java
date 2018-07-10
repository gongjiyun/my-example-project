package com.learning.example.nio.netty;

import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.*;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioServerSocketChannel;

public class DiscardServer {
	
	private String host = "localhost";
	private int port;
	
	public DiscardServer(String host, int port){
		this.host = host;
		this.port = port;
	}
	
	
	public void run() throws Exception{
		EventLoopGroup bossgroup = new NioEventLoopGroup();
		EventLoopGroup workgroup = new NioEventLoopGroup();
		try {			
			ServerBootstrap boot = new ServerBootstrap();
			boot.group(bossgroup, workgroup).channel(NioServerSocketChannel.class).childHandler(new ChannelInitializer<SocketChannel>() {

				@Override
				protected void initChannel(SocketChannel ch) throws Exception {
					ChannelPipeline pipeline = ch.pipeline();
					pipeline.addLast(new TimeServerHandler());
				}
				
			})
			.option(ChannelOption.SO_BACKLOG, 128)
			.childOption(ChannelOption.SO_KEEPALIVE, true);
			
			ChannelFuture f = boot.bind(host, port).sync();
			f.channel().closeFuture().sync();
		} finally {
			bossgroup.shutdownGracefully();
			workgroup.shutdownGracefully();
		}

	}
	

	public static void main(String[] args) throws Exception {
		new DiscardServer("localhost", 8080).run();;
	}

}
