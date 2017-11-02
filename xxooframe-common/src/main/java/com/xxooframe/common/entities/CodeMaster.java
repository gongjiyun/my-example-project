package com.xxooframe.common.entities;

import java.lang.String;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import java.io.Serializable;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.GenerationType;
import javax.persistence.TableGenerator;


@Entity(name="codeMaster")
@Cache(usage = CacheConcurrencyStrategy.NONE)
@Inheritance(strategy=InheritanceType.JOINED)
@Table(name="CodeMaster",catalog="",schema="")
public class CodeMaster implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE,generator="codemasterid_gen")
	@TableGenerator(name="codemasterid_gen",table="Classes_",pkColumnName="className",initialValue=1, valueColumnName="currentId",pkColumnValue="com.xxooframe.common.entities.CodeMaster",allocationSize=1)
	@Column(name="codeMasterId", length=32)
	private Long codeMasterId;

	@Column(name="codeKey", length=100, columnDefinition="varchar(100)")
	private String codeKey;

	@Column(name="codeValue", length=500, columnDefinition="varchar(500)")
	private String codeValue;

	@Column(name="type", length=20, columnDefinition="varchar(20)")
	private String type;

	@Column(name="description", length=500, columnDefinition="varchar(500)")
	private String description;


	public void setCodeMasterId(Long codeMasterId){
		this.codeMasterId = codeMasterId;
	}
	public Long getCodeMasterId(){
		return this.codeMasterId;
	}
	public void setCodeKey(String codeKey){
		this.codeKey = codeKey;
	}
	public String getCodeKey(){
		return this.codeKey;
	}
	public void setCodeValue(String codeValue){
		this.codeValue = codeValue;
	}
	public String getCodeValue(){
		return this.codeValue;
	}
	public void setType(String type){
		this.type = type;
	}
	public String getType(){
		return this.type;
	}
	public void setDescription(String description){
		this.description = description;
	}
	public String getDescription(){
		return this.description;
	}
}