package com.learning.utils.util;

import java.io.InputStream;
import java.util.Properties;

public class ResConfigUtil {
	private final static String PATH_ROOT_KEY = "digital.server.file.path";
	private final static String PATH_TEMP_KEY = "digital.server.file.path.temp";
	private final static String PATH_DOC_LIB_KEY = "digital.server.file.path.document";
	private final static String PATH_DOC_TEMPLATE_KEY = "digital.server.file.path.templates";
	private final static String DEFAULT_GROUP_ID_KEY = "digital.default.group.id";
	private final static String DEFAULT_COMPANY_ID_KEY = "digital.default.company.id";
	private final static String DEFAULT_BUCKETNAME = "digital.aws.s3.default.bucket";
	private final static String DEFAULT_LINUX_HOST = "DEFAULT.linux.host";
	private final static String DEFAULT_SERVER_HOST = "DEFAULT.server.host";
	private final static String DEFAULT_DB_HOST = "DEFAULT.server.db.host";

	private static ResConfigUtil instance = new ResConfigUtil();
	private static Properties prop = new Properties();
	static {
		InputStream is1 = null;
		InputStream is2 = null;
		try {
			is1 = ResConfigUtil.class
					.getResourceAsStream("/application.properties");
			prop.load(is1);
		} catch (Exception e) {
			System.out.println("error on load application resource");
		} finally {
			try {
				if (is1 != null) {
					is1.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}

		}
		try {
			is2 = ResConfigUtil.class.getResourceAsStream("/config.properties");
			prop.load(is2);
		} catch (Exception e) {
			System.out.println("error on load config resource");
		} finally {
			try {
				if (is2 != null) {
					is2.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}

		}
	}

	private ResConfigUtil() {

	}

	public static ResConfigUtil getInstance() {
		return instance;
	}

	public String getRootDataPath() {
		return getString(PATH_ROOT_KEY);
	}

	public String getDefaultLinuxServerHost() {
		return getString(DEFAULT_LINUX_HOST);
	}
	public String getDefaultServerHost() {
		return getString(DEFAULT_SERVER_HOST);
	}
	public String getDefaultDBServerHost() {
		return getString(DEFAULT_DB_HOST);
	}

	public String getTemplatePath() {
		return getString(PATH_DOC_TEMPLATE_KEY);
	}

	public String getTempPath() {
		return getString(PATH_TEMP_KEY);
	}

	public String getDocumentLibPath() {
		return getString(PATH_DOC_LIB_KEY);
	}

	public String getDefaultGroupId() {
		return getString(DEFAULT_GROUP_ID_KEY);
	}

	public String getDefaultCompanyId() {
		return getString(DEFAULT_COMPANY_ID_KEY);
	}

	public String getDefaultBucket() {
		return getString(DEFAULT_BUCKETNAME);
	}

	public String getString(String key) {
		try {
			if (prop != null) {
				return prop.getProperty(key);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public Integer getInteger(String key) {
		try {
			if (prop != null) {
				String val = prop.getProperty(key);
				return new Integer(val);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static void main(String[] args) {
		System.out.println(ResConfigUtil.getInstance().getDocumentLibPath());
	}

}
