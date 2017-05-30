package com.example.service;

import com.example.module.User;

public interface PersonService {
	public User findUserByUid(String uid) throws Exception;
}
