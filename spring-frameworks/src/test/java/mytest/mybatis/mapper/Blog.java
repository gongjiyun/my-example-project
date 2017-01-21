package mytest.mybatis.mapper;

import java.util.Date;

public class Blog {
	
	private long id;
	private String title;
	private String description;
	private Date createDate;
	private long createBy;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public long getCreateBy() {
		return createBy;
	}
	public void setCreateBy(long createBy) {
		this.createBy = createBy;
	}

	@Override
	public String toString() {
		return "id=" + this.id + ", title=" + this.title + ", description=" + this.description;
	}
	
}
