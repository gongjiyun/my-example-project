package com.learning.springboot.example.repositories.jpa;

import java.io.Serializable;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.learning.common.entities.User;

@Repository("userCrudRepository")
public interface UserCrudRepository extends PagingAndSortingRepository<User, Serializable>{
	
	public User findByUid(Long uid) throws Exception;
	
	public User findByEmail(String email) throws Exception;

}
