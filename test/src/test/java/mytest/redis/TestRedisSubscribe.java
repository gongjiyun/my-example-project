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
			  
			    // ��ʼ������ʱ��Ĵ���  
			    public void onSubscribe(String channel, int subscribedChannels) {  
			        // System.out.println(channel + "=" + subscribedChannels);  
			    }  
			  
			    // ȡ������ʱ��Ĵ���  
			    public void onUnsubscribe(String channel, int subscribedChannels) {  
			        // System.out.println(channel + "=" + subscribedChannels);  
			    }  
			  
			    // ��ʼ�������ʽ�ķ�ʽ����ʱ��Ĵ���  
			    public void onPSubscribe(String pattern, int subscribedChannels) {  
			        // System.out.println(pattern + "=" + subscribedChannels);  
			    }  
			  
			    // ȡ�������ʽ�ķ�ʽ����ʱ��Ĵ���  
			    public void onPUnsubscribe(String pattern, int subscribedChannels) {  
			        // System.out.println(pattern + "=" + subscribedChannels);  
			    }  
			  
			    // ȡ�ð����ʽ�ķ�ʽ���ĵ���Ϣ��Ĵ���  
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
