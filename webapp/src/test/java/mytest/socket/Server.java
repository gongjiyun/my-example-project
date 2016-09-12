/**
This class add by Administrator
*/
package mytest.socket;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
	public static void main(String[] args) throws Exception{
		ServerSocket serverSocket = null;
		try {
			serverSocket = new ServerSocket();
			serverSocket.bind(new InetSocketAddress("localhost", 8040));
			while(true){
				Socket socket = null;
				try {
					socket = serverSocket.accept();
					if(socket!=null){
						InputStream is = socket.getInputStream();
						BufferedInputStream bfin = new BufferedInputStream(is);
						InputStreamReader ins = new InputStreamReader(is);
						BufferedReader reader = new BufferedReader(ins);
						
						OutputStream os = socket.getOutputStream();
						OutputStreamWriter osw = new OutputStreamWriter(os);
						BufferedWriter writer = new BufferedWriter(osw);
						
						FileInputStream fin = new FileInputStream("/Projects/TestData/small.txt");
						InputStreamReader freader = new InputStreamReader(fin);
						BufferedReader bfreader = new BufferedReader(freader);
						
						String message = null;
						while((message = bfreader.readLine())!=null){
							writer.write(message);
							writer.flush();
						}
						bfreader.close();
						freader.close();
						fin.close();
						
						writer.close();
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					socket.close();
				}
				System.out.println("finish read & write");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			serverSocket.close();
		}
	}
}
