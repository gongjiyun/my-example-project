package com.learning.example.zookeeper;

public class SyncDistributeLockTest {
	
	class TreadLock implements Runnable{

		@Override
		public void run() {
			try{
				ZkClient zkl = new ZkClient();
				System.out.println("task start " + Thread.currentThread());
				
				zkl.connect();
				while(!zkl.getLock()){
					Thread.sleep(1000);
				}
				
				System.out.println("process ---> " + Thread.currentThread());
				
				zkl.release();
				System.out.println("task end " + Thread.currentThread());
				
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}

	public static void main(String[] args) {
		SyncDistributeLockTest test = new SyncDistributeLockTest();
		for(int i=0; i<10; i++){
			Thread thread = new Thread(test.new TreadLock());
			thread.start();
		}
	}

}
