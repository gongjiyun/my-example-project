package com.jiyun.example.zookeeper;

import java.util.concurrent.CountDownLatch;

import org.apache.zookeeper.CreateMode;
import org.apache.zookeeper.KeeperException;
import org.apache.zookeeper.WatchedEvent;
import org.apache.zookeeper.Watcher;
import org.apache.zookeeper.ZooDefs;
import org.apache.zookeeper.ZooKeeper;

public class ZkClient implements Watcher {

	public final static String LOCK = "lock-of-zk";
	public final static String HOST = "192.168.56.110:2181";
	private ZooKeeper zk = null;
	private CountDownLatch countdown = new CountDownLatch(1);
	private CountDownLatch createcountdown = new CountDownLatch(1);
	private String selfPath = null;

	public ZkClient() {

	}

	public void connect() throws Exception {
		zk = new ZooKeeper(HOST, 2000, this);
		countdown.await();
	}

	public boolean getLock() {
		try {
			selfPath = zk.create("/my-lock-", LOCK.getBytes(), ZooDefs.Ids.OPEN_ACL_UNSAFE,
					CreateMode.EPHEMERAL_SEQUENTIAL);
			System.out.println("get lock ... " + selfPath);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public void release() {
		try {
			if (zk != null) {
				if (zk.exists(selfPath, true) != null) {
					zk.delete(selfPath, 0);
				}
				zk.close();
			}
			zk = null;
			System.out.println("release lock ... " + selfPath);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void process(WatchedEvent event) {
		if (event != null) {
			Event.EventType type = event.getType();
			Event.KeeperState state = event.getState();

			if (type != null && type == Event.EventType.None) {
				System.out.println("connected");
				countdown.countDown();
			}
			if (type != null && type == Event.EventType.NodeCreated) {
				System.out.println("create");
			}

			System.out.println("event state = " + state);
			System.out.println("event type = " + type);
		}

	}

	public static void main(String[] args) throws InterruptedException, KeeperException {

	}

}
