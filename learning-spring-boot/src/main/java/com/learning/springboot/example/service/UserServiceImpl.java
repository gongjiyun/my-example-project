package com.learning.springboot.example.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.databind.ser.std.JsonValueSerializer;
import com.learning.common.entities.User;
import com.learning.springboot.example.repositories.jpa.UserCrudRepository;
import com.learning.utils.util.JsonUtil;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	private static final Logger logger = Logger.getLogger(UserServiceImpl.class);
	
	@Autowired
	private UserCrudRepository userCrudRepository;
	
	
	public UserCrudRepository getUserCrudRepository() {
		return userCrudRepository;
	}

	public void setUserCrudRepository(UserCrudRepository userCrudRepository) {
		this.userCrudRepository = userCrudRepository;
	}

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
		logger.debug(JsonFactory.);
		return userCrudRepository.save(user);
	}
	
	public void delete(Long uid) throws Exception{
		userCrudRepository.deleteById(uid);
	}

}
