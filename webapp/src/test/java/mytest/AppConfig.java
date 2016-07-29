package mytest;

import org.springframework.beans.factory.annotation.Value;

public class AppConfig {
	private @Value("#{jdbcProperties.jdbc.url}") String url;

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
}
