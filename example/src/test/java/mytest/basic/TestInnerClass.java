package mytest.basic;

public class TestInnerClass {
	
	private String name = "outer name";
	private String password = "outer p";

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	class InnerClass {
		private String name = "inner name";

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}
		
		public void print(){
			System.out.println("name = " + name);
			System.out.println("password = " + password);
		}
		
	}
	
	public static class StaticInnerClass {
		private String name = "static inner name";

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}
		
		public void print(){
			System.out.println("name = " + name);
			
			TestInnerClass t = new TestInnerClass();
			System.out.println(t.getPassword());
		}
	}
	
	public static void main(String[] args) {
		InnerClass test = new TestInnerClass().new InnerClass();
		//InnerClass in = test.new InnerClass();
		test.print();
	}

}
