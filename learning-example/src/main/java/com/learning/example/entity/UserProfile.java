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


@Entity(name="userProfile")
@Cache(usage = CacheConcurrencyStrategy.NONE)
@Inheritance(strategy=InheritanceType.JOINED)
@Table(name="PB_UserProfile",catalog="",schema="")
public class UserProfile implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE,generator="userprofileid_gen")
	@TableGenerator(name="userprofileid_gen",table="PB_Classes_",pkColumnName="className",initialValue=1, valueColumnName="currentId",pkColumnValue="sg.ncs.digitalbanking.entity.UserProfile",allocationSize=1)
	@Column(name="userProfileId", length=32)
	private Long userProfileId;

	@Column(name="uid", nullable=false)
	private Long uid;

	@Column(name="clientId", length=100, columnDefinition="varchar(100)")
	private String clientId;

	@Column(name="type", length=100, columnDefinition="varchar(100)")
	private String type;

	@Column(name="screenName", length=100, columnDefinition="varchar(100)")
	private String screenName;

	@Column(name="firstName", length=100, columnDefinition="varchar(100)")
	private String firstName;

	@Column(name="lastName", length=100, columnDefinition="varchar(100)")
	private String lastName;

	@DateTimeFormat(pattern = Constants.DEFAULT_WEB_DATE_FORMART)
	@Column(name="dob")
	private Date dob;

	@Column(name="gender", length=1, columnDefinition="varchar(1)")
	private String gender;

	@Column(name="photoId")
	private Long photoId;

	@Column(name="address", length=1000, columnDefinition="varchar(1000)")
	private String address;

	@Column(name="title", length=1000, columnDefinition="varchar(1000)")
	private String title;

	@Column(name="occupation", length=255, columnDefinition="varchar(255)")
	private String occupation;

	@Column(name="email", length=200, columnDefinition="varchar(200)")
	private String email;

	@Column(name="mobileNumber", length=20, columnDefinition="varchar(20)")
	private String mobileNumber;

	@Column(name="officeNumber", length=20, columnDefinition="varchar(20)")
	private String officeNumber;

	@Column(name="createdBy")
	private Long createdBy;

	@DateTimeFormat(pattern = Constants.DEFAULT_WEB_DATE_FORMART)
	@Column(name="createdDate")
	private Date createdDate;

	@Column(name="updatedBy")
	private Long updatedBy;

	@DateTimeFormat(pattern = Constants.DEFAULT_WEB_DATE_FORMART)
	@Column(name="updatedDate")
	private Date updatedDate;


	public void setUserProfileId(Long userProfileId){
		this.userProfileId = userProfileId;
	}
	public Long getUserProfileId(){
		return this.userProfileId;
	}
	public void setUid(Long uid){
		this.uid = uid;
	}
	public Long getUid(){
		return this.uid;
	}
	public void setClientId(String clientId){
		this.clientId = clientId;
	}
	public String getClientId(){
		return this.clientId;
	}
	public void setType(String type){
		this.type = type;
	}
	public String getType(){
		return this.type;
	}
	public void setScreenName(String screenName){
		this.screenName = screenName;
	}
	public String getScreenName(){
		return this.screenName;
	}
	public void setFirstName(String firstName){
		this.firstName = firstName;
	}
	public String getFirstName(){
		return this.firstName;
	}
	public void setLastName(String lastName){
		this.lastName = lastName;
	}
	public String getLastName(){
		return this.lastName;
	}
	public void setDob(Date dob){
		this.dob = dob;
	}
	public Date getDob(){
		return this.dob;
	}
	public void setGender(String gender){
		this.gender = gender;
	}
	public String getGender(){
		return this.gender;
	}
	public void setPhotoId(Long photoId){
		this.photoId = photoId;
	}
	public Long getPhotoId(){
		return this.photoId;
	}
	public void setAddress(String address){
		this.address = address;
	}
	public String getAddress(){
		return this.address;
	}
	public void setTitle(String title){
		this.title = title;
	}
	public String getTitle(){
		return this.title;
	}
	public void setOccupation(String occupation){
		this.occupation = occupation;
	}
	public String getOccupation(){
		return this.occupation;
	}
	public void setEmail(String email){
		this.email = email;
	}
	public String getEmail(){
		return this.email;
	}
	public void setMobileNumber(String mobileNumber){
		this.mobileNumber = mobileNumber;
	}
	public String getMobileNumber(){
		return this.mobileNumber;
	}
	public void setOfficeNumber(String officeNumber){
		this.officeNumber = officeNumber;
	}
	public String getOfficeNumber(){
		return this.officeNumber;
	}
	public void setCreatedBy(Long createdBy){
		this.createdBy = createdBy;
	}
	public Long getCreatedBy(){
		return this.createdBy;
	}
	public void setCreatedDate(Date createdDate){
		this.createdDate = createdDate;
	}
	public Date getCreatedDate(){
		return this.createdDate;
	}
	public void setUpdatedBy(Long updatedBy){
		this.updatedBy = updatedBy;
	}
	public Long getUpdatedBy(){
		return this.updatedBy;
	}
	public void setUpdatedDate(Date updatedDate){
		this.updatedDate = updatedDate;
	}
	public Date getUpdatedDate(){
		return this.updatedDate;
	}
}