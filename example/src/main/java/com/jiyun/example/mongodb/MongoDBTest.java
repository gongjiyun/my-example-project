package com.jiyun.example.mongodb;

import org.bson.BsonDocument;
import org.bson.BsonObjectId;
import org.bson.BsonString;
import org.bson.Document;
import org.bson.codecs.configuration.CodecRegistry;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;

import com.jiyun.example.Constants;
import com.mongodb.Block;
import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoIterable;
import com.mongodb.client.result.DeleteResult;

public class MongoDBTest {

	public static void main(String[] args) {
		MongoDBTest test = new MongoDBTest();
		test.testRunCommand();
	}

	public void testConnection() {
		ServerAddress addr = new ServerAddress(Constants.LINUX_HOST, 27017);
		MongoClient client = new MongoClient(addr);
		MongoDatabase db = client.getDatabase("test");

		System.out.println(db.getName());

		MongoIterable<String> collectionNames = db.listCollectionNames();
		collectionNames.forEach(new Block<String>() {

			public void apply(String arg0) {
				System.out.println(arg0);
			}

		});

		MongoCollection<Document> collection = db.getCollection("restaurants");

		FindIterable<Document> result = collection.find();

		result.forEach(new Block<Document>() {
			public void apply(Document arg0) {
				System.out.println(arg0.toJson());
			}

		});

		client.close();

	}
	
	public void testRunCommand() {
		ServerAddress addr = new ServerAddress(Constants.LINUX_HOST, 27017);
		MongoClient client = new MongoClient(addr);
		MongoDatabase db = client.getDatabase("test");

		System.out.println(db.getName());

		Document result = db.runCommand(new Bson() {
			
			@Override
			public <TDocument> BsonDocument toBsonDocument(Class<TDocument> arg0, CodecRegistry arg1) {
				return new BsonDocument("distinct", new BsonString("restaurants")).append("key", new BsonString("grades.grade"));
			}
		});
		
		System.out.println(result);
		
		client.close();

	}

	public void testSearch() {
		ServerAddress addr = new ServerAddress(Constants.LINUX_HOST, 27017);
		MongoClient client = new MongoClient(addr);
		MongoDatabase db = client.getDatabase("test");

		System.out.println(db.getName());

		MongoIterable<String> collectionNames = db.listCollectionNames();
		collectionNames.forEach(new Block<String>() {

			public void apply(String arg0) {
				System.out.println(arg0);
			}

		});

		MongoCollection<Document> collection = db.getCollection("restaurants");

		FindIterable<Document> result = null;
		
		/*result = collection.find(new Document("restaurant_id", "50018406"));

		result.forEach(new Block<Document>() {
			public void apply(Document arg0) {
				System.out.println(arg0.toJson());
			}

		});*/
		
		//Document findCri = new Document("grades.0.grade", "A");
		//Document findCri = new Document("grades.grade", "D");
		//Document findCri = new Document("grades.grade", "D");
		//Document findCri = new Document("grades", new Document("$size", 3));
		//Document findCri = new Document("grades", new Document("$slice", new Integer[]{0,1}));
		Document findCri = new Document("grades", new Document("$elemMatch", new Document("grade","A").append("score", new Document("$gt",15))));
		result = collection.find(findCri);
		
		result.forEach(new Block<Document>() {
			public void apply(Document arg0) {
				System.out.println(arg0.toJson());
			}

		});
		
		

		client.close();
	}

	public void testInsert() {
		ServerAddress addr = new ServerAddress(Constants.LINUX_HOST, 27017);
		MongoClient client = new MongoClient(addr);
		MongoDatabase db = client.getDatabase("test");

		System.out.println(db.getName());

		MongoIterable<String> collectionNames = db.listCollectionNames();
		collectionNames.forEach(new Block<String>() {

			public void apply(String arg0) {
				System.out.println(arg0);
			}

		});

		MongoCollection<Document> collection = db.getCollection("restaurants");

		collection.insertOne(new Document().append("number2", "1111").append("number3", "1112").append("adddress",
				new Document("j", "test")));

		client.close();

	}

	public void testDelete() {
		ServerAddress addr = new ServerAddress(Constants.LINUX_HOST, 27017);
		MongoClient client = new MongoClient(addr);
		MongoDatabase db = client.getDatabase("test");

		System.out.println(db.getName());

		MongoIterable<String> collectionNames = db.listCollectionNames();
		collectionNames.forEach(new Block<String>() {

			public void apply(String arg0) {
				System.out.println(arg0);
			}

		});

		MongoCollection<Document> collection = db.getCollection("restaurants");

		collection.deleteOne(new Bson() {

			public <TDocument> BsonDocument toBsonDocument(Class<TDocument> arg0, CodecRegistry arg1) {
				return new BsonDocument("_id", new BsonString("1"));
			}
		});

		DeleteResult deleteResult = collection.deleteOne(new Bson() {

			public <TDocument> BsonDocument toBsonDocument(Class<TDocument> arg0, CodecRegistry arg1) {
				return new BsonDocument("_id", new BsonObjectId(new ObjectId("58106ca17b7ecb50a4445411")));
			}
		});

		client.close();

	}

	public void testUpdate() {
		ServerAddress addr = new ServerAddress(Constants.LINUX_HOST, 27017);
		MongoClient client = new MongoClient(addr);
		MongoDatabase db = client.getDatabase("test");

		System.out.println(db.getName());

		MongoIterable<String> collectionNames = db.listCollectionNames();
		collectionNames.forEach(new Block<String>() {

			public void apply(String arg0) {
				System.out.println(arg0);
			}

		});

		MongoCollection<Document> collection = db.getCollection("restaurants");
		
		Document result = collection.findOneAndUpdate(new Bson() {

			public <TDocument> BsonDocument toBsonDocument(Class<TDocument> arg0, CodecRegistry arg1) {
				return new BsonDocument("_id", new BsonObjectId(new ObjectId("58106ca17b7ecb50a4445411")));
			}
		}, new Document("$set", new Document("number2", "10")));

		/*collection.updateOne(new Bson() {

			public <TDocument> BsonDocument toBsonDocument(Class<TDocument> arg0, CodecRegistry arg1) {
				return new BsonDocument("_id", new BsonObjectId(new ObjectId("58106ca17b7ecb50a4445411")));
			}
		}, new Document("$set", new Document("number2", "1111")).toBsonDocument(Document.class, CodecRegistry));*/

		System.out.println(result);

		client.close();

	}

}
