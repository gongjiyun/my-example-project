package com.example.springboot.repositories.jpa;

import java.io.Serializable;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.springboot.entity.User;

@Repository("userCrudRepository")
public interface UserCrudRepository extends CrudRepository<User, Serializable>{
	
	public User findByUid(Long uid) throws Exception;
	
	public User findByEmail(String email) throws Exception;

}
