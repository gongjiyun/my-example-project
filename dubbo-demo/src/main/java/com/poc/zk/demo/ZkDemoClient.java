package com.poc.zk.demo;

import org.apache.zookeeper.CreateMode;
import org.apache.zookeeper.WatchedEvent;
import org.apache.zookeeper.Watcher;
import org.apache.zookeeper.ZooDefs.Ids;
import org.apache.zookeeper.ZooKeeper;

import com.poc.utils.constants.ServerConstants;

public class ZkDemoClient {

	public static void main(String[] args) throws Exception {
		ZkDemoClient test = new ZkDemoClient();
		test.create();
	}
	
	public void create() throws Exception{
		ZooKeeper zk = new ZooKeeper(ServerConstants.TEST_SERVER_IP + ":" + 2181, 2000, new Watcher(){

			@Override
			public void process(WatchedEvent arg0) {
				System.out.println(arg0.getPath());
			}
			
		});
		
		zk.create("/zkdemo", "localhost".getBytes(), Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
		
		System.out.println(new String(zk.getData("/zkdemo",false,null))); 
		
		zk.delete("/zkdemo", -1);
		
		zk.close();
	}
	
	

}
