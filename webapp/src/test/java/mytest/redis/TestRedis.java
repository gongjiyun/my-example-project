package mytest.redis;

import redis.clients.jedis.Jedis;

import com.poc.utils.constants.ServerConstants;

public class TestRedis {

	public static void main(String[] args) {
		try (RedisResource res = new RedisResource(new Jedis(ServerConstants.TEST_SERVER_IP, 6379))){
			System.out.println(res.getResource().keys("*"));
			
			System.out.println(res.getResource().hgetAll("person:1"));
			System.out.println(res.getResource().hget("person:1", "name"));
			//System.out.println(res.getResource().lrange("lista", 0, 1));
			
			res.getResource().publish("channel2", "push message of channel");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
