package com.poc.spark.sample;

public class Test {

	public static void main(String[] args) throws Exception {
		if (args == null || args.length != 1) {
			System.out.println("Enter arg ... ");
		}
		
		IConsoleExecutor exe = getExecutor(args[0].trim());
		if(exe==null){
			System.out.println("Class not found");
		}

		exe.execute(args);
	}

	private static IConsoleExecutor getExecutor(String name) {
		if ("simple".equals(name)) {
			return new SimpleApp();
		}
		
		return null;
	}

}
