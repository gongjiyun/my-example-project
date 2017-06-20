package com.example.repositories;

import java.io.Serializable;

import org.springframework.data.repository.CrudRepository;

import com.example.entity.User;

@org.springframework.stereotype.Repository("userCrudRepository")
public interface UserCrudRepository extends CrudRepository<User, Serializable>{
	
	public User findByUid(Long uid) throws Exception;
	
	public User findByEmail(String email) throws Exception;

}
