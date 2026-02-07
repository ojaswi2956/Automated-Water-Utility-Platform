package com.watersupply.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.Date;

@Document(collection = "issues")
public class Issue {
    @Id
    private String id;
    private String userId;
    private String username;
    private String userEmail;
    private String issueType;
    private String title;
    private String description;
    private String location;
    private String priority; // HIGH, MEDIUM, LOW
    private String status; // OPEN, IN_PROGRESS, RESOLVED, CLOSED
    private String contactPhone;
    private String assignedTo; // Admin user ID
    private String resolution;
    private Date createdAt;
    private Date updatedAt;
    private Date resolvedAt;

    // Constructors
    public Issue() {
        this.createdAt = new Date();
        this.updatedAt = new Date();
        this.status = "OPEN";
    }

    public Issue(String userId, String username, String userEmail, String issueType, 
                 String title, String description, String location, String priority) {
        this();
        this.userId = userId;
        this.username = username;
        this.userEmail = userEmail;
        this.issueType = issueType;
        this.title = title;
        this.description = description;
        this.location = location;
        this.priority = priority;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }

    public String getIssueType() { return issueType; }
    public void setIssueType(String issueType) { this.issueType = issueType; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getContactPhone() { return contactPhone; }
    public void setContactPhone(String contactPhone) { this.contactPhone = contactPhone; }

    public String getAssignedTo() { return assignedTo; }
    public void setAssignedTo(String assignedTo) { this.assignedTo = assignedTo; }

    public String getResolution() { return resolution; }
    public void setResolution(String resolution) { this.resolution = resolution; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public Date getResolvedAt() { return resolvedAt; }
    public void setResolvedAt(Date resolvedAt) { this.resolvedAt = resolvedAt; }

    // Helper methods
    public String getIssueId() {
        return "#WS-" + (createdAt != null ? String.format("%tY", createdAt) : "2025") + "-" + 
               String.format("%03d", id != null ? id.hashCode() % 1000 : 0);
    }
}

