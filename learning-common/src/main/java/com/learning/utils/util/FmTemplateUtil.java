package com.learning.utils.util;

import java.io.IOException;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 **Digital Banking Trends �C Banks�� Goal and NCS Presence
 **/
public class FmTemplateUtil {
	//private final static Logger logger = LoggerFactory.getLogger(FmTemplateUtil.class);
	private static String templateClassPath = "/templates/";
	private static String templateSystemPath = ResConfigUtil.getInstance().getTemplatePath();
	private static FmTemplateUtil instance = new FmTemplateUtil();
	private static Configuration configuration;
	
	static{
		try {
			System.out.println("initial template enginee configuration");
			configuration = new Configuration(Configuration.VERSION_2_3_22);
			configuration.setDefaultEncoding("utf-8");  
	        configuration.setClassLoaderForTemplateLoading(FmTemplateUtil.class.getClassLoader(), templateClassPath); 
	        //configuration.setDirectoryForTemplateLoading(new File(templateSystemPath));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private FmTemplateUtil(){
		
	}
	
	public static FmTemplateUtil instance(){
		if(instance==null){
			instance = new FmTemplateUtil();
		}
		return instance;
	}
	
	public Template getTemplate(String templateName) throws Exception{
		return configuration.getTemplate(templateName);
	}
	
	public String getContent(Map<String, Object> map, String templateName){
		Template t = null;  
        try {
        	if(!templateName.endsWith(".ftl")){
        		templateName = templateName + ".ftl";
        	}
            t = getTemplate(templateName);
        } catch (Exception e) {  
            e.printStackTrace();  
        }  

        StringWriter out = null;  
        try {  
            out = new StringWriter();  
        } catch (Exception e) {  
            e.printStackTrace();  
        }
        
        try {
            t.process(map, out);  
            out.close();  
            return out.getBuffer().toString();
        } catch (TemplateException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }
        return "";
	}
	
	public static void main(String[] args) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", "test");
		map.put("password", "test");
		System.out.println(FmTemplateUtil.instance().getContent(map, "tpl_password_keeping"));
	}
}
