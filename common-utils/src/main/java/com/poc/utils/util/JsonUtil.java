package com.poc.utils.util;

import net.sf.json.JSON;
import net.sf.json.JSONSerializer;
import net.sf.json.JsonConfig;

public class JsonUtil {
	
	public static Object toJavaObject(JSON jsonObject, Class<?> c) {
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setRootClass(c);
		
		return JSONSerializer.toJava(jsonObject, jsonConfig);
	}
	
	public static JSON toJson(Object object) {
		return JSONSerializer.toJSON(object);
	}

}
