package com.jiyun.example.springbatch.demo;

import org.springframework.batch.item.ItemReader;
import org.springframework.batch.item.NonTransientResourceException;
import org.springframework.batch.item.ParseException;
import org.springframework.batch.item.UnexpectedInputException;

import com.jiyun.example.springbatch.demo.vo.Person;

public class FlatFileReader implements ItemReader<Person> {

	@Override
	public Person read() throws Exception, UnexpectedInputException, ParseException, NonTransientResourceException {
		return null;
	}

}
