package com.example.boot.customize;

import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.stereotype.Component;

@Component
public class CustomizationBean implements EmbeddedServletContainerCustomizer {

	@Override
	public void customize(ConfigurableEmbeddedServletContainer arg0) {
		//arg0.setPort(8088);
	}

}
