package com.poc.utils.constants;

public interface PortalConstants extends StatusConstants{
	public final static String WEB_ERROR_KEY = "web.error.key";
	public final static String WEB_MSG_KEY = "web.msg.key";
	public final static String PATH_SEPARATOR = "/";
	public final static String WEB_KEY_USER = "web.key.USER";
	public final static String WEB_KEY_USER_ROLES = "web.key.USERROLES";
	public final static String WEB_KEY_UID = "web.key.UID";
	public final static String WEB_KEY_USERNAME = "web.key.USERNAME";
	public final static String JAVAX_SERVLET_URI = "javax.servlet.request_uri";
	public final static String JAVAX_SERVLET_URL = "javax.servlet.request_url";
	public final static String ACTION_URI = "javax.servlet.action.uri";
	public final static String DEFAULT_SYSTEM_ADMIN = "Admin";	
	public final static String SECR_KEY_TOKEN = "x-Token";
	
	public final static long DEFAULT_SYSTEM = 0;

	
	public final static String DEFAULT_DECIMAL_FORMAT = "###,##0.00";
	public final static String DEFAULT_WEB_DATE_FORMART = "yyyy-MM-dd";
	public final static String DEFAULT_WEB_DATE_TIME_FORMART = "yyyy-MM-dd HH:mm:ss";
	public final static String DEFAULT_CLIENT_DATE_FORMART = "dd/MM/yyyy";
	public final static String DEFAULT_CLIENT_DATE_TIME_FORMART = "dd/MM/yyyy HH:mm:ss";
	
	public final static String CARLENDAR_EVENT = "E";
	public final static String CARLENDAR_EVENT_CLIENT = "EC";
	public final static String CARLENDAR_APPOINTMENT = "A";
	public final static String CARLENDAR_PRODUCTMATURE = "P";
	
	public enum LOGIN_TYPE{ PBR, PBC }
	
	public enum PERSONAL_DOC_TYPE{ PROPOSAL, CONTRACT }
}
