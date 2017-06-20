package com.example.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entity.User;
import com.example.repositories.UserCrudRepository;
import com.example.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	private static final Logger _logger = Logger.getLogger(UserServiceImpl.class);
	
	private UserCrudRepository userCrudRepository;
	
	@Autowired
	public UserServiceImpl(UserCrudRepository userCrudRepository){
		this.userCrudRepository = userCrudRepository;
	}

	public User findByUid(Long uid) throws Exception{
		User user = userCrudRepository.findByUid(uid);

		return user;
	}

	public List<User> findAll() throws Exception{
		Iterator<User> list = userCrudRepository.findAll().iterator();
		List<User> result = new ArrayList<User>();
		if(list.hasNext()){
			result.add(list.next());
		}
		
		return result;
	}
	
	public User create(User user) throws Exception{
		return userCrudRepository.save(user);
	}
	
	public void delete(Long uid) throws Exception{
		userCrudRepository.delete(uid);
	}

}
