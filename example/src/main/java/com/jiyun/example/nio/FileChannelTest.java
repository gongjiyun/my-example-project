package com.jiyun.example.nio;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.ByteBuffer;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.channels.WritableByteChannel;

import org.junit.Test;

public class FileChannelTest {

	public static void main(String[] args) throws Exception {

	}

	@Test
	public void testIOCP() throws Exception {
		long start = System.currentTimeMillis();
		FileInputStream fin = new FileInputStream("E:/softwares/iReport-4.7.1-windows-installer.exe");
		FileOutputStream fout = new FileOutputStream("D:/iReport-4.7.1-windows-installer1.exe");
		byte[] bff = new byte[1024];

		while (fin.read(bff) != -1) {
			fout.write(bff, 0, bff.length);
			fout.flush();
		}

		fin.close();
		fout.close();
		long end = System.currentTimeMillis();
		System.out.println("Using time : " + (end - start));
		//Using time : 4193
	}

	@Test
	public void testNIOChannelCP() throws Exception {
		long start = System.currentTimeMillis();
		FileInputStream fin = new FileInputStream("E:/softwares/iReport-5.5.1-windows-installer.exe");
		FileOutputStream fout = new FileOutputStream("D:/iReport-5.5.1-windows-installer1.exe");
		
		FileChannel fc = fin.getChannel();
		FileChannel fco = fout.getChannel();
		
		ByteBuffer buffer = ByteBuffer.allocate(1024);
		
		while (fc.read(buffer) != -1) {
			buffer.flip();
			fco.write(buffer);
			buffer.clear();
		}

		fc.close();
		fco.close();
		fout.close();
		fin.close();

		long end = System.currentTimeMillis();
		System.out.println("Using time : " + (end - start));
		//Using time : 49032
	}

	
	public void testFileChannelMapper() throws Exception {
		FileInputStream fin = new FileInputStream("E:/softwares/eclipse.rar");

		FileChannel fc = fin.getChannel();
		MappedByteBuffer buffer = fc.map(FileChannel.MapMode.READ_ONLY, 0, fc.size());
		buffer.load();
		while (buffer.hasRemaining()) {
			byte[] bt = new byte[1024];
			buffer.get(bt);
			System.out.println(new String(bt));
		}

		fc.close();
		fin.close();
	}

	public static void catFiles(WritableByteChannel target, String[] files)
			throws Exception {
		for (int i = 0; i < files.length; i++) {
			FileInputStream fis = new FileInputStream(files[i]);
			FileChannel channel = fis.getChannel();
			channel.transferTo(0, channel.size(), target);
			channel.close();
			fis.close();
		}
	}
}
