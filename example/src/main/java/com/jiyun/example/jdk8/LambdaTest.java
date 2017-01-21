package com.jiyun.example.jdk8;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2017-1-13.
 */
public class LambdaTest {

    public static void main(String[] args){
        List<String> list = new ArrayList<String>();
        list.add("test1");
        list.add("test2");
        list.add("test3");
        list.add("test4");
        list.add("test5");

        List test1 = list.stream().filter((s)->s.startsWith("test")).map((s)-> "$"+ s).collect(Collectors.toList());
        System.out.println(test1);
        Optional<String> test2 = list.stream().reduce((a, b)-> a + b);
        test2.ifPresent(System.out::println);
        System.out.println(test2.get());
    }

}
