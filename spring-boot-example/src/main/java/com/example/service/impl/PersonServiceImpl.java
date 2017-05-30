package com.example.service.impl;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.module.User;
import com.example.service.PersonService;
import com.example.vo.ConnectionSettings;

@Service
public class PersonServiceImpl implements PersonService {
	
	private static final Logger _logger = Logger.getLogger(PersonServiceImpl.class);
	
	@Autowired
	private ConnectionSettings connectionSettings;

	public ConnectionSettings getConnectionSettings() {
		return connectionSettings;
	}

	public void setConnectionSettings(ConnectionSettings connectionSettings) {
		this.connectionSettings = connectionSettings;
	}
	
	
	public User findUserByUid(String uid) throws Exception{
		User user = new User();
		user.setUsername(connectionSettings.getUsername());
		user.setEmail(connectionSettings.getPassword());
		return user;
	}


}
