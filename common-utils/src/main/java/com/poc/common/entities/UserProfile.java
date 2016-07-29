package com.poc.common.entities;

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

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.springframework.format.annotation.DateTimeFormat;

import com.poc.utils.constants.PortalConstants;


@Entity(name="userProfile")
@Cache(usage = CacheConcurrencyStrategy.NONE)
@Inheritance(strategy=InheritanceType.JOINED)
@Table(name="UserProfile",catalog="",schema="")
public class UserProfile implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE,generator="userprofileid_gen")
	@TableGenerator(name="userprofileid_gen",table="Classes_",pkColumnName="className",initialValue=1, valueColumnName="currentId",pkColumnValue="com.poc.common.entities.UserProfile",allocationSize=1)
	@Column(name="userProfileId", length=32)
	private Long userProfileId;

	@Column(name="uid", nullable=false)
	private Long uid;

	@Column(name="domainId", length=100, columnDefinition="varchar(100)")
	private String domainId;

	@Column(name="type", length=100, columnDefinition="varchar(100)")
	private String type;

	@Column(name="contractNo", length=100, columnDefinition="varchar(100)")
	private String contractNo;

	@Column(name="contractType", length=100, columnDefinition="varchar(100)")
	private String contractType;

	@DateTimeFormat(pattern = PortalConstants.DEFAULT_WEB_DATE_FORMART)
	@Column(name="serviceStartDate")
	private Date serviceStartDate;

	@DateTimeFormat(pattern = PortalConstants.DEFAULT_WEB_DATE_FORMART)
	@Column(name="serviceEndDate")
	private Date serviceEndDate;

	@Column(name="screenName", length=100, columnDefinition="varchar(100)")
	private String screenName;

	@Column(name="firstName", length=100, columnDefinition="varchar(100)")
	private String firstName;

	@Column(name="lastName", length=100, columnDefinition="varchar(100)")
	private String lastName;

	@DateTimeFormat(pattern = PortalConstants.DEFAULT_WEB_DATE_FORMART)
	@Column(name="dob")
	private Date dob;

	@Column(name="gender", length=1, columnDefinition="varchar(1)")
	private String gender;

	@Column(name="IDNumber", length=20, columnDefinition="varchar(20)")
	private String IDNumber;

	@Column(name="photoId")
	private Long photoId;

	@Column(name="address", length=1000, columnDefinition="varchar(1000)")
	private String address;

	@Column(name="title", length=1000, columnDefinition="varchar(1000)")
	private String title;

	@Column(name="status")
	private Long status;

	@Column(name="departmentId")
	private Long departmentId;

	@Column(name="email", length=200, columnDefinition="varchar(200)")
	private String email;

	@Column(name="mobileNumber", length=20, columnDefinition="varchar(20)")
	private String mobileNumber;

	@Column(name="officeNumber", length=20, columnDefinition="varchar(20)")
	private String officeNumber;

	@Column(name="createdBy")
	private Long createdBy;

	@DateTimeFormat(pattern = PortalConstants.DEFAULT_WEB_DATE_FORMART)
	@Column(name="createdDate")
	private Date createdDate;

	@Column(name="updatedBy")
	private Long updatedBy;

	@DateTimeFormat(pattern = PortalConstants.DEFAULT_WEB_DATE_FORMART)
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
	public void setDomainId(String domainId){
		this.domainId = domainId;
	}
	public String getDomainId(){
		return this.domainId;
	}
	public void setType(String type){
		this.type = type;
	}
	public String getType(){
		return this.type;
	}
	public void setContractNo(String contractNo){
		this.contractNo = contractNo;
	}
	public String getContractNo(){
		return this.contractNo;
	}
	public void setContractType(String contractType){
		this.contractType = contractType;
	}
	public String getContractType(){
		return this.contractType;
	}
	public void setServiceStartDate(Date serviceStartDate){
		this.serviceStartDate = serviceStartDate;
	}
	public Date getServiceStartDate(){
		return this.serviceStartDate;
	}
	public void setServiceEndDate(Date serviceEndDate){
		this.serviceEndDate = serviceEndDate;
	}
	public Date getServiceEndDate(){
		return this.serviceEndDate;
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
	public void setIDNumber(String IDNumber){
		this.IDNumber = IDNumber;
	}
	public String getIDNumber(){
		return this.IDNumber;
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
	public void setStatus(Long status){
		this.status = status;
	}
	public Long getStatus(){
		return this.status;
	}
	public void setDepartmentId(Long departmentId){
		this.departmentId = departmentId;
	}
	public Long getDepartmentId(){
		return this.departmentId;
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