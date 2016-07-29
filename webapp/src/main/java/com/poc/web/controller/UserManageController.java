package com.poc.web.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.DataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.poc.common.entities.CodeMaster;
import com.poc.common.entities.Role;
import com.poc.common.entities.User;
import com.poc.common.entities.UserProfile;
import com.poc.common.model.PageCriteria;
import com.poc.common.model.UserVO;
import com.poc.utils.constants.MasterCodeConstants;
import com.poc.utils.constants.PortalConstants;
import com.poc.utils.constants.StatusConstants;
import com.poc.utils.exception.SystemException;
import com.poc.utils.util.ParamUtil;
import com.poc.utils.util.PasswordGeneratorUtil;
import com.poc.utils.util.PortalContext;
import com.poc.utils.util.PortalUtil;
import com.poc.utils.util.StringUtil;
import com.poc.web.util.ServiceGateUtil;

@Controller
public class UserManageController extends AbstractPortalController{
	private final static Logger logger = LoggerFactory.getLogger(UserManageController.class);

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@InitBinder
	public void initBinder(DataBinder binder) {
		
	}
	
	@RequestMapping(path = "/user", method = RequestMethod.GET)
	public String init(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		try {			
			List<User> dbusers = ServiceGateUtil.getUserService().loadUsers();
			List<UserVO> users = wrapUserDetails(dbusers);
			model.addAttribute("userlist", users);  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "user.init";
	}
	
	@RequestMapping(path = "/user/search", method = {RequestMethod.POST, RequestMethod.GET})
	public String search(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		try {
			String username = ParamUtil.getString(request, "username", null);
			String email = ParamUtil.getString(request, "email", null);
			
			PageCriteria searchCriteria = new PageCriteria();
			searchCriteria.setParameter("username", username);
			searchCriteria.setParameter("email", email);

			model.addAttribute("searchCriteria", searchCriteria);
			
			List<User> dbusers = ServiceGateUtil.getUserService().searchUsers(searchCriteria);
			List<UserVO> users = wrapUserDetails(dbusers);
			model.addAttribute("userlist", users);  
		} catch (Exception e) {
			e.printStackTrace();
			addError(request, null, null, e.getMessage());
		}
		return "user.init";
	}
	
	private List<UserVO> wrapUserDetails(List<User> dbusers) throws SystemException{
		List<UserVO> users = new ArrayList<UserVO>();
		if(dbusers!=null && dbusers.size()>0){
			for(User uo : dbusers){
				if(PortalConstants.DEFAULT_SYSTEM_ADMIN.equalsIgnoreCase(uo.getUsername())){
					continue;
				}
				UserVO user = wrapUserDetail(uo);
				users.add(user);
			}
		}
		return users;
	}	
	private UserVO wrapUserDetail(User dbuser) throws SystemException{
		UserVO user = new UserVO();
		try {
			user.setUsername(dbuser.getUsername());
			user.setUser(dbuser);
			user.setUid(dbuser.getUid());
			user.setStatus(String.valueOf(dbuser.getStatus()));
			user.setRemarks(dbuser.getRemarks());
			user.setEmail(dbuser.getEmail());
			
			UserProfile userProfile = ServiceGateUtil.getUserService().findUserProfileByUID(dbuser.getUid());
			if(userProfile!=null){
				user.setUserProfile(userProfile);
				user.setEmail(userProfile.getEmail());
			}

			List<Role> roles = ServiceGateUtil.getUserService().findRolesByUID(dbuser.getUid());
			if(roles!=null && roles.size()>0){
				String rd = "";
				String rids = "";
				for(Role r : roles){
					rd = rd + "," + r.getDescription();
					rids = rids + "," + r.getRoleId();
				}
				user.setRoleDescriptions(rd.substring(1));
				user.setRoleIds(rids.substring(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	@RequestMapping(path = "/user/add", method = RequestMethod.GET)
	public String addUserInitlizor(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		try {
			model.addAttribute("user", new UserVO());
			model.addAttribute("roles", getAvaiableRoles(request, response, model));
			model.addAttribute("statusList", getUserStatusList(request, response, model));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "user.add";
	}
	
	private List<Role> getAvaiableRoles(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		List<Role> avaiableRoles = new ArrayList<Role>();
		
		avaiableRoles = ServiceGateUtil.getRoleService().findPortalRoles();
		
		return avaiableRoles;
	}
	
	private List<CodeMaster> getUserStatusList(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		List<CodeMaster> codes = new ArrayList<CodeMaster>();
		
		codes = ServiceGateUtil.getCodeService().loadCodes(MasterCodeConstants.TYPE_USER_STATUS);
		
		return codes;
	}
	

	@RequestMapping(path = "/user/add", method = RequestMethod.POST)
	public String addUser(@ModelAttribute("user")UserVO userVO, HttpServletRequest request, HttpServletResponse response, Model model, BindingResult bindingResult) throws Exception {
		try {
			String username = userVO.getUsername();
			String email = userVO.getEmail();
			String password = PasswordGeneratorUtil.generatePassword(12);
			String roleIds = userVO.getRoleIds();
			
			if(StringUtil.isNull(userVO.getUsername())){
				throw new Exception("User name is empty");
			}
			
			if(StringUtil.isNull(userVO.getEmail())){
				throw new Exception("Email name is empty");
			}
			
			if(roleIds==null){
				throw new Exception("Please choose user role");
			}
			
			User user = new User();
			user.setUsername(username);
			user.setPassword(passwordEncoder.encode(password));
			user.setPassword1(password);
			user.setPassword2(password);
			user.setEmail(email);
			user.setScreenName(username);
			user.setCreatedBy(getCurrentUID(request));
			user.setCreatedDt(new Date());
			user.setUpdatedBy(getCurrentUID(request));
			user.setUpdatedDate(new Date());

			long[] roleIdInts = null;
			if(roleIds!=null && roleIds.length()>0){
				String[] roles = roleIds.split(",");
				roleIdInts = new long[roles.length];
				for(int i=0; i<roles.length; i++){
					roleIdInts[i] = Long.valueOf(roles[i]);
				}
			}
			
			long uid = ServiceGateUtil.getUserService().createPortalUser(user, roleIdInts, null, new PortalContext(request));
			logger.info("create user with key " + uid);
			logger.info("notify user login " + PortalUtil.getSiteURL(request));

			model.addAttribute("roles", getAvaiableRoles(request, response, model));
			model.addAttribute("user", userVO);
			addMessage(request, null, null, "User add success, email will be send to " + email);
		} catch (Exception e) {
			e.printStackTrace();
			addError(request, null, null, e.getMessage());
		}
		model.addAttribute("roles", getAvaiableRoles(request, response, model));
		
		return "user.add";
	}
	
	@RequestMapping(path = "/user/edit/{userid}", method = RequestMethod.GET)
	public String updateUserInitlizor(@PathVariable("userid") String userid, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		try {
			long uid = Long.valueOf(userid);
			User dbuser = ServiceGateUtil.getUserService().findUserById(uid);
			UserVO uservo = wrapUserDetail(dbuser);
			
			model.addAttribute("user", uservo);
			model.addAttribute("roles", getAvaiableRoles(request, response, model));
			model.addAttribute("statusList", getUserStatusList(request, response, model));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "user.edit";
	}
	
	@RequestMapping(path = "/user/edit", method = RequestMethod.POST)
	public String updateUser(@ModelAttribute("user")UserVO userVO, HttpServletRequest request, HttpServletResponse response, Model model, BindingResult bindingResult) throws Exception {
		try {
			String email = userVO.getEmail();
			String roleIds = userVO.getRoleIds();
			String remarks = userVO.getRemarks();

			if(StringUtil.isNull(userVO.getEmail())){
				throw new Exception("Email name is empty");
			}
			
			User user = ServiceGateUtil.getUserService().findUserById(userVO.getUid());
			user.setStatus(StatusConstants.USER_STATUS_ACTIVE);
			user.setRemarks(remarks);
			user.setEmail(email);
			user.setUpdatedBy(getCurrentUID(request));
			user.setUpdatedDate(new Date());

			long[] roleIdInts = null;
			if(roleIds!=null && roleIds.length()>0){
				String[] roles = roleIds.split(",");
				roleIdInts = new long[roles.length];
				for(int i=0; i<roles.length; i++){
					roleIdInts[i] = Long.valueOf(roles[i]);
				}
			}
			
			ServiceGateUtil.getUserService().updateUser(user, roleIdInts, null, new PortalContext(request));
		} catch (Exception e) {
			e.printStackTrace();
			addError(request, null, null, e.getMessage());
		}
		return "redirect:/user";
	}
	
	@RequestMapping(path = "/user/delete/{userid}", method = RequestMethod.GET)
	public String deleteUser(@PathVariable("userid") String userid, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		try {
			Long uid = Long.valueOf(userid);
			User user = ServiceGateUtil.getUserService().findUserById(uid);
			ServiceGateUtil.getUserService().deleteUser(user, new PortalContext(request));
		} catch (Exception e) {
			e.printStackTrace();
			addError(request, null, null, e.getMessage());
		}
		return "redirect:/user";
	}
	
	@RequestMapping(path = "/user/active/{userid}", method = RequestMethod.GET)
	public String activeUser(@PathVariable("userid") String userid, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		try {
			Long uid = Long.valueOf(userid);
			User user = ServiceGateUtil.getUserService().findUserById(uid);
			ServiceGateUtil.getUserService().activeUser(user, new PortalContext(request));
			renderSuccess(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			addError(request, null, null, e.getMessage());
			throw new Exception(e);
		}
		return null;
	}
	
	@RequestMapping(path = "/user/inactive/{userid}", method = RequestMethod.GET)
	public String inactiveUser(@PathVariable("userid") String userid, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		try {
			Long uid = Long.valueOf(userid);
			User user = ServiceGateUtil.getUserService().findUserById(uid);
			ServiceGateUtil.getUserService().inactiveUser(user, new PortalContext(request));
			renderSuccess(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			addError(request, null, null, e.getMessage());
			throw new Exception(e);
		}
		return null;
	}
}
