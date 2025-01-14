package entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "school")
public class School {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "school_code", unique = true, nullable = false)
    private String schoolCode;

    @Column(name = "school_name", nullable = false)
    private String schoolName;

    @Column(name = "version")
    private int version;
    
    @Column(name = "has_logo")
    private boolean hasLogo;

    @Column(name = "has_studio_pss")
    private boolean hasStudioPss;

    @Column(name = "has_in_school_recording")
    private boolean hasInSchoolRecording;

    @Column(name = "has_youtube_upload")
    private boolean hasYoutubeUpload;

    @Column(name = "youtube_url")
    private String youtubeUrl;

    @Column(name = "has_external_recording")
    private boolean hasExternalRecording;

    @Column(name = "has_external_collaboration")
    private boolean hasExternalCollaboration;

    @Column(name = "has_green_screen")
    private boolean hasGreenScreen;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @Column(name = "timeline_start")
    private LocalDateTime timelineStart;
    
    @Column(name = "timeline_end")
    private LocalDateTime timelineEnd;
    
    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private TimelineStatus status;
    
    @Column(name = "extension_requested")
    private boolean extensionRequested = false;


    
    public enum TimelineStatus {
    	ONGOING,
        ASSIGNED,
        EXTENDED,
        EXCEEDED,
        COMPLETE,
        NOT_ASSIGNED
    }

    // Default constructor
    public School() {
    }

    protected void calculateVersion() {
        if (hasGreenScreen && hasExternalCollaboration && hasExternalRecording && 
            hasLogo && hasStudioPss && hasYoutubeUpload && hasInSchoolRecording) {
            this.version = 4;
        } else if (hasExternalCollaboration && hasExternalRecording && 
                   hasLogo && hasStudioPss && hasYoutubeUpload && hasInSchoolRecording) {
            this.version = 3;
        } else if (hasLogo && hasStudioPss && hasYoutubeUpload && hasInSchoolRecording) {
            this.version = 2;
        } else if (hasLogo && hasStudioPss) {
            this.version = 1;
        } else {
            this.version = 0;
        }
    }

    public int getVersion() {
        return version;
    }

    public void setVersion(int version) {
        this.version = version;
    }
  
    public boolean isExtensionRequested() {
        return extensionRequested;
    }

    public void setExtensionRequested(boolean extensionRequested) {
        this.extensionRequested = extensionRequested;
    }
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        calculateVersion();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
        calculateVersion();
    }


    // Getters and Setters
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

    public boolean isHasLogo() {
        return hasLogo;
    }

    public void setHasLogo(boolean hasLogo) {
        this.hasLogo = hasLogo;
    }

    public boolean isHasStudioPss() {
        return hasStudioPss;
    }

    public void setHasStudioPss(boolean hasStudioPss) {
        this.hasStudioPss = hasStudioPss;
    }

    public boolean isHasInSchoolRecording() {
        return hasInSchoolRecording;
    }

    public void setHasInSchoolRecording(boolean hasInSchoolRecording) {
        this.hasInSchoolRecording = hasInSchoolRecording;
    }

    public boolean isHasYoutubeUpload() {
        return hasYoutubeUpload;
    }

    public void setHasYoutubeUpload(boolean hasYoutubeUpload) {
        this.hasYoutubeUpload = hasYoutubeUpload;
    }

    public String getYoutubeUrl() {
        return youtubeUrl;
    }

    public void setYoutubeUrl(String youtubeUrl) {
        this.youtubeUrl = youtubeUrl;
    }

    public boolean isHasExternalRecording() {
        return hasExternalRecording;
    }

    public void setHasExternalRecording(boolean hasExternalRecording) {
        this.hasExternalRecording = hasExternalRecording;
    }

    public boolean isHasExternalCollaboration() {
        return hasExternalCollaboration;
    }

    public void setHasExternalCollaboration(boolean hasExternalCollaboration) {
        this.hasExternalCollaboration = hasExternalCollaboration;
    }

    public boolean isHasGreenScreen() {
        return hasGreenScreen;
    }

    public void setHasGreenScreen(boolean hasGreenScreen) {
        this.hasGreenScreen = hasGreenScreen;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    public LocalDateTime getTimelineStart() {
        return timelineStart;
    }
    
    public void setTimelineStart(LocalDateTime timelineStart) {
        this.timelineStart = timelineStart;
    }
    
    public LocalDateTime getTimelineEnd() {
        return timelineEnd;
    }
    
    public void setTimelineEnd(LocalDateTime timelineEnd) {
        this.timelineEnd = timelineEnd;
    }
    
    public TimelineStatus getStatus() {
        return status;
    }
    
    public void setStatus(TimelineStatus status) {
        this.status = status;
    }

  

    // toString method for debugging
    @Override
    public String toString() {
        return "School{" +
                "id=" + id +
                ", schoolCode='" + schoolCode + '\'' +
                ", schoolName='" + schoolName + '\'' +
                ", hasLogo=" + hasLogo +
                ", hasStudioPss=" + hasStudioPss +
                ", hasInSchoolRecording=" + hasInSchoolRecording +
                ", hasYoutubeUpload=" + hasYoutubeUpload +
                ", youtubeUrl='" + youtubeUrl + '\'' +
                ", hasExternalRecording=" + hasExternalRecording +
                ", hasExternalCollaboration=" + hasExternalCollaboration +
                ", hasGreenScreen=" + hasGreenScreen +
                ", version=" + version +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}