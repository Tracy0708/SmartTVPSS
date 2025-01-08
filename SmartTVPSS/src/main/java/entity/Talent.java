package entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.util.Date;

@Entity
@Table(name = "talent")
public class Talent {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;
	@Column(name = "schoolCode")
	private String schoolCode;
	@Column(name = "schoolName")
	private String schoolName;
	@Column(name = "name")
	private String name;
	@Column(name = "gender")
	private String gender;
	@Column(name = "contact")
	private String contact;
	@Column(name = "email")
	private String email;
	@Column(name = "reason")
	private String reason;

	@Column(name = "interviewDate")
	@Temporal(TemporalType.DATE)
	private Date interviewDate;

	@Column(name = "interviewTime")
	private String interviewTime;

	@Column(name = "interviewResult")
	private String interviewResult;

	@Column(name = "applicationStatus")
	private String applicationStatus = "PENDING";

	// Default constructor
	public Talent() {
	}

	// Parameterized constructor
	public Talent(String schoolCode, String schoolName, String name, String gender, String contact, String email,
			String reason) {
		this.schoolCode = schoolCode;
		this.schoolName = schoolName;
		this.name = name;
		this.gender = gender;
		this.contact = contact;
		this.email = email;
		this.reason = reason;
	}

	// Getters and setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSchoolCode() {
		return schoolCode;
	}

	public void setSchoolCode(String schoolCode) {
		this.schoolCode = schoolCode;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public String getName() {
		return name;
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

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Date getInterviewDate() {
		return interviewDate;
	}

	public void setInterviewDate(Date interviewDate) {
		this.interviewDate = interviewDate;
	}

	public String getInterviewTime() {
		return interviewTime;
	}

	public void setInterviewTime(String interviewTime) {
		this.interviewTime = interviewTime;
	}

	public String getInterviewResult() {
		return interviewResult;
	}

	public void setInterviewResult(String interviewResult) {
		this.interviewResult = interviewResult;
	}

	public String getApplicationStatus() {
		return applicationStatus;
	}

	public void setApplicationStatus(String applicationStatus) {
		this.applicationStatus = applicationStatus;
	}

	// Update toString() method to include new fields
	@Override
	public String toString() {
		return "Talent [id=" + id + ", schoolCode=" + schoolCode + ", schoolName=" + schoolName + ", name=" + name
				+ ", gender=" + gender + ", contact=" + contact + ", email=" + email + ", reason=" + reason
				+ ", interviewDate=" + interviewDate + ", interviewTime=" + interviewTime + ", interviewResult="
				+ interviewResult + ", applicationStatus=" + applicationStatus + "]";
	}

}
