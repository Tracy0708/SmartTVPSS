package entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "activity")
public class Activity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;
	@Column(name = "activityName")
	private String activityName;
	@Column(name = "organizer")
	private String organizer;
	@Column(name = "startDate")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@Column(name = "endDate")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	@Column(name = "pic")
	private String pic;
	@Column(name = "phone")
	private String phone;
	@Column(name = "location")
	private String location;
	@Column(name = "description")
	private String description;
	@Column(name = "activityType")
	private String activityType;
	@Column(name = "activityLevel")
	private String activityLevel;
	@Column(name = "limitation")
	private int limitation;

	// Default constructor
	public Activity() {
	}
	
	public Activity(Integer id, String activityName, String organizer, Date startDate, Date endDate, String pic,
			String phone, String location, String description, String activityType, String activityLevel,
			int limitation) {
		super();
		this.id = id;
		this.activityName = activityName;
		this.organizer = organizer;
		this.startDate = startDate;
		this.endDate = endDate;
		this.pic = pic;
		this.phone = phone;
		this.location = location;
		this.description = description;
		this.activityType = activityType;
		this.activityLevel = activityLevel;
		this.limitation = limitation;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	public String getOrganizer() {
		return organizer;
	}

	public void setOrganizer(String organizer) {
		this.organizer = organizer;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getActivityType() {
		return activityType;
	}

	public void setActivityType(String activityType) {
		this.activityType = activityType;
	}

	public String getActivityLevel() {
		return activityLevel;
	}

	public void setActivityLevel(String activityLevel) {
		this.activityLevel = activityLevel;
	}

	public int getLimitation() {
		return limitation;
	}

	public void setLimitation(int limitation) {
		this.limitation = limitation;
	}

	@Override
	public String toString() {
		return "Activity [id =" + id + ", activityName =" + activityName + ", organizer=" + organizer + ", startDate="
				+ startDate + ", endDate=" + endDate + ", pic=" + pic + ", phone=" + phone + ", location=" + location
				+ ", description=" + description + ", activityType=" + activityType + ", activityLevel=" + activityLevel
				+ ", limitation=" + limitation + "]";
	}
	
	
}