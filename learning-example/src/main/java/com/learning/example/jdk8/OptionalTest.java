package com.learning.example.jdk8;

import java.util.Optional;
import java.util.function.Consumer;

/**
 * Created by Administrator on 2017-1-18.
 */
public class OptionalTest {

    public static void main(String [] args){
        Optional<String> test = Optional.of("hello");
        Optional<String> nullable = Optional.ofNullable(null);

        if(!test.isPresent()){
            System.out.println(test.orElseGet(()->"default value"));
        }
        if(!nullable.isPresent()){
            System.out.println(nullable.orElseGet(()->"default null value"));
        }
        test.ifPresent(new Consumer<String>() {
                           @Override
                           public void accept(String s) {
                               System.out.println(s);
                           }
                       }
        );
        //System.out.println(nullable.get()); exception will throw!
        nullable.ifPresent((s)->System.out.println(s));
    }

}
