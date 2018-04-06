package com.learning.springboot.example.repositories.jpa;

import java.io.Serializable;

import com.learning.springboot.example.entity.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository("userCrudRepository")
public interface UserCrudRepository extends CrudRepository<User, Serializable>{
	
	public User findByUid(Long uid) throws Exception;
	
	public User findByEmail(String email) throws Exception;

}
