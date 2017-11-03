package com.xxooframe.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import com.xxooframe.common.model.TableVO;import com.xxooframe.service.DBMSService;
import com.xxooframe.utils.util.SpringAppContextHolder;

@Service("dbmsService")
public class DBMSServiceImpl implements DBMSService {
	
	@Resource
	private SessionFactory sessionFactory;

	public TableVO getTableInfo(String table) {
		TableVO info = new TableVO();
		ApplicationContext app = SpringAppContextHolder.get();
		DataSource ds = (DataSource) app.getBean("dataSource");
		try {
			Connection con = ds.getConnection();
			PreparedStatement ps = con.prepareStatement("select * from " + table + " where 1=1");
			ResultSet rs = ps.executeQuery();
			
			ResultSetMetaData rsmeta = rs.getMetaData();
			int columnNo = rsmeta.getColumnCount();
			List<String> columnNames = new ArrayList<String>();
			for(int i=1; i<=columnNo; i++){
				String clname = rsmeta.getColumnName(i);
				//int type = rsmeta.getColumnType(i);
				columnNames.add(clname);
			}
			List<List<String>> valueList = new ArrayList<List<String>>();
			while(rs.next()){
				List<String> values = new ArrayList<String>();
				for(int j=0;j<columnNames.size();j++){
					try{
						values.add(rs.getString(columnNames.get(j)));
					}catch(Exception e){
						e.printStackTrace();
						values.add(e.getMessage());
					}
				}
				valueList.add(values);
			}
			
			info.setTableName(table);
			info.setColumns(columnNames);
			info.setValues(valueList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return info;
	}

	public List<String> searchAllTables() {
		List<String> result = new ArrayList<String>();
		SQLQuery query = this.getSessionFactory().getCurrentSession().createSQLQuery("select table_name from information_schema.tables where table_schema='test'");
		List list = query.list();
		if(list!=null && list.size()>0){
			for(int i=0;i<list.size();i++){
				String s = (String) list.get(i);
				result.add(s);
			}
			return result;
		}
		return null;
	}

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
}
