package com.learning.webapp.websocket.example;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by Administrator on 2017-4-22.
 */
public class TextWebSocketHandler extends org.springframework.web.socket.handler.TextWebSocketHandler {
    private final static Logger logger = LoggerFactory.getLogger(TextWebSocketHandler.class);
    private final static List<WebSocketSession> sessions = Collections.synchronizedList(new ArrayList<WebSocketSession>());
    //接收文本消息，并发送出去
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        chatTextMessageHandler(message.getPayload());
        logger.debug(session.getAttributes().toString());
        session.sendMessage(new TextMessage("hello"));
        //super.handleTextMessage(session, message);
    }
    private void chatTextMessageHandler(String payload) {
        logger.info(payload);
    }


    //连接建立后处理
    @SuppressWarnings("unchecked")
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        logger.debug("connect to the websocket chat success......");
        sessions.add(session);
        //处理离线消息
    }
    //抛出异常时处理
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        if(session.isOpen()){
            session.close();
        }
        logger.debug("websocket chat connection closed......");
        sessions.remove(session);
    }
    //连接关闭后处理
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
        logger.debug("websocket chat connection closed......");
        sessions.remove(session);
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }
}
