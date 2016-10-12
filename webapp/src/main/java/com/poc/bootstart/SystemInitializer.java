package com.poc.bootstart;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.net.JarURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.poc.common.entities.CodeMaster;
import com.poc.common.entities.Role;
import com.poc.common.entities.User;
import com.poc.service.AssetEntryService;
import com.poc.service.CodeService;
import com.poc.service.RoleService;
import com.poc.service.UserService;
import com.poc.utils.constants.PortalConstants;
import com.poc.utils.constants.RoleConstants;
import com.poc.utils.util.PortalContext;
import com.poc.utils.util.StringUtil;

@Component
public class SystemInitializer implements ApplicationContextAware {
	
	private ApplicationContext applicationContext;

	public void setApplicationContext(ApplicationContext arg0)
			throws BeansException {
		this.applicationContext = arg0;
		try {
			initialClasses();
			initialUserRole();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	private void initialUserRole(){
		try {
			System.out.println("initial basic user role");
			if (applicationContext == null) {
				throw new IllegalStateException("Can not initialization context");
			}

			UserService userService = (UserService) applicationContext.getBean("userService");
			RoleService roleService = (RoleService) applicationContext.getBean("roleService");
			PasswordEncoder passwordEncoder = (PasswordEncoder) applicationContext.getBean("passwordEncoder");
		
			String[][] sytemroles = new String[][]{new String[]{RoleConstants.ROLE_SYS_ADMIN, "Administrator", "1"}};
			for(String[] rolename : sytemroles){
				try {
					Role role = roleService.findRoleByName(rolename[0]);
					if(role==null){
						role = new Role();
						role.setName(rolename[0]);
						role.setDisplay(PortalConstants.DATA_STATUS_NO);
						role.setDescription(rolename[1]);
						role.setDisplayOrder(Long.valueOf(rolename[2]));
						roleService.save(role);
					}else{
						role.setDisplay(PortalConstants.DATA_STATUS_NO);
						role.setDescription(rolename[1]);
						role.setDisplayOrder(Long.valueOf(rolename[2]));
						roleService.update(role);
					}
				} catch (Exception e) {
					System.out.println("Error : initial role. " + StringUtil.getExceptionTrace(e, 500));
				}
			}
			
			String[][] portalroles = new String[][]{
					new String[]{RoleConstants.ROLE_ADMIN, "Admin", "1"}
					};
			for(String[] rolename : portalroles){
				try {
					Role role = roleService.findRoleByName(rolename[0]);
					if(role==null){
						role = new Role();
						role.setName(rolename[0]);
						role.setDisplay(PortalConstants.DATA_STATUS_YES);
						role.setDescription(rolename[1]);
						role.setDisplayOrder(Long.valueOf(rolename[2]));
						roleService.save(role);
					}else{
						role.setDisplay(PortalConstants.DATA_STATUS_YES);
						role.setDescription(rolename[1]);
						role.setDisplayOrder(Long.valueOf(rolename[2]));
						roleService.update(role);
					}
				} catch (Exception e) {
					System.out.println("Error : initial role. " + StringUtil.getExceptionTrace(e, 500));
				}
			}	
			
			try {
				Role r1 = roleService.findRoleByName(RoleConstants.ROLE_SYS_ADMIN);
				User user = userService.findUserByName(PortalConstants.DEFAULT_SYSTEM_ADMIN);
				if(user==null){
					user = new User();
					user.setUsername(PortalConstants.DEFAULT_SYSTEM_ADMIN);
					user.setPassword(passwordEncoder.encode("8@$$w0rd"));
					user.setStatus(PortalConstants.DATA_STATUS_ACTIVE);
					userService.createUser(user, new long[]{r1.getRoleId()}, null, new PortalContext());
				}
			} catch (Exception e) {
				System.out.println("Error : initial pb admin user. " + StringUtil.getExceptionTrace(e, 500));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void initialCodes() {
		try {
			System.out.println("initial basic codes");
			if (applicationContext == null) {
				throw new IllegalStateException("Can not initialization context");
			}

			CodeService codeService = (CodeService) applicationContext.getBean("codeService");
			
			List<CodeMaster> codelist = listAllCode();
			if(codelist!=null && codelist.size()>0){
				for(CodeMaster code : codelist){
					try {
						CodeMaster dbcode = codeService.findCode(code.getCodeKey(), String.valueOf(code.getType()));
						if(dbcode==null){
							codeService.saveCode(code);
						}else{
							dbcode.setCodeValue(code.getCodeValue());
							dbcode.setDescription(code.getDescription());
							codeService.updateCode(dbcode);
						}
					} catch (Exception e) {
						System.out.println("error on update/add code " + e.getMessage());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void initialClasses() {
		try {
			System.out.println("initial basic classes");
			if (applicationContext == null) {
				throw new IllegalStateException("Can not initialization context");
			}

			AssetEntryService assetEntryService = (AssetEntryService) applicationContext.getBean("assetEntryService");

			System.out.println("Scan all entities...");
			Set<Class<?>> entitySet = getClasses("com.poc.common.entities");
			System.out.println("Find current entities {" + entitySet + "}");
			
			Iterator<Class<?>> itor = entitySet.iterator();
			while(itor.hasNext()){
				Class<?> clazz = itor.next();
				try {
					assetEntryService.addClasses(clazz);
				} catch (Exception e) {
					System.out.println("Error on process entry " + clazz.getName());
					System.out.println(StringUtil.getExceptionTrace(e, -1));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static Set<Class<?>> getClasses(String pack) {
		Set<Class<?>> classes = new LinkedHashSet<Class<?>>();
		boolean recursive = true;
		String packageName = pack;
		String packageDirName = packageName.replace('.', '/');
		Enumeration<URL> dirs;
		try {
			dirs = Thread.currentThread().getContextClassLoader().getResources(packageDirName);
			while (dirs.hasMoreElements()) {
				URL url = dirs.nextElement();
				String protocol = url.getProtocol();
				if ("file".equals(protocol)) {
					String filePath = URLDecoder.decode(url.getFile(), "UTF-8");
					findAndAddClassesInPackageByFile(packageName, filePath,recursive, classes);
				} else if ("jar".equals(protocol)) {
					JarFile jar;
					try {
						jar = ((JarURLConnection) url.openConnection()).getJarFile();
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
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return classes;
	}

	public static void findAndAddClassesInPackageByFile(String packageName,
			String packagePath, final boolean recursive, Set<Class<?>> classes) {
		File dir = new File(packagePath);
		if (!dir.exists() || !dir.isDirectory()) {
			return;
		}
		File[] dirfiles = dir.listFiles(new FileFilter() {
			public boolean accept(File file) {
				return (recursive && file.isDirectory()) || (file.getName().endsWith(".class"));
			}
		});
		for (File file : dirfiles) {
			if (file.isDirectory()) {
				findAndAddClassesInPackageByFile(packageName + "." + file.getName(), file.getAbsolutePath(), recursive, classes);
			} else {
				String className = file.getName().substring(0,
						file.getName().length() - 6);
				try {
					classes.add(Thread.currentThread().getContextClassLoader().loadClass(packageName + '.' + className));
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	
	public static List<CodeMaster> listAllCode(){
		try {
			List<CodeMaster> list = new ArrayList<CodeMaster>();
			
			Workbook book = Workbook.getWorkbook(SystemInitializer.class.getResourceAsStream("/mastercodes.xls"));
			Sheet sheet = book.getSheet(0);
			int rowsLength = sheet.getRows();
			for(int i=1; i<rowsLength; i++){
				try {
					Cell[] cells = sheet.getRow(i);
					
					String type = cells[0].getContents();
					String codeKey = cells[1].getContents();
					String codeValue = cells[2].getContents();
					String desc = cells[3].getContents();
					
					if(StringUtil.isNull(codeKey) || StringUtil.isNull(codeValue)){
						continue;
					}
					
					System.out.println("master code row : [" + type + "][" + codeKey +"][" + codeValue + "][" + desc + "]");
					
					CodeMaster code = new CodeMaster();
					code.setType(type);
					code.setCodeKey(codeKey);
					code.setCodeValue(codeValue);
					code.setDescription(desc);
					
					list.add(code);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static void main(String[] args) {
		System.out.println(new BCryptPasswordEncoder().encode("password1"));
	}
}
