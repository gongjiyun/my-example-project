package com.learning.dubbo.demo.service.impl;

import com.learning.dubbo.demo.service.DemoService;

public class DemoServiceImpl implements DemoService {

	@Override
	public String dubbo(String args) throws Exception {
		System.out.println("hello dubbo" + args);
		return "hello " + args;
	}

}
