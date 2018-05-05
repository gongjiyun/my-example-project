package com.xcloud.hadoop.util;

import org.apache.hadoop.conf.Configuration;

public class ConfigurationClass {
	public static Configuration getCongfiguration(){
		Configuration conf = new Configuration();
        //conf.addResource("classpath:hadoop-local.xml");
        //conf.addResource("classpath:hadoop-localhost.xml");
        conf.addResource("hadoop-cluster.xml"); 
        return conf;
	}

}
