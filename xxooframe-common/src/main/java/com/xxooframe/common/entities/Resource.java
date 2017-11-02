package com.xxooframe.common.entities;

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

import com.xxooframe.utils.constants.PortalConstants;


@Entity(name="resource")
@Cache(usage = CacheConcurrencyStrategy.NONE)
@Inheritance(strategy=InheritanceType.JOINED)
@Table(name="Resource",catalog="",schema="")
public class Resource implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE,generator="resourceid_gen")
	@TableGenerator(name="resourceid_gen",table="Classes_",pkColumnName="className",initialValue=1, valueColumnName="currentId",pkColumnValue="com.xxooframe.common.entities.Resource",allocationSize=1)
	@Column(name="resourceId", length=32)
	private Long resourceId;

	@Column(name="name", length=100, columnDefinition="varchar(100)")
	private String name;

	@Column(name="type", length=100, columnDefinition="varchar(100)")
	private String type;

	@Column(name="extension", length=100, columnDefinition="varchar(100)")
	private String extension;

	@Column(name="title", length=255, columnDefinition="varchar(255)")
	private String title;

	@Column(name="description", length=255, columnDefinition="varchar(255)")
	private String description;

	@Column(name="fileEntryId")
	private Long fileEntryId;

	@Column(name="stragety", length=20, columnDefinition="varchar(20)")
	private String stragety;

	@Column(name="path", length=255, columnDefinition="varchar(255)")
	private String path;

	@Column(name="owner", length=255, columnDefinition="varchar(255)")
	private String owner;

	@Column(name="byteContent", columnDefinition="longblob", updatable=false, insertable=false)
	private byte[] byteContent;

	@Column(name="size")
	private Long size;

	@Column(name="status")
	private Long status;

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


	public void setResourceId(Long resourceId){
		this.resourceId = resourceId;
	}
	public Long getResourceId(){
		return this.resourceId;
	}
	public void setName(String name){
		this.name = name;
	}
	public String getName(){
		return this.name;
	}
	public void setType(String type){
		this.type = type;
	}
	public String getType(){
		return this.type;
	}
	public void setExtension(String extension){
		this.extension = extension;
	}
	public String getExtension(){
		return this.extension;
	}
	public void setTitle(String title){
		this.title = title;
	}
	public String getTitle(){
		return this.title;
	}
	public void setDescription(String description){
		this.description = description;
	}
	public String getDescription(){
		return this.description;
	}
	public void setFileEntryId(Long fileEntryId){
		this.fileEntryId = fileEntryId;
	}
	public Long getFileEntryId(){
		return this.fileEntryId;
	}
	public void setStragety(String stragety){
		this.stragety = stragety;
	}
	public String getStragety(){
		return this.stragety;
	}
	public void setPath(String path){
		this.path = path;
	}
	public String getPath(){
		return this.path;
	}
	public void setOwner(String owner){
		this.owner = owner;
	}
	public String getOwner(){
		return this.owner;
	}
	public void setByteContent(byte[] byteContent){
		this.byteContent = byteContent;
	}
	public byte[] getByteContent(){
		return this.byteContent;
	}
	public void setSize(Long size){
		this.size = size;
	}
	public Long getSize(){
		return this.size;
	}
	public void setStatus(Long status){
		this.status = status;
	}
	public Long getStatus(){
		return this.status;
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