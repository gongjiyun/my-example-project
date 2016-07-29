package mytest.nio;

import java.io.RandomAccessFile;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;

public class ChannelTest {

	public static void main(String[] args) throws Exception {
		RandomAccessFile file = new RandomAccessFile("D:/Documents/Books/jms.pdf", "rw");
		FileChannel fchannel = file.getChannel();
		
		ByteBuffer bff = ByteBuffer.allocate(1204);
		int l = fchannel.read(bff);
		file.close();
	}

}
