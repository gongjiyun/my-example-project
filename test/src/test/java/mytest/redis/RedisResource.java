package mytest.redis;

import redis.clients.jedis.Jedis;

public class RedisResource implements AutoCloseable {
	
	private Jedis redisClient;
	
	public Jedis getResource(){
		return this.redisClient;
	}

	public RedisResource(Jedis redisClient){
		this.redisClient = redisClient;
	}
	
	@Override
	public void close() throws Exception {
		redisClient.close();
	}

}
