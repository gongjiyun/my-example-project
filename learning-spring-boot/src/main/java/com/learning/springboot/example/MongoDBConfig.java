package com.learning.springboot.example;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;

import com.mongodb.MongoClient;

@Configuration
@EnableMongoRepositories(basePackages = "com.jiyun.demo.springboot.repository.mongo")
public class MongoDBConfig {
	
	@Bean
	public MongoClient mongoClient() {
		MongoClient client = new MongoClient("localhost", 27017);
		client.fsync(false);
		return client;
	}
	
	@Bean
	public MongoTemplate mongoTemplate(MongoClient mongoClient) {
		
		return new MongoTemplate(mongoClient, "test");
	}
	
}
