package com.learning.redisconfig.test;


import com.learning.spring.cloud.redisconfig.annotation.EnableAutoRedisConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

@EnableAutoRedisConfiguration(basePackages = {"com.learning"})
@EnableAutoConfiguration
@SpringBootApplication
public class RedisConfigApplication {
    public static void main(String[] args) throws Exception {
        ApplicationContext context = SpringApplication.run(RedisConfigApplication.class);
    }
}
