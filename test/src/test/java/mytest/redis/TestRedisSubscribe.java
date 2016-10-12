package mytest.redis;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPubSub;

import com.poc.utils.constants.ServerConstants;

public class TestRedisSubscribe {

	public static void main(String[] args) {
		try (RedisResource res = new RedisResource(new Jedis(ServerConstants.TEST_SERVER_IP, 6379))){
			res.getResource().psubscribe(new JedisPubSub() {
				public void onMessage(String channel, String message) {  
			        System.out.println(channel + "=" + message);
			        System.exit(0);
			    }  
			  
			    // 初始化订阅时候的处理  
			    public void onSubscribe(String channel, int subscribedChannels) {  
			        // System.out.println(channel + "=" + subscribedChannels);  
			    }  
			  
			    // 取消订阅时候的处理  
			    public void onUnsubscribe(String channel, int subscribedChannels) {  
			        // System.out.println(channel + "=" + subscribedChannels);  
			    }  
			  
			    // 初始化按表达式的方式订阅时候的处理  
			    public void onPSubscribe(String pattern, int subscribedChannels) {  
			        // System.out.println(pattern + "=" + subscribedChannels);  
			    }  
			  
			    // 取消按表达式的方式订阅时候的处理  
			    public void onPUnsubscribe(String pattern, int subscribedChannels) {  
			        // System.out.println(pattern + "=" + subscribedChannels);  
			    }  
			  
			    // 取得按表达式的方式订阅的消息后的处理  
			    public void onPMessage(String pattern, String channel, String message) {  
			        System.out.println(pattern + "=" + channel + "=" + message);
			        System.exit(0);
			    }  
			}, "channel2");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
