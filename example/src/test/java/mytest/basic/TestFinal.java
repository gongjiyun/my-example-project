/**
This class add by jiyun
*/
package mytest.basic;

public class TestFinal {

	class MyObj{
		String name;
		String age;
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getAge() {
			return age;
		}
		public void setAge(String age) {
			this.age = age;
		}
		
	}
	
	void test(final MyObj obj){
		obj.setName("my");
	}
	
	public static void main(String[] args) {
		TestFinal test = new TestFinal();
		MyObj my = test.new MyObj();
		my.setName("ss");
		test.test(my);
	}

}
