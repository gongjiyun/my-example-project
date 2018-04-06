package com.learning.common.entities;

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

import com.learning.utils.constants.PortalConstants;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.springframework.format.annotation.DateTimeFormat;

import com.learning.utils.constants.PortalConstants;


@Entity(name="auditLog")
@Cache(usage = CacheConcurrencyStrategy.NONE)
@Inheritance(strategy=InheritanceType.JOINED)
@Table(name="AuditLog",catalog="",schema="")
public class AuditLog implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE,generator="auditlogid_gen")
	@TableGenerator(name="auditlogid_gen",table="Classes_",pkColumnName="className",initialValue=1, valueColumnName="currentId",pkColumnValue="com.learning.common.entities.AuditLog",allocationSize=1)
	@Column(name="auditLogId", length=32)
	private Long auditLogId;

	@Column(name="uri", length=200, columnDefinition="varchar(200)")
	private String uri;

	@Column(name="method", length=20, columnDefinition="varchar(20)")
	private String method;

	@Column(name="ip", length=20, columnDefinition="varchar(20)")
	private String ip;

	@Column(name="agent", length=20, columnDefinition="varchar(20)")
	private String agent;

	@Column(name="isSecure")
	private Boolean isSecure;

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


	public void setAuditLogId(Long auditLogId){
		this.auditLogId = auditLogId;
	}
	public Long getAuditLogId(){
		return this.auditLogId;
	}
	public void setUri(String uri){
		this.uri = uri;
	}
	public String getUri(){
		return this.uri;
	}
	public void setMethod(String method){
		this.method = method;
	}
	public String getMethod(){
		return this.method;
	}
	public void setIp(String ip){
		this.ip = ip;
	}
	public String getIp(){
		return this.ip;
	}
	public void setAgent(String agent){
		this.agent = agent;
	}
	public String getAgent(){
		return this.agent;
	}
	public void setIsSecure(Boolean isSecure){
		this.isSecure = isSecure;
	}
	public Boolean getIsSecure(){
		return this.isSecure;
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