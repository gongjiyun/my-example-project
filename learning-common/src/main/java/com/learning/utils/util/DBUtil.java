package com.learning.utils.util;

import java.io.File;
import java.io.FileFilter;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.net.JarURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

import com.learning.common.annotation.Column;
import com.learning.common.annotation.Id;
import com.learning.common.annotation.Table;
import com.learning.common.db.IdGenHandler;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.learning.utils.util.StringUtil;

public class DBUtil {

	protected static Log log = LogFactory.getLog(DBUtil.class.getName());
	private static Map<String, AnnoTable> tableMap = new ConcurrentHashMap<String, AnnoTable>();
	
	private static DBUtil instance = new DBUtil();
	
	public static DBUtil getInstance(){
		return instance;
	}
	
	private static String[] packageList = { "com.learning.common.entity" };
	
	static {
		for(String pack : packageList){			
			log.info("Scan package " + pack);
			try {
				Set<Class<?>> classList = getClasses(pack);
				Iterator<Class<?>> cltor = classList.iterator();
				while(cltor.hasNext()){
					Class<?> clazz = cltor.next();
					registerTableTO(clazz);
				}
			} catch (Exception e) {
				log.error("Scan package common TO mapping error", e);
			}
		}
	}
	
	private synchronized static Set<Class<?>> getClasses(String pack) throws Exception {
		Set<Class<?>> classes = new LinkedHashSet<Class<?>>();
		boolean recursive = true;
		String packageName = pack;
		String packageDirName = packageName.replace('.', '/');
		Enumeration<URL> dirs = Thread.currentThread().getContextClassLoader().getResources(packageDirName);
		while (dirs.hasMoreElements()) {
			URL url = dirs.nextElement();
			String protocol = url.getProtocol();
			if ("file".equals(protocol)) {
				String filePath = URLDecoder.decode(url.getFile(), "UTF-8");
				findAndAddClassesInPackageByFile(packageName, filePath, recursive, classes);
			} else if ("jar".equals(protocol)) {
				JarFile jar = ((JarURLConnection) url.openConnection()).getJarFile();
				Enumeration<JarEntry> entries = jar.entries();
				while (entries.hasMoreElements()) {
					JarEntry entry = entries.nextElement();
					String name = entry.getName();
					if (name.charAt(0) == '/') {
						name = name.substring(1);
					}
					if (name.startsWith(packageDirName)) {
						int idx = name.lastIndexOf('/');
						if (idx != -1) {
							packageName = name.substring(0, idx).replace('/', '.');
						}
						if ((idx != -1) || recursive) {
							if (name.endsWith(".class") && !entry.isDirectory()) {
								String className = name.substring(packageName.length() + 1, name.length() - 6);
								try {
									classes.add(Class.forName(packageName + '.' + className));
								} catch (ClassNotFoundException e) {
									e.printStackTrace();
								}
							}
						}
					}
				}
			}
		}

		return classes;
	}

    /** 
     * @param packageName 
     * @param packagePath 
     * @param recursive 
     * @param classes 
     */  
	private static void findAndAddClassesInPackageByFile(String packageName, String packagePath, final boolean recursive,
			Set<Class<?>> classes) {
		File dir = new File(packagePath);

		if (!dir.exists() || !dir.isDirectory()) {
			log.warn("Package " + packageName + " cannot find class");
			return;
		}
		File[] dirfiles = dir.listFiles(new FileFilter() {
			public boolean accept(File file) {
				return (recursive && file.isDirectory()) || (file.getName().endsWith(".class"));
			}
		});

		for (File file : dirfiles) {

			if (file.isDirectory()) {
				findAndAddClassesInPackageByFile(packageName + "." + file.getName(), file.getAbsolutePath(), recursive,
						classes);
			} else {
				String className = file.getName().substring(0, file.getName().length() - 6);
				try {
					classes.add(
							Thread.currentThread().getContextClassLoader().loadClass(packageName + '.' + className));
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	protected static class AnnoTable{
		private String tableName;
		private boolean cache;
		
		private Map<String, AnnoField> fieldMap = new ConcurrentHashMap<String, AnnoField>();
		public String getTableName() {
			return tableName;
		}
		public void setTableName(String tableName) {
			this.tableName = tableName;
		}
		public Map<String, AnnoField> getFieldMap() {
			return fieldMap;
		}
		public void setFieldMap(Map<String, AnnoField> fieldMap) {
			this.fieldMap = fieldMap;
		}
		public boolean isCache() {
			return cache;
		}
		public void setCache(boolean cache) {
			this.cache = cache;
		}
		
	}
	
	protected static class AnnoField{
		private String columnName;
		private String fieldName;
		private String ctype;
		private boolean update;
		private boolean basicType;
		private Class<?> type;
		private Id idAnno;
		private Column columnAnno;
		private String filedGetMethodName;
		private String filedSetMethodName;
		
		@Override
		public String toString() {
			return "" 
					+ " columnName=" + columnName
					+ ", fieldName=" + fieldName
					+ ", ctype=" + ctype
					+ ", update=" + update
					+ ", basicType=" + basicType
					+ ", type=" + type
					+ ", idAnno=" + idAnno
					+ ", columnAnno=" + columnAnno
					+ ", filedGetMethodName=" + filedGetMethodName
					+ ", filedSetMethodName=" + filedSetMethodName;
		}

		public String getFiledGetMethodName() {
			return filedGetMethodName;
		}
		public void setFiledGetMethodName(String filedGetMethodName) {
			this.filedGetMethodName = filedGetMethodName;
		}
		public String getFiledSetMethodName() {
			return filedSetMethodName;
		}
		public void setFiledSetMethodName(String filedSetMethodName) {
			this.filedSetMethodName = filedSetMethodName;
		}
		public String getColumnName() {
			return columnName;
		}
		public void setColumnName(String columnName) {
			this.columnName = columnName;
		}
		public String getFieldName() {
			return fieldName;
		}
		public void setFieldName(String fieldName) {
			this.fieldName = fieldName;
		}
		public Id getIdAnno() {
			return idAnno;
		}
		public boolean isBasicType() {
			return basicType;
		}
		public void setBasicType(boolean basicType) {
			this.basicType = basicType;
		}
		public void setIdAnno(Id idAnno) {
			this.idAnno = idAnno;
		}
		public Column getColumnAnno() {
			return columnAnno;
		}
		public void setColumnAnno(Column columnAnno) {
			this.columnAnno = columnAnno;
		}
		public String getCtype() {
			return ctype;
		}
		public void setCtype(String ctype) {
			this.ctype = ctype;
		}
		public Class<?> getType() {
			return type;
		}
		public void setType(Class<?> type) {
			this.type = type;
		}
		public boolean isUpdate() {
			return update;
		}
		public void setUpdate(boolean update) {
			this.update = update;
		}
		
	}

	public synchronized static void registerTableTO(Class<?> clazz){
		String clazzName = clazz.getName();
		
		if(tableMap.containsKey(clazzName)){
			log.debug(clazzName + " already mapping");
		}

		Table annoTable = clazz.getAnnotation(Table.class);
		if(annoTable==null){
			log.debug("Class [" + clazz + "] have no any table annotation.");
			return;
		}

		log.debug("registerTableTO : " + clazzName);
		
		String tableName = "N.A";
		boolean cache = annoTable.cached();
		if(StringUtil.isNotBlank(annoTable.name())){
			tableName = annoTable.name();
		}else if(StringUtil.isNotBlank(annoTable.value())){
			tableName = annoTable.value();
		}

		AnnoTable anTab = new AnnoTable();
		anTab.setCache(cache);
		anTab.setTableName(tableName);
		log.debug("****************************** table mapping ******************************");
		log.debug("Table Mapping : name=" + tableName);
		log.debug("Table Mapping : cache=" + cache);
		
		Field[] fields = clazz.getDeclaredFields();
		if(fields!=null && fields.length>0){
			Map<String, AnnoField> fieldMap = new HashMap<String, AnnoField>();
			for(Field field : fields){
				try {
					AnnoField annoField = new AnnoField();
					
					Column colAnno = field.getAnnotation(Column.class);
					
					if(colAnno==null){
						continue;
					}
					
					annoField.setColumnAnno(colAnno);
					annoField.setColumnName(colAnno.columnName());
					annoField.setUpdate(colAnno.update());

					boolean isBasic = false;
					
					Id idAnno = field.getAnnotation(Id.class);
					if(idAnno!=null){
						annoField.setIdAnno(idAnno);							
					}else if("long".equalsIgnoreCase(String.valueOf(annoField.getCtype()))){
						isBasic = true;
					}else if("int".equalsIgnoreCase(String.valueOf(annoField.getCtype()))){
						isBasic = true;
					}else if("float".equalsIgnoreCase(String.valueOf(annoField.getCtype()))){
						isBasic = true;
					}else if("double".equalsIgnoreCase(String.valueOf(annoField.getCtype()))){
						isBasic = true;
					}
					
					annoField.setBasicType(isBasic);
					annoField.setFieldName(field.getName());
					annoField.setCtype(field.getType().getName());
					annoField.setType(field.getType());

					String smethodName = "set" + field.getName().substring(0,1).toUpperCase() +  field.getName().substring(1);
					String gmethodName = "get" + field.getName().substring(0,1).toUpperCase() +  field.getName().substring(1);
					annoField.setFiledSetMethodName(smethodName);
					annoField.setFiledGetMethodName(gmethodName);

					log.debug("Column & Field Mapping : " + annoField.toString());
					
					if(field.getAnnotations()!=null && field.getAnnotations().length>0){
						fieldMap.put(annoField.getFieldName(), annoField);
					}
				} catch (Exception e) {
					log.error("Error on mapping table & fields", e);
				}
			}
			anTab.setFieldMap(fieldMap);
		}
		tableMap.put(clazzName, anTab);

	}
	
	public void wrapResult(Object obj, ResultSet resultSet) throws Exception{
		String clazzName = obj.getClass().getName();
		registerTableTO(obj.getClass());

		AnnoTable annTab = tableMap.get(clazzName);
		Map<String, AnnoField> fieldMaps = annTab.getFieldMap();
		
		if(fieldMaps!=null && !fieldMaps.isEmpty()){
			Set<Map.Entry<String, AnnoField>> fEntry = fieldMaps.entrySet();
			Iterator<Map.Entry<String, AnnoField>> itor = fEntry.iterator();
			while(itor.hasNext()){
				Map.Entry<String, AnnoField> en = itor.next();
				AnnoField annoField = en.getValue();

				try {
					Object value = null;
					if(annoField.getType()==String.class){
						value = resultSet.getString(annoField.getColumnName());
					}else if(annoField.getType()==Date.class){
						value = new Date(resultSet.getTimestamp(annoField.getColumnName()).getTime());
					}else if(annoField.getType()==java.sql.Date.class){
						value = resultSet.getTimestamp(annoField.getColumnName());
					}else if(annoField.getType()==Integer.class){
						value = getInteger(annoField.getColumnName(), resultSet);
					}else if(annoField.getType()==Long.class){
						value = resultSet.getLong(annoField.getColumnName());
					}else if(annoField.getType()==Double.class){
						value = resultSet.getDouble(annoField.getColumnName());
					}else if(annoField.getType()==Float.class){
						value = resultSet.getFloat(annoField.getColumnName());
					}else if(annoField.getType()==BigDecimal.class){
						value = resultSet.getBigDecimal(annoField.getColumnName());
					}else if("long".equalsIgnoreCase(String.valueOf(annoField.getCtype()))){
						value = resultSet.getLong(annoField.getColumnName());
					}else if("int".equalsIgnoreCase(String.valueOf(annoField.getCtype()))){
						value = resultSet.getInt(annoField.getColumnName());
					}else if("float".equalsIgnoreCase(String.valueOf(annoField.getCtype()))){
						value = resultSet.getFloat(annoField.getColumnName());
					}else if("double".equalsIgnoreCase(String.valueOf(annoField.getCtype()))){
						value = resultSet.getDouble(annoField.getColumnName());
					}else{
						log.warn("Type not match : " + annoField.getCtype() + ", field [" + annoField.getFieldName() + "][" + annoField.getColumnName() + "]");
					}
					
					Method mth = obj.getClass().getDeclaredMethod(annoField.getFiledSetMethodName(), annoField.getType());
					
					mth.invoke(obj, value);
				} catch (Exception e) {
					log.error("Cannot mapping field [" + annoField.getFieldName() + "][" + annoField.getColumnName() + "]", e);
				}
			}
		}
		
	}
	
	public long persist(Object to, Connection conn) throws Exception{
		long result = 0;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			StringBuffer sb = new StringBuffer();
			StringBuffer columsStr = new StringBuffer();
			StringBuffer valuesStr = new StringBuffer();
			
			String clazzName = to.getClass().getName();
			if(!tableMap.containsKey(clazzName)){
				registerTableTO(to.getClass());
			}
			
			AnnoTable annTab = tableMap.get(clazzName);
			if(annTab==null){
				throw new Exception("No table annotaion specify");
			}
			
			LinkedList<Object> params = new LinkedList<Object>();
			String generatedColumns[] = null;
			String sequenceName = null;
			
			sb.append("INSERT INTO " + annTab.getTableName() + " (");
			
			Map<String, AnnoField> fieldMaps = annTab.getFieldMap();
			
			if(fieldMaps!=null && !fieldMaps.isEmpty()){
				Set<Map.Entry<String, AnnoField>> fEntry = fieldMaps.entrySet();
				Iterator<Map.Entry<String, AnnoField>> itor = fEntry.iterator();
				while(itor.hasNext()){
					Map.Entry<String, AnnoField> en = itor.next();
					AnnoField annoField = en.getValue();

					boolean generateID = false;
                    boolean generateSeqID = false;

					Id idAnno = annoField.getIdAnno();
					if(idAnno!=null && "sequence".equals(idAnno.idGenStrage()) && StringUtil.isNotBlank(idAnno.sequence())){
						sequenceName = idAnno.sequence();
						generatedColumns = new String[]{annoField.getColumnName()};
                        generateSeqID = true;
                        generateID = false;
					}else if(idAnno.idGenHandler()!= IdGenHandler.class){
                        generateID = true;
                        generateSeqID = false;
                    }else{
                        generateID = false;
                        generateSeqID = false;
					}
					if(generateSeqID){
						columsStr.append(annoField.getColumnName() + ",");
						valuesStr.append(sequenceName + ",");
					}else if(generateID){
                        columsStr.append(annoField.getColumnName() + ",");
                        valuesStr.append("?,");
                    }else{
						columsStr.append(annoField.getColumnName() + ",");
						valuesStr.append("?,");	
					}
					
					if(generateSeqID){
					    continue;
                    }
					if(generateID){
						Object value = getMethodValue(to, annoField.getFiledGetMethodName());							
						params.add(value);
					}else{
					    IdGenHandler idGHandler = (IdGenHandler)idAnno.idGenHandler().newInstance();
                        Object value =idGHandler.generate();
                        params.add(value);
                    }
				}
			}
			
			sb.append(columsStr.toString());
			sb.append(") VALUES (");
			sb.append(valuesStr.toString());
			sb.append(")");
			
			String sql = sb.toString();
			sql = sql.replaceAll("[,]\\)", ")");
			
			log.debug("sql:" + sql);
			
			if(generatedColumns!=null && generatedColumns.length>0){
				ps = conn.prepareStatement(sql, generatedColumns);
			}else{
				ps = conn.prepareStatement(sql);
			}

			setParameters(ps, params);	
			
			log.debug("Params#" + params);
			
			result = ps.executeUpdate();
			if(generatedColumns!=null && generatedColumns.length>0){
				rs = ps.getGeneratedKeys();
				if (rs.next()){				
					long key = rs.getLong(1);
					log.debug("The value of generate key : " + key);
					return key;
				}
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
		}
		return result;
	}
	
	public <T> T findById(Object key, Class<T> clazz, Connection conn) throws Exception{
		PreparedStatement ps = null;
		ResultSet rs = null;
		T result;
		try {
			StringBuffer sb = new StringBuffer();

			String clazzName = clazz.getName();
			registerTableTO(clazz);
			
			AnnoTable annTab = tableMap.get(clazzName);
			if(annTab==null){
				throw new Exception("No table annotaion specify");
			}

			LinkedList<Object> params = new LinkedList<Object>();
			params.add(key);
			
			sb.append("SELECT * FROM " + annTab.getTableName() + " WHERE 1=1 ");
			
			Map<String, AnnoField> fieldMaps = annTab.getFieldMap();
			
			if(fieldMaps!=null && !fieldMaps.isEmpty()){
				Set<Map.Entry<String, AnnoField>> fEntry = fieldMaps.entrySet();
				Iterator<Map.Entry<String, AnnoField>> itor = fEntry.iterator();
				while(itor.hasNext()){
					Map.Entry<String, AnnoField> en = itor.next();
					AnnoField annoField = en.getValue();

					Id idAnno = annoField.getIdAnno();
					if(idAnno!=null){
						sb.append("AND " + annoField.getColumnName() + " = ? ");
					}
				}
			}
			
			String sql = sb.toString();
			sql = sql.replaceAll("[,]\\)", ")");
			
			log.debug("sql:" + sql);
			
			ps = conn.prepareStatement(sql);

			setParameters(ps, params);	
			
			log.debug("Params#" + params);
			
			rs = ps.executeQuery();
			
			result = clazz.newInstance();
			
			while (rs != null && rs.next()) {
				wrapResult(result, rs);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
		}
		return result;
	}
	
	public long delete(Object criteria, Connection conn) throws Exception{
		registerTableTO(criteria.getClass());
		
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			StringBuffer sb = new StringBuffer();

			String clazzName = criteria.getClass().getName();
			AnnoTable annTab = tableMap.get(clazzName);
			if(annTab==null){
				throw new Exception("No table annotaion specify");
			}

			LinkedList<Object> params = new LinkedList<Object>();
			
			sb.append("DELETE FROM " + annTab.getTableName() + " WHERE 1=1 ");
			
			Map<String, AnnoField> fieldMaps = annTab.getFieldMap();
			
			if(fieldMaps!=null && !fieldMaps.isEmpty()){
				Set<Map.Entry<String, AnnoField>> fEntry = fieldMaps.entrySet();
				Iterator<Map.Entry<String, AnnoField>> itor = fEntry.iterator();
				while(itor.hasNext()){
					Map.Entry<String, AnnoField> en = itor.next();
					AnnoField annoField = en.getValue();
					
					Object value = getMethodValue(criteria, annoField.getFiledGetMethodName());
					
					if(annoField.isBasicType() && "0".equals(String.valueOf(value))){
						log.warn("Basic type field=0 cannot be handle as condition. -> " + annoField.getFieldName());
						continue;
					}
					
					Id idAnno = (Id) annoField.getIdAnno();
					if(idAnno!=null && value!=null){
						sb.append("AND " + annoField.getColumnName() + " = ? ");
						params.add(value);
						break;
					}else if(value!=null){
						sb.append("AND " + annoField.getColumnName() + " = ? ");
						params.add(value);
					}
				}
			}
			
			String sql = sb.toString();
			sql = sql.replaceAll("[,]\\)", ")");
			
			log.debug("sql:" + sql);
			
			ps = conn.prepareStatement(sql);

			if(params==null || params.size()==0){
				throw new Exception("Delete item conditions must specify");
			}
			
			setParameters(ps, params);	
			
			log.debug("Params#" + params);
			
			return ps.executeUpdate();
			
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
		}
	}

	public long update(Object to, Connection conn) throws Exception{
		registerTableTO(to.getClass());
		
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			StringBuffer sb = new StringBuffer();
			StringBuffer columsStr = new StringBuffer();
			StringBuffer valuesStr = new StringBuffer();
			
			String clazzName = to.getClass().getName();
			
			AnnoTable annTab = tableMap.get(clazzName);
			if(annTab==null){
				throw new Exception("No table annotaion specify");
			}

			LinkedList<Object> params = new LinkedList<Object>();
			
			sb.append("UPDATE " + annTab.getTableName() + " SET ");
			
			Map<String, AnnoField> fieldMaps = annTab.getFieldMap();
			
			if(fieldMaps!=null && !fieldMaps.isEmpty()){
				Set<Map.Entry<String, AnnoField>> cEntry = fieldMaps.entrySet();
				Iterator<Map.Entry<String, AnnoField>> citor = cEntry.iterator();
				while(citor.hasNext()){
					Map.Entry<String, AnnoField> en = citor.next();
					AnnoField annoField = en.getValue();
					
					if(annoField.isUpdate()){
						columsStr.append(annoField.getColumnName() + " = ?, ");

						Object value = getMethodValue(to, annoField.getFiledGetMethodName());
						
						params.add(value);
					}
				}
				
				columsStr = new StringBuffer(columsStr.toString().substring(0, columsStr.toString().length()-2) + " ");
				
				valuesStr.append("WHERE ");
				Set<Map.Entry<String, AnnoField>> fEntry = fieldMaps.entrySet();
				Iterator<Map.Entry<String, AnnoField>> itor = fEntry.iterator();
				while(itor.hasNext()){
					Map.Entry<String, AnnoField> en = itor.next();
					AnnoField annoField = en.getValue();
					
					Object value = getMethodValue(to, annoField.getFiledGetMethodName());

					if(annoField.isBasicType() && "0".equals(String.valueOf(value))){
						log.warn("Basic type field=0 cannot be handle as condition. -> " + annoField.getFieldName());
						continue;
					}
					
					Id idAnno = annoField.getIdAnno();
					if(idAnno!=null && value!=null){
						valuesStr.append(annoField.getColumnName() + " = ? ");
						params.add(value);
						break;
					}
				}
			}
			
			sb.append(columsStr);
			sb.append(valuesStr);
			
			String sql = sb.toString();
			sql = sql.replaceAll("[,]\\)", ")");
			
			log.debug("sql:" + sql);
			
			ps = conn.prepareStatement(sql);

			if(params==null || params.size()==0){
				throw new Exception("Delete condition @Id must specify");
			}
			
			setParameters(ps, params);	
			
			log.debug("Params#" + params);
			
			return ps.executeUpdate();
			
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
		}
	}
	
	private static Object getMethodValue(Object dbObject, String methodName) throws Exception{	
		
		try {
			Method mth = dbObject.getClass().getDeclaredMethod(methodName);
			Object value = mth.invoke(dbObject);
			
			return value;	
		} catch (Exception e) {
			log.error("Error on invocation method [" + methodName + "]", e);
		}
		return null;
	}

	public long update(Object paramterObj, Object destObject, Connection conn) throws Exception{
		registerTableTO(destObject.getClass());
		
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			StringBuffer sb = new StringBuffer();
			StringBuffer columsStr = new StringBuffer();
			StringBuffer valuesStr = new StringBuffer();
			
			String clazzName = destObject.getClass().getName();
			
			AnnoTable annTab = tableMap.get(clazzName);
			if(annTab==null){
				throw new Exception("No table annotaion specify");
			}

			LinkedList<Object> params = new LinkedList<Object>();
			
			sb.append("UPDATE " + annTab.getTableName() + " SET ");
			
			Map<String, AnnoField> fieldMaps = annTab.getFieldMap();
			
			if(fieldMaps!=null && !fieldMaps.isEmpty()){
				Set<Map.Entry<String, AnnoField>> cEntry = fieldMaps.entrySet();
				Iterator<Map.Entry<String, AnnoField>> citor = cEntry.iterator();
				while(citor.hasNext()){
					Map.Entry<String, AnnoField> en = citor.next();
					AnnoField annoField = en.getValue();

					if(annoField.isUpdate()){
						Object value = getMethodValue(destObject, annoField.getFiledGetMethodName());
						columsStr.append(annoField.getColumnName() + " = ?, ");
						params.add(value);
					}
				}
				
				columsStr = new StringBuffer(columsStr.toString().substring(0, columsStr.toString().length()-2) + " ");
				
				valuesStr.append("WHERE 1=1 ");
				
				Set<Map.Entry<String, AnnoField>> fEntry = fieldMaps.entrySet();
				Iterator<Map.Entry<String, AnnoField>> itor = fEntry.iterator();
				while(itor.hasNext()){
					Map.Entry<String, AnnoField> en = itor.next();
					AnnoField annoField = en.getValue();
					
					Object value = getMethodValue(paramterObj, annoField.getFiledGetMethodName());

					if(annoField.isBasicType() && "0".equals(String.valueOf(value))){
						log.warn("Basic type field=0 cannot be handle as condition. -> " + annoField.getFieldName());
						continue;
					}
					
					Id idAnno = annoField.getIdAnno();
					if(idAnno!=null && value!=null){
						valuesStr.append("AND " + annoField.getColumnName() + " = ? ");
						params.add(value);
					}else if(value!=null){
						valuesStr.append("AND " + annoField.getColumnName() + " = ? ");
						params.add(value);
					}
				}
			}
			
			sb.append(columsStr);
			sb.append(valuesStr);
			
			String sql = sb.toString();
			sql = sql.replaceAll("[,]\\)", ")");
			
			log.debug("sql:" + sql);
			
			ps = conn.prepareStatement(sql);

			if(params==null || params.size()==0){
				throw new Exception("Update conditions example must specify");
			}
			
			setParameters(ps, params);	
			
			log.debug("Params#" + params);
			
			return ps.executeUpdate();
			
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
		}
	}
	
	@SuppressWarnings("unchecked")
	public <T> List<T> search(T criteria, Connection conn) throws Exception{
		registerTableTO(criteria.getClass());
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<T> result = new ArrayList<T>();
		try {
			StringBuffer sb = new StringBuffer();

			String clazzName = criteria.getClass().getName();
			
			AnnoTable annTab = tableMap.get(clazzName);
			if(annTab==null){
				throw new Exception("No table annotaion specify");
			}

			LinkedList<Object> params = new LinkedList<Object>();
			sb.append("SELECT * FROM " + annTab.getTableName() + " WHERE 1=1 ");
			
			Map<String, AnnoField> fieldMaps = annTab.getFieldMap();
			
			if(fieldMaps!=null && !fieldMaps.isEmpty()){
				Set<Map.Entry<String, AnnoField>> fEntry = fieldMaps.entrySet();
				Iterator<Map.Entry<String, AnnoField>> itor = fEntry.iterator();
				while(itor.hasNext()){
					Map.Entry<String, AnnoField> en = itor.next();
					AnnoField annoField = en.getValue();

					Object value = getMethodValue(criteria, annoField.getFiledGetMethodName());
					
					if(annoField.isBasicType() && "0".equals(String.valueOf(value))){
						log.warn("Basic type field=0 cannot be handle as condition. -> " + annoField.getFieldName());
						continue;
					}
					
					Id idAnno = annoField.getIdAnno();
					if(value!=null){
						sb.append("AND " + annoField.getColumnName() + " = ? ");
						params.add(value);
					}
				}
			}
			
			String sql = sb.toString();
			sql = sql.replaceAll("[,]\\)", ")");
			
			log.debug("sql:" + sql);

			ps = conn.prepareStatement(sql);

			setParameters(ps, params);	
			
			log.debug("Params#" + params);
			
			rs = ps.executeQuery();
			
			while (rs != null && rs.next()) {
				T obj = (T) criteria.getClass().newInstance();
				
				wrapResult(obj, rs);
				
				result.add(obj);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
		}
		return result;
	}
	
	/**
	 * Reduce columns retrieve
	 * @param columns
	 * @param passValues
	 * @param clazz
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public <T> List<T> search(String[] columns, Object[] passValues, Class<T> clazz, Connection conn) throws Exception{
		registerTableTO(clazz);
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<T> result = new ArrayList<T>();
		try {
			StringBuffer sb = new StringBuffer();

			String clazzName = clazz.getName();
			
			AnnoTable annTab = tableMap.get(clazzName);
			if(annTab==null){
				throw new Exception("No table annotaion specify");
			}

			LinkedList<Object> params = new LinkedList<Object>();
			for(Object param : passValues){
				params.add(param);
			}
			
			sb.append("SELECT * FROM " + annTab.getTableName() + " WHERE 1=1 ");
			for(Object cln : columns){
				sb.append("AND " + cln + " = ? ");
			}
			
			
			String sql = sb.toString();
			sql = sql.replaceAll("[,]\\)", ")");
			
			log.debug("sql:" + sql);

			ps = conn.prepareStatement(sql);

			setParameters(ps, params);	
			
			log.debug("Params#" + params);
			
			rs = ps.executeQuery();
			
			while (rs != null && rs.next()) {
				T obj = clazz.newInstance();
				
				wrapResult(obj, rs);
				
				result.add(obj);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
		}
		return result;
	}
	
	
	private static void setParameters(PreparedStatement stmt, List<Object> params) throws Exception
	{
		int i = 0;
		for(Object param:params){	
			if (param == null)
				stmt.setString(++i, null);
			if (param instanceof String)
				stmt.setString(++i, (String)param);
			if (param instanceof Integer)
				stmt.setInt(++i, (Integer)param);
			if (param instanceof Long)
				stmt.setLong(++i, (Long)param);
			if (param instanceof java.sql.Date)
				stmt.setDate(++i, (java.sql.Date)param);
			if (param instanceof Date)
				stmt.setDate(++i, (new java.sql.Date(((Date)param).getTime())));
			if (param instanceof Timestamp)
				stmt.setTimestamp(++i, (Timestamp)param);
			if (param instanceof BigDecimal)
				stmt.setBigDecimal(++i, (BigDecimal)param);
			if(param instanceof Float)
				stmt.setFloat(++i, (Float)param);
		}

	}
	
	public static void main(String[] args) {
		DBUtil.getInstance();
	
	}
	
	public static String getInStatementConjection(List<String> lists){
		try {
			if(lists!=null && !lists.isEmpty()){
				String str = "";
				for(int i=0; i<lists.size(); i++){
					if(i==0){
						str = str + "'" + lists.get(i) + "'";
					}else{
						str = str + ", '" + lists.get(i) + "'";
					}
				}
				str = str + "";
				return str;
			}else{
				return "''";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info(e);
		}
		return null;
	}
	
	public static Integer getInteger(String column , ResultSet resultSet){
		try{
			if(resultSet==null || column == null){
				return null;
			}
			
			String intString = resultSet.getString(column);
			if(intString!=null && StringUtil.isNotBlank(intString)){
				return Integer.valueOf(intString);
			}
				
			return null;
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info(e);
		}
		return null;
	}
	
	public static Long getLong(String column , ResultSet resultSet){
		try{
			if(resultSet==null || column == null){
				return null;
			}
			
			String intString = resultSet.getString(column);
			if(intString!=null && StringUtil.isNotBlank(intString)){
				return Long.valueOf(intString);
			}
				
			return null;
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info(e);
		}
		return null;
	}

}
