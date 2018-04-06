package com.learning.cloud.mongodb.sample;

import java.util.Arrays;

import org.bson.Document;
import org.junit.Test;

import com.mongodb.Block;
import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MapReduceIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoIterable;
import com.mongodb.client.result.UpdateResult;
import com.learning.utils.constants.ServerConstants;
import com.learning.utils.util.DateUtil;

public class MongoDBClientTest {

	private static MongoClient mongoclient = null;
	private final static String database = "test";
	
	static{
		try {
			mongoclient = new MongoClient(ServerConstants.TEST_SERVER_IP, 27017);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws Exception {
		MongoDBClientTest testor = new MongoDBClientTest();
		testor.testMapReduce();
	}
	
	public void listDatabases(){
		MongoIterable<String> dbs = mongoclient.listDatabaseNames();
		dbs.forEach(new Block<String>() {

			@Override
			public void apply(String arg0) {
				System.out.println(arg0);
			}

		});
	}

	@Test
	public void findData() throws Exception {
		MongoDatabase db = mongoclient.getDatabase(database);
		MongoCollection<Document> collections = db.getCollection("restaurants");
		System.out.println("------------find collections all---------------");
		FindIterable<Document> its = collections.find().sort(new Document());
		
		its.forEach(new Block<Document>() {
			@Override
			public void apply(Document document) {
				System.out.println(document);
			}
		});
		
		
		System.out.println("------------find collections by condition---------------");
		its = collections.find(new Document("restaurant_id", "41704620")).sort(new Document());
		
		its.forEach(new Block<Document>() {
			@Override
			public void apply(Document document) {
				System.out.println(document);
			}
		});
		
	}



	/*public void testAggregation() throws Exception {
		MongoDatabase db = mongoclient.getDatabase(database);
		MongoCollection<Document> collections = db.getCollection("restaurants");
		AggregateIterable<Document> its = collections.aggregate(Arrays.asList(
				new Document("$match", new Document("_id", "1")),
				new Document("$match", new Document("_id", "2"))
			)
		);
		its.forEach(new Block<Document>() {
			@Override
			public void apply(Document document) {
				System.out.println(document);
			}
		});
		
	}*/
	
	public void testMapReduce() throws Exception {
		MongoDatabase db = mongoclient.getDatabase(database);
		MongoCollection<Document> collection = db.getCollection("restaurants");
		
		String mapper = "function(){emit(this.name, this.address.zipcode);};";
		String reduce = "function(key, values){return Array.sum(values);};";
		MapReduceIterable<Document> mapreItertors = collection.mapReduce(mapper, reduce);
		MongoCursor<Document> its = mapreItertors.iterator();
		while(its.hasNext()){
			Document obj = its.next();
			System.out.println(obj.toString());
		}
	}

	public void updateData() throws Exception {
		MongoDatabase db = mongoclient.getDatabase(database);
		MongoCollection<Document> collections = db.getCollection("restaurants");
		UpdateResult result = collections.updateOne(
				new Document("name", "Juni"), new Document("$set",
						new Document("cuisine", "American (New)")).append(
						"$currentDate", new Document("lastModified", true)));
		System.out.println(result.toString());
	}

	public void deleteData() throws Exception {
		MongoDatabase db = mongoclient.getDatabase(database);
		MongoCollection<Document> collections = db.getCollection("restaurants");
		System.out.println(collections.deleteOne(new Document("_id", "1")));
	}

	@Test
	public void insertData() throws Exception {
		MongoDatabase db = mongoclient.getDatabase(database);
		
		db.getCollection("restaurants")
				.insertOne(
						new Document("address", new Document()
								.append("street", "2 Avenue")
								.append("zipcode", "10075")
								.append("building", "1480")
								.append("coord",
										Arrays.asList(-73.9557413, 40.7720266)))
								.append("borough", "Manhattan")
								.append("cuisine", "Italian")
								.append("grades",
										Arrays.asList(
												new Document()
														.append("date",
																DateUtil.parseDate(
																		"2014-10-01T00:00:00Z",
																		"yyyy-MM-dd'T'HH:mm:ss'Z'"))
														.append("grade", "A")
														.append("score", 11),
												new Document()
														.append("date",
																DateUtil.parseDate(
																		"2014-10-01T00:00:00Z",
																		"yyyy-MM-dd'T'HH:mm:ss'Z'"))
														.append("grade", "B")
														.append("score", 17)))
								.append("name", "Vella")
								.append("restaurant_id", "41704620")
								.append("_id", "1"));
		System.out.println("insert data to db _id = 1");
	}

}
