package com.poc.utils.util;

import java.util.HashMap;
import java.util.Map;

public class BankingConfiguration {
	private Map<String, Object> configMap = new HashMap<String, Object>();
	
	public void setAttribute(String key, Object value){
		configMap.put(key, value);
	}
	
	public Object getAttribute(String key){
		return configMap.get(key);
	}
}
