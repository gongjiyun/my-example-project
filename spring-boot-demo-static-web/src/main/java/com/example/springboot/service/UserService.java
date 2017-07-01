package com.example.springboot.service;

import java.util.List;

import com.example.springboot.entity.User;



public interface UserService {
	
	public User findByUid(Long uid) throws Exception;
	
	public List<User> findAll() throws Exception;
	
	public User create(User user) throws Exception;
	
	public void delete(Long uid) throws Exception;
}
