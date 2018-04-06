package com.learning.springboot.example;

import javax.sql.DataSource;

import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DBConfigurate {
	

	/*
	 * @Bean(destroyMethod="")
	 * 
	 * @ConfigurationProperties(prefix="app.datasource") public DataSource
	 * dataSource() throws Exception { JndiDataSourceLookup dataSourceLookup =
	 * new JndiDataSourceLookup(); return
	 * dataSourceLookup.getDataSource("java:comp/env/jdbc/YourDS"); }
	 */

/*	@Bean
	public DataSource dataSource() {
		return DataSourceBuilder.create().driverClassName("com.mysql.jdbc.Driver").password("root").username("root")
				.url("jdbc:mysql://192.168.56.120:3306/test").build();
	}*/
	

}
