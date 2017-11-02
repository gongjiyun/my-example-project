package com.xxooframe.dao;

import org.hibernate.Session;
import org.springframework.orm.hibernate5.HibernateTemplate;

public interface IBaseDao{
	
    public HibernateTemplate getHibernateTemplate();
    
    public Session getSession();
}
