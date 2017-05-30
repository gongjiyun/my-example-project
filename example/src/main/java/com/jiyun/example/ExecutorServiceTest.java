package com.jiyun.example;

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class ExecutorServiceTest {
	
	private String flag;
	
	private static ExecutorService service = null;

	public static void main(String[] args) {
		ExecutorServiceTest test = new ExecutorServiceTest();
		
		service = Executors.newFixedThreadPool(10);
		
		service.execute(test.new EHandler());
		
		Future<ExecutorServiceTest> f = service.submit(new Callable<ExecutorServiceTest>() {

			@Override
			public ExecutorServiceTest call() throws Exception {
				System.out.println("ffff");
				ExecutorServiceTest f = new ExecutorServiceTest();
				f.setFlag("test Future");
				return f;
			}
			
		});
		
		
		if(f.isDone()){
			try {
				System.out.println(f.get().getFlag());
			} catch (InterruptedException e) {
				e.printStackTrace();
			} catch (ExecutionException e) {
				e.printStackTrace();
			}
		}
		service.shutdown();
		
	}
	
	
	
	
	public String getFlag() {
		return flag;
	}




	public void setFlag(String flag) {
		this.flag = flag;
	}




	class EHandler implements Runnable{

		@Override
		public void run() {
			System.out.println("eeee");
		}
		
	}

}
