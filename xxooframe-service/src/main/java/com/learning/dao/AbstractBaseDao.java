package com.learning.dao;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate5.HibernateTemplate;

public class AbstractBaseDao implements IBaseDao{
	
	@Resource
	private HibernateTemplate hibernateTemplate;
	
	@Resource
	private JdbcTemplate jdbcTemplate;
	
	@Resource
	private SessionFactory sessionFactory;
	
    public HibernateTemplate getHibernateTemplate() {  
        return hibernateTemplate;  
    }      
    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {  
        this.hibernateTemplate = hibernateTemplate;  
    }
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public Session getSession() {
		return hibernateTemplate.getSessionFactory().getCurrentSession();
	}
	
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

}
