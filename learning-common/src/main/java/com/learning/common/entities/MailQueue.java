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


@Entity(name="mailQueue")
@Cache(usage = CacheConcurrencyStrategy.NONE)
@Inheritance(strategy=InheritanceType.JOINED)
@Table(name="MailQueue",catalog="",schema="")
public class MailQueue implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE,generator="mailqueueid_gen")
	@TableGenerator(name="mailqueueid_gen",table="Classes_",pkColumnName="className",initialValue=1, valueColumnName="currentId",pkColumnValue="com.learning.common.entities.MailQueue",allocationSize=1)
	@Column(name="mailQueueId", length=32)
	private Long mailQueueId;

	@Column(name="subject", length=200, columnDefinition="varchar(200)")
	private String subject;

	@Column(name="content", length=1000, columnDefinition="varchar(1000)")
	private String content;

	@Column(name="html", columnDefinition="longtext")
	private String html;

	@DateTimeFormat(pattern = PortalConstants.DEFAULT_WEB_DATE_FORMART)
	@Column(name="sendDate")
	private Date sendDate;

	@Column(name="uid")
	private Long uid;

	@Column(name="fromUser", length=50, columnDefinition="varchar(50)")
	private String fromUser;

	@Column(name="toList", length=500, columnDefinition="varchar(500)")
	private String toList;

	@Column(name="ccList", length=500, columnDefinition="varchar(500)")
	private String ccList;

	@Column(name="fileEntryIds", length=500, columnDefinition="varchar(500)")
	private String fileEntryIds;

	@Column(name="status", length=1)
	private Long status;

	@Column(name="remarks", length=1000, columnDefinition="varchar(1000)")
	private String remarks;

	@Column(name="updatedBy")
	private Long updatedBy;

	@DateTimeFormat(pattern = PortalConstants.DEFAULT_WEB_DATE_FORMART)
	@Column(name="updatedDate")
	private Date updatedDate;

	@Column(name="createdBy")
	private Long createdBy;

	@DateTimeFormat(pattern = PortalConstants.DEFAULT_WEB_DATE_FORMART)
	@Column(name="createdDate")
	private Date createdDate;


	public void setMailQueueId(Long mailQueueId){
		this.mailQueueId = mailQueueId;
	}
	public Long getMailQueueId(){
		return this.mailQueueId;
	}
	public void setSubject(String subject){
		this.subject = subject;
	}
	public String getSubject(){
		return this.subject;
	}
	public void setContent(String content){
		this.content = content;
	}
	public String getContent(){
		return this.content;
	}
	public void setHtml(String html){
		this.html = html;
	}
	public String getHtml(){
		return this.html;
	}
	public void setSendDate(Date sendDate){
		this.sendDate = sendDate;
	}
	public Date getSendDate(){
		return this.sendDate;
	}
	public void setUid(Long uid){
		this.uid = uid;
	}
	public Long getUid(){
		return this.uid;
	}
	public void setFromUser(String fromUser){
		this.fromUser = fromUser;
	}
	public String getFromUser(){
		return this.fromUser;
	}
	public void setToList(String toList){
		this.toList = toList;
	}
	public String getToList(){
		return this.toList;
	}
	public void setCcList(String ccList){
		this.ccList = ccList;
	}
	public String getCcList(){
		return this.ccList;
	}
	public void setFileEntryIds(String fileEntryIds){
		this.fileEntryIds = fileEntryIds;
	}
	public String getFileEntryIds(){
		return this.fileEntryIds;
	}
	public void setStatus(Long status){
		this.status = status;
	}
	public Long getStatus(){
		return this.status;
	}
	public void setRemarks(String remarks){
		this.remarks = remarks;
	}
	public String getRemarks(){
		return this.remarks;
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
}