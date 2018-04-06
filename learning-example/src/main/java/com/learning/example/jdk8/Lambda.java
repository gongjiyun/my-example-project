package com.learning.example.jdk8;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;

public class Lambda {

	public static void main(String[] args) throws Exception {
		
		Scanner s = new Scanner(System.in);
		
		List<String> names = Arrays.asList(s.next(), s.next(), s.next(), s.next());
		
		s.close();
		
		Collections.sort(names, (String a, String b)->{return b.compareTo(a);});
		System.out.println(names);
		
		
	}

}
