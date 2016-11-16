package com.jiyun.example.activemq;

import java.io.File;

import org.apache.activemq.broker.BrokerFactory;
import org.apache.activemq.broker.BrokerService;
import org.apache.activemq.store.kahadb.KahaDBStore;

public class EmbeddedBrokerUsingAMQStoreExample {

	private static BrokerService createEmbeddedBroker() throws Exception {
		System.setProperty("activemq.home", "/apache-activemq-5.4.3");
		System.setProperty("activemq.base", "/apache-activemq-5.4.3");
		BrokerService broker = BrokerFactory.createBroker("xbean:activemq.xml");
		
		/*File dataFileDir = new File("/usr/data/amq-in-action/kahadb");
		KahaDBStore kaha = new KahaDBStore();
		kaha.setDirectory(dataFileDir);
		// Using a bigger journal file
		kaha.setJournalMaxFileLength(1024 * 100);
		// small batch means more frequent and smaller writes
		kaha.setIndexWriteBatchSize(100);
		// do the index write in a separate thread
		kaha.setEnableIndexWriteAsync(true);
		kaha.setArchiveDataLogs(true);
		kaha.setDirectoryArchive(dataFileDir);

		broker.setPersistenceAdapter(kaha);
		
		// create a transport connector
		broker.addConnector("tcp://localhost:61616");
		broker.setBrokerName("localhost");
		broker.setDataDirectory("/usr/data/amq-in-action/data/");
		broker.setCacheTempDestinations(true);*/
		
		
		// start the broker
		broker.start();
		return broker;
	}
	
	public static void main(String[] args) throws Exception{
		createEmbeddedBroker();
	}
}
