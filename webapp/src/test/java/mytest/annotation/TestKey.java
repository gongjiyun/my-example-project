package mytest.annotation;

import java.lang.reflect.Field;

public class TestKey {
	
	@Key(id=0,description="desc")
	public String any;
	
	public static void main(String[] args) throws Exception {
		Class c = Class.forName("test.annotation.TestKey");
		Field[] fields = c.getDeclaredFields();
		for(Field field:fields){
			boolean hasKey = field.isAnnotationPresent(Key.class);
			if(hasKey){
				Key k = field.getAnnotation(Key.class);
				System.out.println(k.description());
			}
			
		}
	}

}
