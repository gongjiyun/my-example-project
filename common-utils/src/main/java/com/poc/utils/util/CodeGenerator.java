package com.poc.utils.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.commons.io.FileUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;

/**
 ** Digital Banking Trends �C Banks�� Goal and NCS Presence
 **/
public class CodeGenerator {
	
	private final static String PROJECT_UTIL = "digital-banking-util";
	private final static String PROJECT_SERVICE = "digital-banking-service";
	private final static String MAVEN_SRC = "src/main/java/";
	private final static String SRC_ENTITY = MAVEN_SRC + "sg/ncs/digitalbanking/entity/";
	private final static String SRC_CONSTANTS = MAVEN_SRC + "sg/ncs/digitalbanking/constants/";
	private final static String SRC_DAO = MAVEN_SRC + "sg/ncs/digitalbanking/dao/";
	private final static String SRC_DAO_IMPL = MAVEN_SRC + "sg/ncs/digitalbanking/dao/impl/";
	private final static String SRC_SPRING_DAO_CONFIG = "src/main/resources/config/spring/spring-dao.xml";
	
	private static String rootPath = null;
	private static String pathEntity = null;
	private static String pathConstants = null;
	private static String pathDao = null;
	private static String pathDaoImpl = null;
	private static String pathSpringDaoConfig = null;
	
	static{
		try {
			String path = Class.class.getClass().getResource("/").getPath() ;
			System.out.println("current compile path is " + path);
			rootPath = path.substring(0, path.indexOf(PROJECT_UTIL));
			pathEntity = rootPath + PROJECT_UTIL + "/" + SRC_ENTITY;
			System.out.println("project entity path is " + pathEntity);
			pathConstants = rootPath + PROJECT_UTIL + "/" + SRC_CONSTANTS;
			System.out.println("project entity path is " + pathConstants);
			pathDao = rootPath + PROJECT_SERVICE + "/" +SRC_DAO ;
			System.out.println("project service path is " + pathDao);
			pathDaoImpl = rootPath + PROJECT_SERVICE + "/" +SRC_DAO_IMPL ;
			System.out.println("project service impl path is " + pathDaoImpl);
			pathSpringDaoConfig = rootPath + PROJECT_SERVICE + "/" + SRC_SPRING_DAO_CONFIG;
			System.out.println("spring dao config path is " + pathSpringDaoConfig);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public static void main(String[] args) throws Exception {
		List<ClassDef> classess = wrapClasses();
		CodeGenerator gen = new CodeGenerator();
		
		for(ClassDef def : classess){
			try {
				def.setUseExtends(true);
				
				EntityGenerator entityGen = gen.new EntityGenerator();
				entityGen.generateEntity(def,true);
				
				
				DaoGenerator daoGen = gen.new DaoGenerator();
				daoGen.generateDao(def, false);
				
				DaoImplGenerator daoImplGen = gen.new DaoImplGenerator();
				daoImplGen.generateDaoImpl(def, false);
				
				SpringDaoXMLUpdate daoconfigUpdate = gen.new SpringDaoXMLUpdate();
				daoconfigUpdate.updateDao(def);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		TableDefinitionGenerator taleconstantsGen = gen.new TableDefinitionGenerator();
		taleconstantsGen.generateTableDefinition(classess, true);
	}
	
	class TableDefinitionGenerator{
		public void generateTableDefinition(List<ClassDef> clazzs, boolean overraid) throws Exception{
			try {
				String fileName = "TableDefConstants.java";
				String filePath = pathConstants + fileName;
				
				File file = new File(filePath);
				if(file.isFile() && file.exists()){
					if(overraid){
						FileUtils.forceDelete(file);
					}else {
						return;
					}
					
				}
				System.out.println("Generating TableDefinition.java file");
				boolean created = file.createNewFile();
				if(!created){
					System.out.println("Can not create file " + filePath);
					return;
				}
				
				PrintWriter print = new PrintWriter(file);
				
				insertPackage(print);
				print.append("\n");		
				print.append("\n");
				print.append("\n");
				
				print.append("public class TableDefConstants" + "{");
				print.append("\n");
				
				for(ClassDef clazz : clazzs){
					insertMethods(print, clazz);
				}
				
				
				print.append("}");
				print.flush();
				print.close();			
			} catch (Exception e) {
				System.out.println("Error while generate constants TableDefConstants ");
			}
		}
		
		private void insertPackage(PrintWriter print) throws FileNotFoundException{
			print.append("package com.poc.utils.constants;\n");
		}
		
		private void insertMethods(PrintWriter print, ClassDef clazz) throws FileNotFoundException{
			System.out.println("Insert methods for " + clazz.getClassName() + "Dao");
			String className = clazz.getClassName();
			String entityName=	className.substring(0,1).toLowerCase() + className.substring(1);
			
			StringBuffer columnbs = new StringBuffer();
			for(FieldDef field : clazz.getFields()){
				String cn = field.getFieldName();
				columnbs.append(",");
				columnbs.append(cn);
			}
			print.append("\t" + "public enum " + clazz.getClassName() +  " {" + columnbs.toString().substring(1) + "};\n");
		}
	}
	
	class DaoGenerator{
		public void generateDao(ClassDef clazz, boolean overraid) throws Exception{
			try {
				String fileName = clazz.getClassName() + "Dao.java";
				String filePath = pathDao + fileName;
				
				File file = new File(filePath);
				if(file.isFile() && file.exists()){
					if(overraid){
						FileUtils.forceDelete(file);
					}else {
						return;
					}
					
				}
				System.out.println("Generating dao file for clazz " + filePath);
				boolean created = file.createNewFile();
				if(!created){
					System.out.println("Can not create file " + filePath);
					return;
				}
				
				PrintWriter print = new PrintWriter(file);
				
				insertPackage(print, clazz);
				print.append("\n");
				insertImports(print, clazz);			
				print.append("\n");
				print.append("\n");
				
				print.append("public interface " + clazz.getClassName() + "Dao" + " extends IBaseDao{");
				print.append("\n");
				
				insertMethods(print, clazz);
				
				print.append("}");
				print.flush();
				print.close();			
			} catch (Exception e) {
				System.out.println("Error while generate dao file " + clazz.getClassName());
			}
		}
		
		private void insertPackage(PrintWriter print, ClassDef clazz) throws FileNotFoundException{
			print.append("package com.poc.utils.dao;\n");
		}
		
		private void insertImports(PrintWriter print, ClassDef clazz) throws FileNotFoundException{
			System.out.println("insert imports classes for " + clazz.getClassName() + "Dao");		
	
			print.append("import " + "java.util.List" + ";\n");
			print.append("import " + "java.util.Map" + ";\n");
			print.append("import " + "sg.ncs.digitalbanking.dao.IBaseDao" + ";\n");
			print.append("import " + "org.hibernate.criterion.DetachedCriteria" + ";\n");
			print.append("import " + "sg.ncs.digitalbanking.model.PageCriteria" + ";\n");
			print.append("import " + "sg.ncs.digitalbanking.model.PageResult" + ";\n");
			print.append("import " + "com.poc.common.entities." + clazz.getClassName() + ";\n");
		}
		
		private void insertMethods(PrintWriter print, ClassDef clazz) throws FileNotFoundException{
			System.out.println("Insert methods for " + clazz.getClassName() + "Dao");
			String className = clazz.getClassName();
			String entityName=	className.substring(0,1).toLowerCase() + className.substring(1);
			
			print.append("\t" + "public List<" + clazz.getClassName() + "> " + "load(int start, int end) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public " + clazz.getClassName() + " findByPrimaryKey(long primaryKey) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public List<" + clazz.getClassName() + "> " + "findByDetachedCriteria(DetachedCriteria criteria) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public List<" + clazz.getClassName() + "> " + "findByParameterMap(Map<String, Object> parameter, int start, int end) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public PageResult<?> " + "searchPageResults(PageCriteria pageCriteria) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public List<" + clazz.getClassName() + "> " + "findByColumn(String cloumnName, Object value, int start, int end) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public List<" + clazz.getClassName() + "> " + "findByColumns(String[] cloumnNames, Object[] values, int start, int end) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public List<" + clazz.getClassName() + "> " + "findByColumnLike(String cloumnName, Object value, int start, int end) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public List<" + clazz.getClassName() + "> " + "findByColumn(String cloumnName, Object value) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public List<" + clazz.getClassName() + "> " + "findByColumns(String[] cloumnNames, Object[] values) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public List<" + clazz.getClassName() + "> " + "findByColumnLike(String cloumnName, Object value) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public List<" + clazz.getClassName() + "> " + "findByInColumn(String cloumnName, Object[] values) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public Long " + "save(" + clazz.getClassName() + " entity) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public void " + "update(" + clazz.getClassName() + " entity) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public void " + "delete(" + clazz.getClassName() + " entity) throws Exception;\n");
			print.append("\n");
			print.append("\t" + "public void " + "delete(long primaryKey) throws Exception;\n");
			print.append("\n");
		}
	}
	
	class DaoImplGenerator{
		public void generateDaoImpl(ClassDef clazz, boolean overraid) throws Exception{
			try {
				String fileName = clazz.getClassName() + "DaoImpl.java";
				String filePath = pathDaoImpl + fileName;
				
				File file = new File(filePath);
				if(file.isFile() && file.exists()){
					if(overraid){
						FileUtils.forceDelete(file);
					}else {
						return;
					}
					
				}
				System.out.println("Generating dao impl file for clazz " + filePath);
				boolean created = file.createNewFile();
				if(!created){
					System.out.println("Can not create file " + filePath);
					return;
				}
				
				PrintWriter print = new PrintWriter(file);
				
				insertPackage(print, clazz);
				print.append("\n");
				insertImports(print, clazz);			
				print.append("\n");
				print.append("\n");
				insertDaoAnnotation(print, clazz);
				
				print.append("public class " + clazz.getClassName() + "DaoImpl extends AbstractBaseDao implements " + clazz.getClassName() + "Dao, IBaseDao" + "{");
				print.append("\n");
				
				insertMethods(print, clazz);
				
				print.append("}");
				print.flush();
				print.close();			
			} catch (Exception e) {
				System.out.println("Error while generate dao impl file " + clazz.getClassName());
			}
		}
		
		private void insertPackage(PrintWriter print, ClassDef clazz) throws FileNotFoundException{
			print.append("package com.poc.utils.dao.impl;\n");
		}
		
		private void insertImports(PrintWriter print, ClassDef clazz) throws FileNotFoundException{
			System.out.println("insert imports classes for " + clazz.getClassName() + "DaoImpl");		
	
			print.append("import " + "java.util.List" + ";\n");
			print.append("import " + "java.util.Map" + ";\n");
			print.append("import " + "org.hibernate.Criteria" + ";\n");
			print.append("import " + "org.hibernate.Session" + ";\n");
			print.append("import " + "org.hibernate.SessionFactory" + ";\n");
			print.append("import " + "org.hibernate.criterion.DetachedCriteria" + ";\n");
			print.append("import " + "org.hibernate.criterion.Restrictions" + ";\n");		
			print.append("import " + "org.springframework.stereotype.Repository" + ";\n");
			
			print.append("import " + "sg.ncs.digitalbanking.model.PageCriteria" + ";\n");
			print.append("import " + "sg.ncs.digitalbanking.model.PageResult" + ";\n");
			print.append("import " + "sg.ncs.digitalbanking.dao.AbstractBaseDao" + ";\n");
			print.append("import " + "sg.ncs.digitalbanking.dao." + clazz.getClassName() + "Dao" + ";\n");
			print.append("import " + "com.poc.common.entities." + clazz.getClassName() + ";\n");
			print.append("import " + "sg.ncs.digitalbanking.util.QueryUtil;\n");
		}
		
		private void insertDaoAnnotation(PrintWriter print, ClassDef clazz) throws FileNotFoundException{
			String className = clazz.getClassName();
			String entityName=	className.substring(0,1).toLowerCase() + className.substring(1);
			print.append("@Repository(\"" + entityName + "Dao" + "\")" + "\n");
		}
		
		private void insertMethods(PrintWriter print, ClassDef clazz) throws FileNotFoundException{
			System.out.println("Insert methods for " + clazz.getClassName() + "DaoImpl");
			String className = clazz.getClassName();
			String entityName=	className.substring(0,1).toLowerCase() + className.substring(1);
			
			print.append("\n");	
			
			print.append("\t" + "@SuppressWarnings(\"unchecked\")\n");
			print.append("\t" + "public List<" + clazz.getClassName() + ">" + " load(int start, int end) throws Exception{\n");
			print.append("\t\t" + "SessionFactory sf = getHibernateTemplate().getSessionFactory();\n");
			print.append("\t\t" + "Session session = sf.getCurrentSession();\n");
			print.append("\t\t" + "Criteria crit = session.createCriteria(" + clazz.getClassName() + ".class);\n");
			print.append("\t\t" + "if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){\n");
			print.append("\t\t\t" + "crit.setFirstResult(start);\n");
			print.append("\t\t\t" + "crit.setMaxResults(end-start);\n");
			print.append("\t\t" + "}\n");
			print.append("\t\t" + "return crit.list();\n");
			print.append("\t" + "}\n");
			print.append("\n");	
			
			print.append("\t" + "public " + clazz.getClassName() + " findByPrimaryKey(long primaryKey) throws Exception{\n");
			print.append("\t\t" + "return getHibernateTemplate().get(" + clazz.getClassName() +".class, primaryKey);\n");
			print.append("\t" + "}\n");
			print.append("\n");			
			
			print.append("\t" + "@SuppressWarnings(\"unchecked\")\n");
			print.append("\t" + "public List<" + clazz.getClassName() + ">" + " findByDetachedCriteria(DetachedCriteria criteria) throws Exception{\n");
			print.append("\t\t" + "List<" + clazz.getClassName() + "> list = (List<" + clazz.getClassName() + ">) getHibernateTemplate().findByCriteria(criteria);\n");
			print.append("\t\t" + "return list;\n");
			print.append("\t" + "}\n");
			print.append("\n");
			
			//print.append("\t" + "@SuppressWarnings(\"unchecked\")\n");
			print.append("\t" + "public List<" + clazz.getClassName() + ">" + " findByParameterMap(Map<String, Object> parameter, int start, int end) throws Exception{\n");
			print.append("\t\t" + "return null;\n");
			print.append("\t" + "}\n");
			print.append("\n");
			
			//print.append("\t" + "@SuppressWarnings(\"unchecked\")\n");
			print.append("\t" + "public PageResult<?> " + "searchPageResults(PageCriteria pageCriteria) throws Exception{\n");
			print.append("\t\t" + "return null;\n");
			print.append("\t" + "}\n");
			print.append("\n");
			
			print.append("\t" + "@SuppressWarnings(\"unchecked\")\n");
			print.append("\t" + "public List<" + clazz.getClassName() + ">" + " findByColumn(String cloumnName, Object value, int start, int end) throws Exception{\n");
			print.append("\t\t" + "SessionFactory sf = getHibernateTemplate().getSessionFactory();\n");
			print.append("\t\t" + "Session session = sf.getCurrentSession();\n");
			print.append("\t\t" + "Criteria crit = session.createCriteria(" + clazz.getClassName() + ".class);\n");
			print.append("\t\t" + "if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){\n");
			print.append("\t\t\t" + "crit.setFirstResult(start);\n");
			print.append("\t\t\t" + "crit.setMaxResults(end-start);\n");
			print.append("\t\t" + "}\n");
			print.append("\t\t" + "crit.add(Restrictions.eq(cloumnName, value));\n");
			print.append("\t\t" + "return crit.list();\n");
			print.append("\t" + "}\n");
			print.append("\n");
			
			print.append("\t" + "@SuppressWarnings(\"unchecked\")\n");
			print.append("\t" + "public List<" + clazz.getClassName() + ">" + " findByColumns(String[] cloumnNames, Object[] values, int start, int end) throws Exception{\n");
			print.append("\t\t" + "SessionFactory sf = getHibernateTemplate().getSessionFactory();\n");
			print.append("\t\t" + "Session session = sf.getCurrentSession();\n");
			print.append("\t\t" + "Criteria crit = session.createCriteria(" + clazz.getClassName() + ".class);\n");
			print.append("\t\t" + "if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){\n");
			print.append("\t\t\t" + "crit.setFirstResult(start);\n");
			print.append("\t\t\t" + "crit.setMaxResults(end-start);\n");
			print.append("\t\t" + "}\n");
			print.append("\t\t" + "for(int i=0; i<cloumnNames.length; i++){\n");
			print.append("\t\t\t" + "String cloumnName = cloumnNames[i];\n");
			print.append("\t\t\t" + "if(i<values.length){\n");
			print.append("\t\t\t\t" + "crit.add(Restrictions.eq(cloumnName, values[i]));\n");
			print.append("\t\t\t" + "}\n");
			print.append("\t\t" + "}\n");
			print.append("\t\t" + "return crit.list();\n");
			print.append("\t" + "}\n");
			print.append("\n");
			
			print.append("\t" + "@SuppressWarnings(\"unchecked\")\n");
			print.append("\t" + "public List<" + clazz.getClassName() + "> " + "findByColumnLike(String cloumnName, Object value, int start, int end) throws Exception{\n");
			print.append("\t\t" + "SessionFactory sf = getHibernateTemplate().getSessionFactory();\n");
			print.append("\t\t" + "Session session = sf.getCurrentSession();\n");
			print.append("\t\t" + "Criteria crit = session.createCriteria(" + clazz.getClassName() + ".class);\n");
			print.append("\t\t" + "if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){\n");
			print.append("\t\t\t" + "crit.setFirstResult(start);\n");
			print.append("\t\t\t" + "crit.setMaxResults(end-start);\n");
			print.append("\t\t" + "}\n");
			print.append("\t\t" + "crit.add(Restrictions.like(cloumnName, value));\n");
			print.append("\t\t" + "return crit.list();\n");
			print.append("\t" + "}\n");
			print.append("\n");
			
			print.append("\t" + "@SuppressWarnings(\"unchecked\")\n");
			print.append("\t" + "public List<" + clazz.getClassName() + ">" + " findByColumn(String cloumnName, Object value) throws Exception{\n");
			print.append("\t\t" + "SessionFactory sf = getHibernateTemplate().getSessionFactory();\n");
			print.append("\t\t" + "Session session = sf.getCurrentSession();\n");
			print.append("\t\t" + "Criteria crit = session.createCriteria(" + clazz.getClassName() + ".class);\n");
			print.append("\t\t" + "crit.add(Restrictions.eq(cloumnName, value));\n");
			print.append("\t\t" + "return crit.list();\n");
			print.append("\t" + "}\n");
			print.append("\n");
			
			print.append("\t" + "@SuppressWarnings(\"unchecked\")\n");
			print.append("\t" + "public List<" + clazz.getClassName() + ">" + " findByColumns(String[] cloumnNames, Object[] values) throws Exception{\n");
			print.append("\t\t" + "SessionFactory sf = getHibernateTemplate().getSessionFactory();\n");
			print.append("\t\t" + "Session session = sf.getCurrentSession();\n");
			print.append("\t\t" + "Criteria crit = session.createCriteria(" + clazz.getClassName() + ".class);\n");
			print.append("\t\t" + "for(int i=0; i<cloumnNames.length; i++){\n");
			print.append("\t\t\t" + "String cloumnName = cloumnNames[i];\n");
			print.append("\t\t\t" + "if(i<values.length){\n");
			print.append("\t\t\t\t" + "crit.add(Restrictions.eq(cloumnName, values[i]));\n");
			print.append("\t\t\t" + "}\n");
			print.append("\t\t" + "}\n");
			print.append("\t\t" + "return crit.list();\n");
			print.append("\t" + "}\n");
			print.append("\n");
			
			print.append("\t" + "@SuppressWarnings(\"unchecked\")\n");
			print.append("\t" + "public List<" + clazz.getClassName() + "> " + "findByColumnLike(String cloumnName, Object value) throws Exception{\n");
			print.append("\t\t" + "SessionFactory sf = getHibernateTemplate().getSessionFactory();\n");
			print.append("\t\t" + "Session session = sf.getCurrentSession();\n");
			print.append("\t\t" + "Criteria crit = session.createCriteria(" + clazz.getClassName() + ".class);\n");
			print.append("\t\t" + "crit.add(Restrictions.like(cloumnName, value));\n");
			print.append("\t\t" + "return crit.list();\n");
			print.append("\t" + "}\n");
			print.append("\n");
			
			print.append("\t" + "@SuppressWarnings(\"unchecked\")\n");
			print.append("\t" + "public List<" + clazz.getClassName() + "> " + "findByInColumn(String cloumnName, Object[] values) throws Exception{\n");
			print.append("\t\t" + "SessionFactory sf = getHibernateTemplate().getSessionFactory();\n");
			print.append("\t\t" + "Session session = sf.getCurrentSession();\n");
			print.append("\t\t" + "Criteria crit = session.createCriteria(" + clazz.getClassName() + ".class);\n");
			print.append("\t\t" + "crit.add(Restrictions.in(cloumnName, values));\n");
			print.append("\t\t" + "return crit.list();\n");
			print.append("\t" + "}\n");
			print.append("\n");
			
			print.append("\t" + "public Long " + "save(" + clazz.getClassName() + " entity) throws Exception{\n");
			print.append("\t\t" + "return (Long) getHibernateTemplate().save(entity);\n");
			print.append("\t" + "}\n");
			print.append("\n");
			
			print.append("\t" + "public void " + "update(" + clazz.getClassName() + " entity) throws Exception{\n");
			print.append("\t\t" + "getHibernateTemplate().update(entity);\n");
			print.append("\t" + "}\n");
			print.append("\n");
			
			print.append("\t" + "public void " + "delete(" + clazz.getClassName() + " entity) throws Exception{\n");
			print.append("\t\t" + "getHibernateTemplate().delete(entity);\n");
			print.append("\t" + "}\n");
			print.append("\n");
			
			print.append("\t" + "public void " + "delete(long primaryKey) throws Exception{\n");
			print.append("\t\t" + clazz.getClassName() + " " + entityName + " = getHibernateTemplate().get(" +  clazz.getClassName() + ".class, primaryKey)" + ";\n");
			print.append("\t\t" + "getHibernateTemplate().delete(" + entityName + ");\n");
			print.append("\t" + "}\n");
			print.append("\n");
		}
	}
	
	
	class EntityGenerator{
		public void generateEntity(ClassDef clazz, boolean overraid) throws Exception{
			try {
				String fileName = clazz.getClassName() + ".java";
				String filePath = pathEntity + fileName;
				
				File file = new File(filePath);
				if(file.isFile() && file.exists()){
					if(overraid){
						FileUtils.forceDelete(file);
					}else {
						return;
					}
					
				}
				System.out.println("Generating entity file for clazz " + filePath);
				boolean created = file.createNewFile();
				if(!created){
					System.out.println("Can not create file " + filePath);
					return;
				}
				
				PrintWriter print = new PrintWriter(file);
				
				insertPackage(print, clazz);
				print.append("\n");
				insertImports(print, clazz);			
				print.append("\n");
				print.append("\n");
				insertTableAnnotation(print, clazz);
				
				if(clazz.isUseExtends()){
					if(clazz.getParentClassName()!=null && !"".equals(clazz.getParentClassName())){
						print.append("public class " + clazz.getClassName() + " extends " + clazz.getParentClassName() + " implements Serializable{");
					}else{
						print.append("public class " + clazz.getClassName() + " implements Serializable{");
					}
				}else{
					print.append("public class " + clazz.getClassName() + " implements Serializable{");
				}
				print.append("\n");
				
				insertFields(print, clazz);
				print.append("\n");
				insertMethods(print, clazz);
				
				print.append("}");
				print.flush();
				print.close();			
			} catch (Exception e) {
				System.out.println("Error while generate entity file " + clazz.getClassName());
			}
		}
		
		private void insertPackage(PrintWriter print, ClassDef clazz) throws FileNotFoundException{
			print.append("package com.poc.utils.entity;\n");
			clazz.setClassFullName("com.poc.common.entities." + clazz.getClassName());
		}
		private void insertImports(PrintWriter print, ClassDef clazz) throws FileNotFoundException{
			System.out.println("insert imports classes for " + clazz.getClassName());		
			List<String> types = getClassAttributesTypes(clazz);
			if(clazz.getImportType()!=null && clazz.getImportType().size()>0){	
				Iterator<String> ti = clazz.getImportType().iterator();
				while(ti.hasNext()){
					String type = ti.next();
					if(type.equalsIgnoreCase(Byte.class.getName())){
						continue;
					}
					print.append("import " + type + ";\n");
				}
			}

			print.append("import " + "javax.persistence.Column" + ";\n");
			print.append("import " + "javax.persistence.Entity" + ";\n");
			print.append("import " + "javax.persistence.Table" + ";\n");
			print.append("import " + "org.hibernate.annotations.Cache" + ";\n");
			print.append("import " + "org.hibernate.annotations.CacheConcurrencyStrategy" + ";\n");
			print.append("import " + "java.io.Serializable" + ";\n");

			if(clazz.isHasTransientField()){
				print.append("import " + "javax.persistence.Transient" + ";\n");
			}
			if(clazz.useExtends && clazz.getParentClass()==null){
				print.append("import " + "javax.persistence.GeneratedValue" + ";\n");
				print.append("import " + "javax.persistence.Id" + ";\n");
				print.append("import " + "javax.persistence.Inheritance" + ";\n");
				print.append("import " + "javax.persistence.InheritanceType" + ";\n");				
				print.append("import " + "javax.persistence.GenerationType" + ";\n");
				print.append("import " + "javax.persistence.TableGenerator" + ";\n");
				//print.append("import " + "org.hibernate.annotations.GenericGenerator" + ";\n");
			}else if(clazz.useExtends && clazz.getParentClass()!=null){
				System.out.println("Do not import ID/GenericGenerator/InheritanceType for sub class " + clazz.getClassName());
			}else{
				print.append("import " + "javax.persistence.GeneratedValue" + ";\n");
				print.append("import " + "javax.persistence.Id" + ";\n");
				print.append("import " + "javax.persistence.Inheritance" + ";\n");
				print.append("import " + "javax.persistence.InheritanceType" + ";\n");
				print.append("import " + "org.hibernate.annotations.GenericGenerator" + ";\n");
			}			
			
			if(types.contains(Date.class.getName())){
				print.append("import " + "org.springframework.format.annotation.DateTimeFormat" + ";\n");
				print.append("import " + "sg.ncs.digitalbanking.constants.PortalConstants" + ";\n");
			}
			
		}
		
		private void insertTableAnnotation(PrintWriter print, ClassDef clazz) throws FileNotFoundException{
			String className = clazz.getClassName();
			String entityName=	className.substring(0,1).toLowerCase() + className.substring(1);
			print.append("@Entity(name=\"" + entityName + "\")" + "\n");
			print.append("@Cache(usage = CacheConcurrencyStrategy.NONE)" + "\n");
			if(clazz.isUseExtends() && clazz.getParentClass()==null){
				print.append("@Inheritance(strategy=InheritanceType.JOINED)" + "\n");
			}
			print.append("@Table(name=\"" + clazz.getTableName() + "\",catalog=\"\",schema=\"\")" + "\n");
		}
		
		private void insertFields(PrintWriter print, ClassDef clazz) throws FileNotFoundException{
			System.out.println("Insert fields for " + clazz.getClassName());
			if(clazz.getFields()==null || clazz.getFields().size()==0){
				System.out.println("No properties found for " + clazz.getClassName());
				return;
			}
			
			print.append("\n");
			print.append("\t" + "private static final long serialVersionUID = 1L;" + "\n");
			print.append("\n");
			
			for(FieldDef fd : clazz.getFields()){
				boolean isKey = fd.isPrimaryKey();
				boolean isRequire = fd.isRequired();
				String type = fd.getFieldType();
				String shortType = type.substring(type.lastIndexOf(".")+1);
				String columnType = fd.getColumnType();
				int length = 0;
				if(fd.getLength()!=null && !"".equals(fd.getLength())){
					length = Long.valueOf(fd.getLength()).intValue();
				}
				
				if(clazz.isUseExtends() && clazz.getParentClassName()!=null && !"".equals(clazz.getParentClassName())){
					System.out.println(">>>>>>>>> class " + clazz.getClassName() + " parent = " + clazz.getParentClassName());
					ClassDef parent = clazz.getParentClass();
					FieldDef fieldExist = checkFieldExist(fd.getFieldName(), parent);
					if(fieldExist!=null){
						System.out.println(">>>>>>>>> Do nothing for extend exist field " + fd.getFieldName());
						fd.setIgnoreMe(true);
						continue;		
					}else{
						if(isKey){
							fd.setIgnoreMe(true);
							System.out.println(">>>>>>>>> Do nothing for extend exist primary key " + fd.getFieldName());
							continue;	
						}				
					}
				}else{
					if(isKey){
						String incrmentid = fd.getFieldName().toLowerCase() + "_gen";				
						print.append("\t" + "@Id" + "\n");
						String genStrage = "@GeneratedValue(strategy = GenerationType.TABLE,generator=\"" + incrmentid + "\")";
						String gener = "@TableGenerator(name=\""+ incrmentid +"\",table=\"PB_Classes_\",pkColumnName=\"className\",initialValue=1, valueColumnName=\"currentId\",pkColumnValue=\"" + clazz.getClassFullName() + "\",allocationSize=1)";
						

						print.append("\t" + genStrage + "\n"); 
						print.append("\t" + gener + "\n");
					}
				}
				
				if(isKey){
					length = 32;
				}
				String nuableDef = "";
				String lengthDef = "";
				String columnDefinition = "";
				if(isRequire){
					nuableDef = ", nullable=false";
				}				
				if(length!=0){
					lengthDef = ", length=" + length;
				}
				if("text".equalsIgnoreCase(columnType)){
					columnDefinition = ", columnDefinition=\"longtext\"";
				}else if("longtext".equalsIgnoreCase(columnType)){
					columnDefinition = ", columnDefinition=\"longtext\"";
				}else if("blob".equalsIgnoreCase(columnType)){
					columnDefinition = ", columnDefinition=\"longblob\", updatable=false, insertable=false";
					shortType = "byte[]";
				}else if("byte".equalsIgnoreCase(columnType)){
					columnDefinition = ", columnDefinition=\"longblob\", updatable=false, insertable=false";
					shortType = "byte[]";
				}else if("varchar".equalsIgnoreCase(columnType)){
					columnDefinition = ", columnDefinition=\"varchar(" + length + ")\"";
				}else if("bigint".equalsIgnoreCase(columnType)){
					//columnDefinition = ", columnDefinition=\"bigint( " + lengthDef + ")\"";
				}
				
				if("Date".equalsIgnoreCase(shortType)){
					print.append("\t" + "@DateTimeFormat(pattern = PortalConstants.DEFAULT_WEB_DATE_FORMART)" + "\n"); 
				}
				if(fd.isTransient()){
					print.append("\t" + "@Transient" + "\n"); 
				}else{
					print.append("\t" + "@Column(name=\"" + fd.getColumnName() + "\"" + lengthDef + nuableDef + columnDefinition + ")" + "\n"); 
				}
				
				print.append("\t" + "private " + shortType + " " + fd.getFieldName() + ";\n");
				print.append("\n");
			}
		}
		
		private void insertMethods(PrintWriter print, ClassDef clazz) throws FileNotFoundException{
			System.out.println("Insert methods for " + clazz.getClassName());
			if(clazz.getFields()==null || clazz.getFields().size()==0){
				System.out.println("No properties found for " + clazz.getClassName());
				return;
			}
			for(FieldDef fd : clazz.getFields()){
				String fname = fd.getFieldName();
				String type = fd.getFieldType();
				String shortType = type.substring(type.lastIndexOf(".")+1);
				String columnType = fd.getColumnType();
				
				if("text".equalsIgnoreCase(columnType)){
				}else if("blob".equalsIgnoreCase(columnType)){
					shortType = "byte[]";
				}else if("byte".equalsIgnoreCase(columnType)){
					shortType = "byte[]";
				}	
				
				if(fd.ignoreMe){
					continue;
				}
				
				String fdGet = "get" + fname.substring(0,1).toUpperCase() + fname.substring(1);
				String fdSet = "set" + fname.substring(0,1).toUpperCase() + fname.substring(1);
				print.append("\t" + "public void " + fdSet + "(" + shortType + " " + fname + "){\n"); 
				print.append("\t\t" + "this." + fname + " = " + fname + ";\n"); 
				print.append("\t" + "}\n"); 
				
				print.append("\t" + "public " + shortType + " " +  fdGet + "(){\n"); 
				print.append("\t\t" + "return this." + fname + ";\n"); 
				print.append("\t" + "}\n"); 

			}
		}
	}
	
	
	class SpringDaoXMLUpdate{
		public void updateDao(ClassDef clazz){
			try {
				System.out.println("Updating dao config for " + clazz.getClassName());
				String className = clazz.getClassName();
				String entityName=	className.substring(0,1).toLowerCase() + className.substring(1) + "Dao";
				String daoImpl = "sg.ncs.digitalbanking.dao.impl." + className + "DaoImpl";
				String parent = "baseDao";
				
				String filePath = pathSpringDaoConfig;
				DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
				DocumentBuilder builder = factory.newDocumentBuilder();    
				FileInputStream fin = new FileInputStream(new File(filePath));
				Document document = builder.parse(fin);      
				Element element = document.getDocumentElement();
				
				NodeList beanNodes = element.getElementsByTagName("bean");
				if(beanNodes==null || beanNodes.getLength()==0){
					return;
				}
				
				boolean isIn = false;
				for(int i=0;i<beanNodes.getLength();i++){
					 Element beanElement = (Element) beanNodes.item(i);
					 if(entityName.equals(beanElement.getAttribute("id"))){
						 isIn = true;
						 return;
					 }
				}
				
				NodeList rootElement = document.getElementsByTagName("beans");
				Element beansNote = (Element)rootElement.item(0);
				if(!isIn){
					Element newEl = document.createElement("bean");
					Text textN1 = document.createTextNode("\n");
					Text tabN1 = document.createTextNode("\t");
					
					newEl.setAttribute("id", entityName);
					newEl.setAttribute("class", daoImpl);
					newEl.setAttribute("parent", parent);
					
					beansNote.appendChild(textN1);
					beansNote.appendChild(tabN1);
					beansNote.appendChild(newEl);
					beansNote.appendChild(textN1);
				}				
				fin.close();
				
				FileOutputStream fos = new FileOutputStream(new File(filePath));
				TransformerFactory transFactory = TransformerFactory.newInstance();
				Transformer transFormer = transFactory.newTransformer();
				DOMSource domSource = new DOMSource(document);
				StreamResult xmlResult = new StreamResult(fos);
				transFormer.transform(domSource, xmlResult);
				
				System.out.println("Updated dao config for " + clazz.getClassName());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	
	
	/**
	 * Read xls to classess
	 * @return
	 * @throws Exception
	 */
	private static List<ClassDef> wrapClasses() throws Exception{
		System.out.println("Mapping classes...");
		try {
			List<ClassDef> result = new ArrayList<CodeGenerator.ClassDef>();
			List<SheetVO> sheetList = new ArrayList<CodeGenerator.SheetVO>();
			
			Workbook book = Workbook.getWorkbook(CodeGenerator.class.getResourceAsStream("/PB design.xls"));
			Sheet sheet = book.getSheet(0);
			int rowsLength = sheet.getRows();
			String lastClassName = "";
			String lastSuperClassName = "";
			for(int i=1; i<rowsLength; i++){
				try {
					Cell[] cells = sheet.getRow(i);
					
					String className = cells[0].getContents();
					String superClass = cells[1].getContents();
					String attribute = cells[2].getContents();
					String type = cells[3].getContents();
					String length = cells[4].getContents();
					String transiens = cells[5].getContents();
					String required = cells[6].getContents();
					
					if(className!=null){
						className = className.trim();
					}
					if(superClass!=null){
						superClass = superClass.trim();
					}
					if(attribute!=null){
						attribute = attribute.trim();
					}
					if(type!=null){
						type = type.trim();
					}
					if(length!=null){
						length = length.trim();
					}
					if(transiens!=null){
						transiens = transiens.trim();
					}
					if(required!=null){
						required = required.trim();
					}
					 
					if(className==null || "".equals(className.trim())){
						className = lastClassName;
						superClass = lastSuperClassName;
					}else{
						lastClassName = className;
						lastSuperClassName = superClass;
					}
					
					if(attribute==null || "".equals(attribute)){
						continue;
					}
					
					CodeGenerator codeg = new CodeGenerator();
					CodeGenerator.SheetVO sheetvo = codeg.new SheetVO();
					sheetvo.setClassName(className);
					sheetvo.setSuperClass(superClass);
					sheetvo.setAttribute(attribute);
					sheetvo.setType(type);
					sheetvo.setLength(length);
					sheetvo.setIsTransient(transiens);
					sheetvo.setIsRequired(required);
					
					System.out.println("Row value : " + sheetvo.toString());
					sheetList.add(sheetvo);
					
				} catch (Exception e) {
					System.out.println("Error while process sheet row " + i);
				}
			}
			
			
			if(sheetList!=null && sheetList.size()>0){
				Set<String> classSet = new HashSet<String>();
				for(SheetVO svo : sheetList){
					if(classSet.contains(svo.getClassName())){
						continue;
					}else{
						classSet.add(svo.getClassName());
					}
				}
				
				CodeGenerator codeg = new CodeGenerator();
				Iterator<String> classitor = classSet.iterator();
				while(classitor.hasNext()){
					String className = classitor.next();					
					String entityName=	className.substring(0,1).toLowerCase() + className.substring(1);
					String superClass = getSheetSuperClassByClassName(className, sheetList);

					CodeGenerator.ClassDef classdef = codeg.new ClassDef();
					classdef.setClassName(className.substring(0,1).toUpperCase() + className.substring(1));
					classdef.setTableName("PB_" + classdef.getClassName());
					if(superClass!=null && !"".equals(superClass.trim())){
						classdef.setParentClassName(superClass.substring(0,1).toUpperCase() + superClass.substring(1));
					}
					Set<String> importTypes = new HashSet<String>();
					boolean hasTransientField = false;
					List<SheetVO> alist = getSheetAttributesByClassName(className, sheetList);
					if(alist!=null && alist.size()>0){
						List<FieldDef> fields = new ArrayList<CodeGenerator.FieldDef>();

						for(SheetVO vo : alist){
							CodeGenerator.FieldDef fielddef = codeg.new FieldDef();								
							fielddef.setFieldName(vo.getAttribute());
							fielddef.setColumnName(vo.getAttribute());
							if("text".equalsIgnoreCase(vo.getType())){
								fielddef.setFieldType(String.valueOf(String.class.getName()));
								fielddef.setColumnType("text");
							}else if("string".equalsIgnoreCase(vo.getType())){
								fielddef.setFieldType(String.valueOf(String.class.getName()));
								fielddef.setColumnType("varchar");
							}else if("varchar".equalsIgnoreCase(vo.getType())){
								fielddef.setFieldType(String.valueOf(String.class.getName()));
								fielddef.setColumnType("varchar");
							}else if("blob".equalsIgnoreCase(vo.getType())){
								fielddef.setFieldType(String.valueOf(Byte.class.getName()));
								fielddef.setColumnType("blob");
							}else if("longblob".equalsIgnoreCase(vo.getType())){
								fielddef.setFieldType(String.valueOf(Byte.class.getName()));
								fielddef.setColumnType("longblob");
							}else if("date".equalsIgnoreCase(vo.getType())){								
								fielddef.setFieldType(String.valueOf(Date.class.getName()));
								fielddef.setColumnType("datetime");
							}else if("datetime".equalsIgnoreCase(vo.getType())){
								fielddef.setFieldType(String.valueOf(Date.class.getName()));
							}else if("time".equalsIgnoreCase(vo.getType())){
								fielddef.setColumnType("datetime");
								fielddef.setFieldType(String.valueOf(Date.class.getName()));
							}else if("timestamp".equalsIgnoreCase(vo.getType())){
								fielddef.setFieldType(String.valueOf(Date.class.getName()));
								fielddef.setColumnType("datetime");
							}else if("long".equalsIgnoreCase(vo.getType())){
								fielddef.setFieldType(String.valueOf(Long.class.getName()));
								fielddef.setColumnType("bigint");
							}else if("int".equalsIgnoreCase(vo.getType())){
								fielddef.setFieldType(String.valueOf(Long.class.getName()));
								fielddef.setColumnType("bigint");
							}else if("double".equalsIgnoreCase(vo.getType())){
								fielddef.setFieldType(String.valueOf(Double.class.getName()));
								fielddef.setColumnType("double");
							}else if("float".equalsIgnoreCase(vo.getType())){
								fielddef.setFieldType(String.valueOf(Double.class.getName()));
								fielddef.setColumnType("double");
							}else if("bool".equalsIgnoreCase(vo.getType())){
								fielddef.setFieldType(String.valueOf(Boolean.class.getName()));
								fielddef.setColumnType("bool");
							}else if("boolean".equalsIgnoreCase(vo.getType())){
								fielddef.setFieldType(String.valueOf(Boolean.class.getName()));
								fielddef.setColumnType("bool");
							}else {
								fielddef.setFieldType(String.valueOf(String.class.getName()));
							}
							
							importTypes.add(fielddef.getFieldType());
							
							if(vo.getLength()!=null && !"".equals(vo.getLength().trim())){
								fielddef.setLength(vo.getLength());
							}else{
								fielddef.setLength(null);
							}
							
							if("yes".equalsIgnoreCase(vo.getIsTransient())){
								hasTransientField = true;
								fielddef.setTransient(true);
							}else if("y".equalsIgnoreCase(vo.getIsTransient())){
								fielddef.setTransient(true);
								hasTransientField = true;
							}else{
								fielddef.setTransient(false);
							}
							
							if("yes".equalsIgnoreCase(vo.getIsRequired())){
								fielddef.setRequired(true);
							}else if("y".equalsIgnoreCase(vo.getIsRequired())){
								fielddef.setRequired(true);
							}else{
								fielddef.setRequired(false);
							}
							
							fields.add(fielddef);
						}
						
						if(hasTransientField){
							classdef.setHasTransientField(true);
						}						
						classdef.setFields(fields);
						classdef.setImportType(importTypes);
					}
					result.add(classdef);
				}
				
				for(ClassDef clazz : result){
					ClassDef parent = getClassByName(clazz.getParentClassName(), result);
					List<FieldDef> classFields = clazz.getFields();
					clazz.setParentClass(parent);
					
					String className = clazz.getClassName();		
					String entityName=	className.substring(0,1).toLowerCase() + className.substring(1);
					String keyFieldName = String.valueOf(entityName + "Id");
					FieldDef keyField = checkFieldExist(keyFieldName, clazz);
					if(keyField==null){
						CodeGenerator.FieldDef keydef = codeg.new FieldDef();
						keydef.setPrimaryKey(true);
						keydef.setFieldName(keyFieldName);
						keydef.setColumnName(keyFieldName);
						keydef.setFieldType(String.valueOf(Long.class.getName()));
						classFields.add(0, keydef);
					}else{
						keyField.setPrimaryKey(true);
						keyField.setFieldName(keyFieldName);
						keyField.setColumnName(keyFieldName);
						keyField.setFieldType(String.valueOf(Long.class.getName()));
					}
				}
				
				return result;
			}else{
				throw new Exception("Please check xls file is correct");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private static List<String> getClassAttributesTypes(ClassDef clazz){
		if(clazz.getFields()==null || clazz.getFields().size()==0){
			return null;
		}
		List<String> types = new ArrayList<String>();
		for(FieldDef fd : clazz.getFields()){
			if(types.contains(fd.getFieldType())){
				continue;
			}else{
				types.add(fd.getFieldType());
			}
		}
		return types;
	}
	
	private static FieldDef getClassKeyField(ClassDef clazz){
		if(clazz.getFields()==null || clazz.getFields().size()==0){
			return null;
		}

		for(FieldDef fd : clazz.getFields()){
			if(fd.isPrimaryKey()){
				return fd;
			}
		}
		return null;
	}
	
	private static ClassDef getClassByName(String clazz, List<ClassDef> classes){
		if(classes==null || classes.size()==0){
			return null;
		}
		if(clazz==null || "".equals(clazz.trim())){
			return null;
		}
		for(ClassDef cls : classes){
			if(clazz.equalsIgnoreCase(cls.getClassName())){
				return cls;
			}
		}
		return null;
	}
	
	private static FieldDef checkFieldExist(String fieldName, ClassDef clazz){
		if(clazz.getFields()==null || clazz.getFields().size()==0){
			return null;
		}
		
		for(FieldDef fd : clazz.getFields()){
			if(fieldName.equalsIgnoreCase(fd.getFieldName())){
				return fd;
			}
		}
		return null;
	}
	
	private static List<SheetVO> getSheetAttributesByClassName(String name, List<SheetVO> list){
		if(list==null || list.size()==0){
			return null;
		}
		
		List<SheetVO> result = new ArrayList<CodeGenerator.SheetVO>();
		for(SheetVO vo : list){

			if(vo.getClassName().equals(name) && vo.getAttribute()!=null && !"".equals(vo.getAttribute())){
				result.add(vo);
			}
		}
		
		return result;
	}
	
	private static String getSheetSuperClassByClassName(String name, List<SheetVO> list){
		if(list==null || list.size()==0){
			return null;
		}
		for(SheetVO vo : list){
			if(vo.getClassName().equals(name)){
				return vo.getSuperClass();
			}
		}
		return null;
	}
	
	

	class ClassDef {

		private String className;
		private String tableName;
		private String parentClassName;
		private String classFullName;
		private ClassDef parentClass;
		private String version;
		private boolean useExtends;		
		private boolean hasTransientField;
		private boolean hasKey;
		private List<FieldDef> fields;
		private Set<String> importType;

		public boolean isUseExtends() {
			return useExtends;
		}

		public void setUseExtends(boolean useExtends) {
			this.useExtends = useExtends;
		}

		public String getClassName() {
			return className;
		}

		public void setClassName(String className) {
			this.className = className;
		}

		public String getTableName() {
			return tableName;
		}

		public void setTableName(String tableName) {
			this.tableName = tableName;
		}

		public String getParentClassName() {
			return parentClassName;
		}

		public void setParentClassName(String parentClassName) {
			this.parentClassName = parentClassName;
		}

		public List<FieldDef> getFields() {
			return fields;
		}

		public String getClassFullName() {
			return classFullName;
		}

		public void setClassFullName(String classFullName) {
			this.classFullName = classFullName;
		}

		public void setFields(List<FieldDef> fields) {
			this.fields = fields;
		}

		public String getVersion() {
			return version;
		}

		public void setVersion(String version) {
			this.version = version;
		}

		public ClassDef getParentClass() {
			return parentClass;
		}

		public void setParentClass(ClassDef parentClass) {
			this.parentClass = parentClass;
		}

		public boolean isHasTransientField() {
			return hasTransientField;
		}

		public void setHasTransientField(boolean hasTransientField) {
			this.hasTransientField = hasTransientField;
		}

		public boolean isHasKey() {
			return hasKey;
		}

		public void setHasKey(boolean hasKey) {
			this.hasKey = hasKey;
		}

		public Set<String> getImportType() {
			return importType;
		}

		public void setImportType(Set<String> importType) {
			this.importType = importType;
		}
		
	}

	class FieldDef {
		private String fieldName;
		private String fieldType;
		private String columnType;
		private String length;		
		private String columnName;
		private boolean required;
		private boolean isPrimaryKey;
		private boolean isIndex;
		private boolean ignoreMe;
		private boolean isTransient;

		public String getFieldName() {
			return fieldName;
		}

		public void setFieldName(String fieldName) {
			this.fieldName = fieldName;
		}

		public String getFieldType() {
			return fieldType;
		}

		public void setFieldType(String fieldType) {
			this.fieldType = fieldType;
		}

		public String getLength() {
			return length;
		}

		public void setLength(String length) {
			this.length = length;
		}

		public boolean isRequired() {
			return required;
		}

		public void setRequired(boolean required) {
			this.required = required;
		}

		public String getColumnName() {
			return columnName;
		}

		public void setColumnName(String columnName) {
			this.columnName = columnName;
		}

		public boolean isPrimaryKey() {
			return isPrimaryKey;
		}

		public void setPrimaryKey(boolean isPrimaryKey) {
			this.isPrimaryKey = isPrimaryKey;
		}

		public boolean isIndex() {
			return isIndex;
		}

		public void setIndex(boolean isIndex) {
			this.isIndex = isIndex;
		}

		public String getColumnType() {
			return columnType;
		}

		public void setColumnType(String columnType) {
			this.columnType = columnType;
		}

		public boolean isIgnoreMe() {
			return ignoreMe;
		}

		public void setIgnoreMe(boolean ignoreMe) {
			this.ignoreMe = ignoreMe;
		}

		public boolean isTransient() {
			return isTransient;
		}

		public void setTransient(boolean isTransient) {
			this.isTransient = isTransient;
		}
		
	}
	
	
	class SheetVO{
		private String className;
		private String superClass;
		private String attribute;
		private String type;
		private String length;
		private String isRequired;
		private String isTransient;
		private String index;
		private String version;
		public String getClassName() {
			return className;
		}
		public void setClassName(String className) {
			this.className = className;
		}
		public String getSuperClass() {
			return superClass;
		}
		public void setSuperClass(String superClass) {
			this.superClass = superClass;
		}
		public String getAttribute() {
			return attribute;
		}
		public void setAttribute(String attribute) {
			this.attribute = attribute;
		}
		public String getType() {
			return type;
		}
		public void setType(String type) {
			this.type = type;
		}
		public String getLength() {
			return length;
		}
		public void setLength(String length) {
			this.length = length;
		}
		
		public String getIsRequired() {
			return isRequired;
		}
		public void setIsRequired(String isRequired) {
			this.isRequired = isRequired;
		}
		
		public String getIndex() {
			return index;
		}
		public void setIndex(String index) {
			this.index = index;
		}
		public String getVersion() {
			return version;
		}
		public void setVersion(String version) {
			this.version = version;
		}

		public String getIsTransient() {
			return isTransient;
		}
		public void setIsTransient(String isTransient) {
			this.isTransient = isTransient;
		}
		@Override
		public String toString() {
			return "className=" + className 
					+ " superClass=" + superClass 
					+ " attribute=" + attribute 
					+ " type=" + type 
					+ " length=" + length
					+ " isKey=" + null
					+ " isTransient=" + isTransient
					+ " isRequired=" + isRequired;
		}
	}
}
