package com.learning.example.activemq.persistence;

import java.io.File;
import java.io.IOException;
import java.util.Set;

import org.apache.activemq.broker.ConnectionContext;
import org.apache.activemq.broker.scheduler.JobSchedulerStore;
import org.apache.activemq.command.ActiveMQDestination;
import org.apache.activemq.command.ActiveMQQueue;
import org.apache.activemq.command.ActiveMQTopic;
import org.apache.activemq.command.ProducerId;
import org.apache.activemq.store.MessageStore;
import org.apache.activemq.store.PersistenceAdapter;
import org.apache.activemq.store.TopicMessageStore;
import org.apache.activemq.store.TransactionStore;
import org.apache.activemq.usage.SystemUsage;

public class PersistenceAdapterExample implements PersistenceAdapter {

	@Override
	public void start() throws Exception {
		
	}

	@Override
	public void stop() throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void beginTransaction(ConnectionContext arg0) throws IOException {
		
	}

	@Override
	public void checkpoint(boolean arg0) throws IOException {
		
	}

	@Override
	public void commitTransaction(ConnectionContext arg0) throws IOException {
		
	}

	@Override
	public MessageStore createQueueMessageStore(ActiveMQQueue arg0) throws IOException {
		return null;
	}

	@Override
	public TopicMessageStore createTopicMessageStore(ActiveMQTopic arg0) throws IOException {
		return null;
	}

	@Override
	public TransactionStore createTransactionStore() throws IOException {
		return null;
	}

	@Override
	public void deleteAllMessages() throws IOException {
	}

	@Override
	public Set<ActiveMQDestination> getDestinations() {
		return null;
	}

	@Override
	public long getLastMessageBrokerSequenceId() throws IOException {
		return 0;
	}

	@Override
	public long getLastProducerSequenceId(ProducerId arg0) throws IOException {
		return 0;
	}

	@Override
	public void removeQueueMessageStore(ActiveMQQueue arg0) {
	}

	@Override
	public void removeTopicMessageStore(ActiveMQTopic arg0) {
	}

	@Override
	public void rollbackTransaction(ConnectionContext arg0) throws IOException {
	}

	@Override
	public void setBrokerName(String arg0) {
	}

	@Override
	public void setDirectory(File arg0) {
	}

	@Override
	public void setUsageManager(SystemUsage arg0) {

	}

	@Override
	public long size() {
		return 0;
	}

	@Override
	public JobSchedulerStore createJobSchedulerStore() throws IOException, UnsupportedOperationException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public File getDirectory() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void allowIOResumption() {
		// TODO Auto-generated method stub
		
	}

}
