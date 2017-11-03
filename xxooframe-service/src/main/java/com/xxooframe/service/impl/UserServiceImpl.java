package com.xxooframe.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.xxooframe.common.entities.Role;
import com.xxooframe.common.entities.User;
import com.xxooframe.common.entities.UserProfile;
import com.xxooframe.common.entities.UserRole;
import com.xxooframe.common.model.AuthUserDetails;
import com.xxooframe.common.model.GrantedAuthorityImpl;
import com.xxooframe.common.model.PageCriteria;
import com.xxooframe.dao.RoleDao;
import com.xxooframe.dao.UserDao;
import com.xxooframe.dao.UserProfileDao;
import com.xxooframe.dao.UserRoleDao;
import com.xxooframe.service.AbstractBaseService;
import com.xxooframe.service.RoleService;
import com.xxooframe.service.UserService;
import com.xxooframe.utils.constants.ErrorCodeConstants;
import com.xxooframe.utils.constants.StatusConstants;
import com.xxooframe.utils.constants.TableDefConstants;
import com.xxooframe.utils.exception.SystemException;
import com.xxooframe.utils.util.PortalContext;
import com.xxooframe.utils.util.QueryUtil;
import com.xxooframe.utils.util.StringUtil;


@Service("userService")
public class UserServiceImpl extends AbstractBaseService implements UserService, UserDetailsService {
	private final static Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	@Autowired
	private UserDao userDao;	
	@Autowired
	private RoleDao roleDao;	
	@Autowired
	private UserRoleDao userRoleDao;	
	@Autowired
	private UserProfileDao userProfileDao;	
	@Autowired
	private RoleService roleService;
	
	
	
	public List<User> loadUsers() throws SystemException{
		try {
			return userDao.loadUsers(QueryUtil.ALL_POS, QueryUtil.ALL_POS);
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
	
	public List<User> searchUsers(PageCriteria searchCriteria) throws SystemException{
		try {
			DetachedCriteria criteria=DetachedCriteria.forClass(UserProfile.class);
			if(searchCriteria!=null && searchCriteria.getParameters()!=null){
				if(searchCriteria.getParameters().get("username")!=null){
					criteria.add(Restrictions.like(TableDefConstants.UserProfile.screenName.name(), "%" + searchCriteria.getParameters().get("username") + "%"));
				}
				if(searchCriteria.getParameters().get("email")!=null){
					criteria.add(Restrictions.like(TableDefConstants.UserProfile.email.name(), searchCriteria.getParameters().get("email") + "%"));
				}
			}
			List<UserProfile> list = (List<UserProfile>) userProfileDao.findByDetachedCriteria(criteria);
			if(list!=null && list.size()>0){
				List<User> users = new ArrayList<User>();
				for(UserProfile p : list){
					users.add(userDao.findUserById(p.getUid()));
				}
				return users;
			}
			
			return null;
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
	
	public List<User> loadUsersByRole(String roleName) throws SystemException{
		try {
			List<User> list = new ArrayList<User>();
			Role role = roleService.findRoleByName(roleName);
			if(role!=null){
				List<UserRole> userroles = userRoleDao.findByColumn(TableDefConstants.UserRole.roleId.name(), role.getRoleId());
				if(userroles==null || userroles.size()==0){
					return null;
				}
				for(UserRole ur : userroles){
					User user = userDao.findUserById(ur.getUid());
					list.add(user);
				}
			}
			return list;
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
	
	public User findUserByName(String name) throws SystemException {
		try {
			return userDao.findUserByName(name);
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemException(ErrorCodeConstants.ERR_CODE_USER_NOT_FOUND, "user not found");
		}
	}
	
	public List<User> findUserByRoleId(long roleId) throws SystemException{
		try {
			List<UserRole> userroles = userRoleDao.findByColumn(TableDefConstants.UserRole.roleId.name(), roleId, QueryUtil.ALL_POS, QueryUtil.ALL_POS);
			if(userroles!=null && userroles.size()>0){
				List<User> users = new ArrayList<User>();
				for(UserRole ur : userroles){
					User user = findUserById(ur.getUid());
					users.add(user);
				}
				return users;
			}
			return null;
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
	
	public List<Role> findRolesByUID(long uid) throws SystemException{
		try {
			return userDao.findRolesByUID(uid);
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
	
	public List<UserRole> findUserRolesByUID(long uid) throws SystemException{
		try {
			return userDao.findUserRolesByUID(uid);
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}

	public long createUser(User user, long[] roleIds, UserProfile profile, PortalContext portalContext) throws SystemException{
		try {
			User checkuser = userDao.findUserByName(user.getUsername());
			if(checkuser!=null){
				throw new SystemException(ErrorCodeConstants.ERR_CODE_USER_DUPLICATE, "User " + user.getUsername() + " exist");
			}
			
			long uid = userDao.createUser(user);
			logger.info("create user with key " + uid);
			
			if(roleIds!=null && roleIds.length>0){
				for(long rid : roleIds){
					UserRole userRole = new UserRole();
					userRole.setUid(uid);
					userRole.setRoleId(rid);
					long userRoleId = userDao.createUserRole(userRole);
					logger.info("create user role " + userRoleId);
				}
			}
			
			if(profile!=null){
				profile.setUid(uid);
				profile.setScreenName(user.getUsername());
				long profileId = userProfileDao.save(profile);
				logger.info("create user profile " + profileId);
			}
			
			return uid;
		} catch (SystemException e) {
			throw new SystemException(e.getErrorCode(), e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemException(ErrorCodeConstants.ERR_CODE_USER_NOT_FOUND, "user can not create");
		}
	}
	
	public long createPortalUser(User user, long[] roleIds, UserProfile profile, PortalContext portalContext) throws SystemException{
		try {
			User checkuser = userDao.findUserByName(user.getUsername());
			if(checkuser!=null){
				throw new SystemException(ErrorCodeConstants.ERR_CODE_USER_DUPLICATE, "User " + user.getUsername() + " exist");
			}
			
			long uid = userDao.createUser(user);
			logger.info("create user with key " + uid);
			
			if(roleIds!=null && roleIds.length>0){
				for(long rid : roleIds){
					UserRole userRole = new UserRole();
					userRole.setUid(uid);
					userRole.setRoleId(rid);
					userDao.createUserRole(userRole);
				}
				logger.info("create user role " + StringUtil.array2String(roleIds, ","));
			}
			
			if(profile!=null){
				profile.setUid(uid);
				long profileId = userProfileDao.save(profile);
				logger.info("create user profile " + profileId);
			}
			
			/*try {
				//String fromuser = ApplicationConfigUtil.getInstance().getString("digital.email.send.fromuser");
				String subject = "NCS Internal Asset Management";
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("username", user.getUsername());
				map.put("password", user.getPassword1());
				map.put("siteURL", portalContext.getSiteURL());
				String body = "test"; //FmTemplateUtil.instance().getContent(map, "tpl_password_keeping");
				
				MailQueue mail = new MailQueue();
				mail.setStatus(StatusConstants.DATA_STATUS_ACTIVE);
				mail.setSubject(subject);
				mail.setHtml(body);
				mail.setCreatedBy(user.getCreatedBy());
				mail.setCreatedDate(new Date());
				mail.setToList(user.getEmail());
				//mailService.save(mail);
				
				//mailService.sendHTMLMail(null, new String[]{profile.getEmail()}, subject , body, null);
			} catch (Exception e) {
				throw new SystemException(ErrorCodeConstants.ERR_CODE_SERVER, e.getMessage());
			}*/
			
			return uid;
		} catch (SystemException e) {
			throw new SystemException(e.getErrorCode(), e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemException(ErrorCodeConstants.ERR_CODE_SERVER, "user can not create");
		}
	}
	
	public void updateUser(User user, long[] roleIds, UserProfile profile, PortalContext portalContext) throws SystemException{
		try {
			userDao.updateUser(user);
			
			if(roleIds!=null && roleIds.length>0){
				List<UserRole> userroles = findUserRolesByUID(user.getUid());
				logger.info("removing exist roles of " + user.getUid());
				for(UserRole ur : userroles){
					userRoleDao.delete(ur.getUserRoleId());
				}				
				logger.info("create user role " + StringUtil.array2String(roleIds, ","));
				for(long rid : roleIds){
					UserRole userRole = new UserRole();
					userRole.setUid(user.getUid());
					userRole.setRoleId(rid);
					userDao.createUserRole(userRole);
				}
			}
			
			if(profile!=null){
				userProfileDao.update(profile);
				logger.info("update user profile " + profile.getUserProfileId());
			}
		} catch (SystemException e) {
			throw new SystemException(e.getErrorCode(), e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemException(e);
		}
	}
	
	public void deleteUser(User user, PortalContext portalContext) throws SystemException{
		try {
			logger.info("deleting user roles");
			List<UserRole> userroles = findUserRolesByUID(user.getUid());
			if(userroles!=null && userroles.size()>0){
				for(UserRole ur : userroles){
					userRoleDao.delete(ur.getUserRoleId());
				}
			}
			logger.info("deleting user profile");
			UserProfile up = findUserProfileByUID(user.getUid());
			if(up!=null){
				userProfileDao.delete(up.getUserProfileId());
			}
			
			logger.info("deleting user devices");
			/*List<UserDevice> userdevices = userDeviceDao.findByColumn(TableDefConstants.UserDevice.uid.name(), user.getUid(), QueryUtil.ALL_POS, QueryUtil.ALL_POS);
			if(userdevices!=null && userdevices.size()>0){
				for(UserDevice ud : userdevices){
					userDeviceDao.delete(ud);
				}
			}*/
			logger.info("deleting user " + user.getUsername());
			userDao.deleteUser(user);
		} catch (SystemException e) {
			throw new SystemException(e.getErrorCode(), e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemException(e);
		}
	}
	
	public void activeUser(User user, PortalContext portalContext) throws SystemException{
		try {
			logger.info("active user " + user.getUsername());
			user.setStatus(StatusConstants.USER_STATUS_ACTIVE);
			userDao.updateUser(user);
		} catch (SystemException e) {
			throw new SystemException(e.getErrorCode(), e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemException(e);
		}
	}
	
	public void inactiveUser(User user, PortalContext portalContext) throws SystemException{
		try {
			logger.info("inactive user " + user.getUsername());
			user.setStatus(StatusConstants.USER_STATUS_INACTIVE);
			userDao.updateUser(user);
		} catch (SystemException e) {
			throw new SystemException(e.getErrorCode(), e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemException(e);
		}
	}
	
	public UserProfile findUserProfileByUID(long uid) throws SystemException{
		try {
			List<UserProfile> pros = userProfileDao.findByColumn(TableDefConstants.UserProfile.uid.name(), uid, QueryUtil.ALL_POS, QueryUtil.ALL_POS);
			if(pros!=null && pros.size()>0){
				return pros.get(0);
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemException(ErrorCodeConstants.ERR_CODE_DATA_INVALID, "invalid profile");
		}
	}
	
	public void updateProfile(UserProfile profile) throws SystemException{
		try {
			userProfileDao.update(profile);
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemException(ErrorCodeConstants.ERR_CODE_DATA_INVALID, "user profile updated exception");
		}
	}

	public void createUserRoles(User user, long[] roleIds) throws SystemException{
		try {
			if(roleIds!=null && roleIds.length>0){
				for(long rid : roleIds){
					UserRole userRole = new UserRole();
					userRole.setUid(user.getUid());
					userRole.setRoleId(rid);
					long userRoleId = userDao.createUserRole(userRole);
					logger.info("create user role " + userRoleId);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemException(ErrorCodeConstants.ERR_CODE_AUTH_INVALID_USER, "user role exception");
		}
	}
	
	public void updateUserRoles(User user, long[] roleIds) throws SystemException{
		try {
			if(roleIds!=null && roleIds.length>0){
				List<UserRole> userroles = findUserRolesByUID(user.getUid());
				logger.info("removing exist roles of " + user.getUid());
				for(UserRole ur : userroles){
					userRoleDao.delete(ur.getUserRoleId());
				}				
				logger.info("create user role " + StringUtil.array2String(roleIds, ","));
				for(long rid : roleIds){
					UserRole userRole = new UserRole();
					userRole.setUid(user.getUid());
					userRole.setRoleId(rid);
					userDao.createUserRole(userRole);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemException(ErrorCodeConstants.ERR_CODE_AUTH_INVALID_USER, "user role exception");
		}
	}

	public User findUserById(long id) throws SystemException{
		try {
			return userDao.findUserById(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw new SystemException(ErrorCodeConstants.ERR_CODE_USER_NOT_FOUND, "user not found");
		}
	}

	public boolean changePassword(String username, String encodepassword)
			throws SystemException {
		try {
			User user = userDao.findUserByName(username);
			user.setPassword(encodepassword);
			userDao.updatePassword(user);
		} catch (Exception e) {
			throw new SystemException(ErrorCodeConstants.ERR_CODE_AUTH_INVALID_USER, "Invalid user");
		}
		return true;
	}

	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		try {
			User user = userDao.findUserByName(username);
			if (user == null) {
	            throw new UsernameNotFoundException("user " + username + " not found");
	        }
	        long uid = user.getUid();
	        String password = user.getPassword();
	        boolean userEnabled = true;
	        
	        Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

	        List<Role> userRoles = userDao.findRolesByUID(uid);
	        for (Role userRole : userRoles) {
	        	GrantedAuthorityImpl authority = new GrantedAuthorityImpl("ROLE_" + userRole.getName().toUpperCase());
	        	logger.info(username + " has roles # " + userRole.getName());
	            authorities.add(authority);
	        }
	        
	        if(StatusConstants.DATA_STATUS_INACTIVE == user.getStatus() || StatusConstants.USER_STATUS_INACTIVE == user.getStatus()){
	        	userEnabled = false;
	        }
	        
	        AuthUserDetails webUserDetails = new AuthUserDetails(uid, username, password, userEnabled, authorities);
	        
	        return webUserDetails;
		} catch (Exception e) {
			e.printStackTrace();
			throw new UsernameNotFoundException("Invalid user");
		}
	}
}
