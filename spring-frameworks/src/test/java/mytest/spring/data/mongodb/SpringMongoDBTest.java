package mytest.spring.data.mongodb;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import mytest.spring.StandloneSpringFactory;

import org.junit.Assert;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.data.mongodb.MongoDbFactory;
import org.springframework.data.mongodb.core.MongoClientFactoryBean;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.SimpleMongoDbFactory;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import com.mongodb.MongoClient;
import com.poc.utils.constants.ServerConstants;

public class SpringMongoDBTest {
	
	private final static Logger logger = LoggerFactory.getLogger(SpringMongoDBTest.class);
	
	private String database = "test";
	private MongoClient client = new MongoClient(ServerConstants.TEST_SERVER_IP, 27017);
	//private UserCredentials userCredentials = new UserCredentials("test", "password1");
	
	@Test
	public void test() throws Exception{
		MongoClientFactoryBean mongoFactoryBean = new MongoClientFactoryBean();
		mongoFactoryBean.setHost("localhost");
		mongoFactoryBean.setPort(27017);
		
		
		MongoDbFactory mfactory = new SimpleMongoDbFactory(client, database);
		MongoOperations mongoOps = new MongoTemplate(mfactory);
		
		Address address = new Address();
		address.setCity("chengdu");
		address.setCountry("China");
		address.setStreet("TF");
		address.setPostalCode("610000");
		List<Address> addresses = new ArrayList<Address>();
		addresses.add(address);
		
		List<Person> list = new ArrayList<Person>();
		Person person = new Person();
		person.set_id(String.valueOf(UUID.randomUUID()));
		person.setAge(100);
		person.setBirthDate(new Date());
		person.setGender("M");
		person.setName("Google+");
		person.setAddrsses(addresses);
		list.add(person);
		person = new Person();
		person.set_id(String.valueOf(UUID.randomUUID()));
		person.setAge(100);
		person.setBirthDate(new Date());
		person.setGender("M");
		person.setName("Google-");
		person.setAddrsses(addresses);
		list.add(person);
		
		mongoOps.insertAll(list);

		logger.info("--------------------------------MONGO DB-----------------------------------");
		logger.info(mongoOps.findOne(new Query(Criteria.where("name").is("Google+")), Person.class).toString());
		logger.info("--------------------------------MONGO DB-----------------------------------");
		logger.info(mongoOps.findOne(new Query(Criteria.where("birthDate").lt(new Date())), Person.class).toString());
		logger.info("--------------------------------MONGO DB-----------------------------------");

		mongoOps.dropCollection("person");
	}

	public void insert() throws Exception{
		ApplicationContext context = StandloneSpringFactory.getContext();
		Assert.assertNotNull("Spring context was loaded", context);
	}
	
	public void find() throws Exception{
		ApplicationContext context = StandloneSpringFactory.getContext();
		Assert.assertNotNull("Spring context was loaded", context);
	}
	
}
