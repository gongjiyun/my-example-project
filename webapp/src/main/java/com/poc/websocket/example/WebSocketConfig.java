package com.poc.websocket.example;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.HandshakeInterceptor;

/**
 * Created by Administrator on 2017-4-22.
 */
@Configuration
@EnableWebMvc
@EnableWebSocket
public class WebSocketConfig extends WebMvcConfigurerAdapter implements WebSocketConfigurer{
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        String[] allowIPS = new String[]{"*"};
        registry.addHandler(textWebSocketHandler(), "/websocket/chatExample").setAllowedOrigins(allowIPS).addInterceptors(interceptor());
        registry.addHandler(textWebSocketHandler(), "/sockjs/websocket/chatExample").setAllowedOrigins(allowIPS).addInterceptors(interceptor()).withSockJS();
    }

    @Bean
    public WebSocketHandler textWebSocketHandler(){
        return new TextWebSocketHandler();
    }

    public HandshakeInterceptor interceptor(){
        return new WebSocketHandshakeInterceptor();
    }

}
