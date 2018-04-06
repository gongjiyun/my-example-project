package com.learning.example.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

import com.learning.example.Constants;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.springframework.format.annotation.DateTimeFormat;


@Entity(name="userLogin")
@Cache(usage = CacheConcurrencyStrategy.NONE)
@Inheritance(strategy=InheritanceType.JOINED)
@Table(name="PB_UserLogin",catalog="",schema="")
public class UserLogin implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE,generator="userloginid_gen")
	@TableGenerator(name="userloginid_gen",table="PB_Classes_",pkColumnName="className",initialValue=1, valueColumnName="currentId",pkColumnValue="sg.ncs.digitalbanking.entity.UserLogin",allocationSize=1)
	@Column(name="userLoginId", length=32)
	private Long userLoginId;

	@Column(name="uid", nullable=false)
	private Long uid;

	@Column(name="token", length=100, columnDefinition="varchar(100)")
	private String token;

	@Column(name="deviceToken", length=100, columnDefinition="varchar(100)")
	private String deviceToken;

	@Column(name="ip", length=100, columnDefinition="varchar(100)")
	private String ip;

	@Column(name="status")
	private Long status;

	@DateTimeFormat(pattern = Constants.DEFAULT_WEB_DATE_FORMART)
	@Column(name="loginTime")
	private Date loginTime;


	public void setUserLoginId(Long userLoginId){
		this.userLoginId = userLoginId;
	}
	public Long getUserLoginId(){
		return this.userLoginId;
	}
	public void setUid(Long uid){
		this.uid = uid;
	}
	public Long getUid(){
		return this.uid;
	}
	public void setToken(String token){
		this.token = token;
	}
	public String getToken(){
		return this.token;
	}
	public void setDeviceToken(String deviceToken){
		this.deviceToken = deviceToken;
	}
	public String getDeviceToken(){
		return this.deviceToken;
	}
	public void setIp(String ip){
		this.ip = ip;
	}
	public String getIp(){
		return this.ip;
	}
	public void setStatus(Long status){
		this.status = status;
	}
	public Long getStatus(){
		return this.status;
	}
	public void setLoginTime(Date loginTime){
		this.loginTime = loginTime;
	}
	public Date getLoginTime(){
		return this.loginTime;
	}
}