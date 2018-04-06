package mytest.spring.data.mongodb;

import java.util.Date;
import java.util.List;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "contacts")
public class Person {
	private String _id;
	private String name;
	private String email;
	private String gender;
	private int age;
	private Date birthDate;
	private Date contactNo;
	private List<Address> addrsses;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public Date getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}

	public String get_id() {
		return _id;
	}

	public void set_id(String _id) {
		this._id = _id;
	}

	public Date getContactNo() {
		return contactNo;
	}

	public void setContactNo(Date contactNo) {
		this.contactNo = contactNo;
	}

	public List<Address> getAddrsses() {
		return addrsses;
	}

	public void setAddrsses(List<Address> addrsses) {
		this.addrsses = addrsses;
	}

	@Override
	public String toString() {
		return "Person [_id=" + _id + ", name=" + name + ", age=" + age + "]";
	}

}
