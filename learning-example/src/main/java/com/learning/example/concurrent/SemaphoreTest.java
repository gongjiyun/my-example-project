package com.learning.example.concurrent;

import java.util.concurrent.Semaphore;

public class SemaphoreTest {
	
	private int cc = 0;

	public static void main(String[] args) {
		SemaphoreTest s = new SemaphoreTest();
		int i = 100;
		int j = 0;
		while(j < i){
			new Thread(s.new TestThread(String.valueOf(j))).start();
			j++;
		}
		
	}
	
	class TestThread implements Runnable{
		private String o;
		public TestThread(String o){
			this.o = o;
		}
		@Override
		public void run() {
			test(o);
		}
		
	}
	
	public void test(String i){
		Semaphore s = new Semaphore(1, false);
		try {
			
			s.tryAcquire();
			
			System.out.println(i + Thread.currentThread().getName());
			System.out.println(cc++);
			
		} finally {
			
			s.release(1);
		}
	}

}
