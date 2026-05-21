package com.watersupply.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.Date;

@Document(collection = "tanks")
public class Tank {
    @Id
    private String id;
    private String name;
    private String location;
    private double capacity; // liters
    private double currentLevel; // liters
    private String status; // ACTIVE, MAINTENANCE, OFFLINE
    private Date lastMaintenance;
    private Date createdAt;
    private Date updatedAt;

    // Constructors
    public Tank() {
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }

    public Tank(String name, String location, double capacity, double currentLevel, String status) {
        this();
        this.name = name;
        this.location = location;
        this.capacity = capacity;
        this.currentLevel = currentLevel;
        this.status = status;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public double getCapacity() { return capacity; }
    public void setCapacity(double capacity) { this.capacity = capacity; }

    public double getCurrentLevel() { return currentLevel; }
    public void setCurrentLevel(double currentLevel) { this.currentLevel = currentLevel; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getLastMaintenance() { return lastMaintenance; }
    public void setLastMaintenance(Date lastMaintenance) { this.lastMaintenance = lastMaintenance; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    // Helper methods
    public double getPercentage() {
        return capacity > 0 ? (currentLevel / capacity) * 100 : 0;
    }
}