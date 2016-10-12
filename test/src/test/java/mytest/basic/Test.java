/**
This class add by Administrator
*/
package mytest.basic;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.TreeSet;
import java.util.Vector;

public class Test {
    public static void main(String[] args) {
    	Test t = new Test();
    	t.setName("test");
    	System.out.println("test address : " + t.hashCode());
    	changeName(t);
    	System.out.println("test address : " + t.hashCode());
    	System.out.println(t.getName());
	}
    
    private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public static void changeName(Test test){
		ArrayList alist;
		LinkedList  llist;
		LinkedHashSet lhset;
		LinkedHashMap lhmap;
		Hashtable table;
		TreeSet treeset;
		Vector vc;
	}
    
}
