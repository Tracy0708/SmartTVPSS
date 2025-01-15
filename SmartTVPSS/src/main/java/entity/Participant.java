package entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "participant")
public class Participant {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "participant_id")
	private Integer participant_id ;
	@Column(name = "name")
	private String name;
	@Column(name = "studentID")
	private String studentID;
	@Column(name = "gender")
	private String gender;
	@Column(name = "age")
	private int age;
	@Column(name = "school")
	private String school;
	@Column(name = "email")
	private String email;
	@Column(name = "phone")
	private String phone;
	@Column(name = "address")
	private String address;
	@Column(name = "activityId")
	private Integer activityId;

	// Default constructor
	public Participant() {
	}

	public Participant(Integer participant_id, String name, String studentID, String gender, int age, String school, String email,
			String phone, String address, String ProfilePicturePath, Integer activityId) {
		super();
		this.participant_id = participant_id;
		this.name = name;
		this.studentID = studentID;
		this.gender = gender;
		this.age = age;
		this.school = school;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.activityId = activityId;
	}

	public Integer getParticipant_id() {
		return participant_id;
	}

	public void setParticipant_id(Integer participant_id) {
		this.participant_id = participant_id;
	}

	public String getName() {
		return name;
	}

	public void setStudentID(String studentID) {
		this.studentID = studentID;
	}
	
	public String getStudentID() {
		return studentID;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Integer getActivityId() {
		return activityId;
	}

	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}
	
}