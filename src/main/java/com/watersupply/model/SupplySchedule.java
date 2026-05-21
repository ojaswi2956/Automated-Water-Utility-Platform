package com.watersupply.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.Date;

@Document(collection = "supply_schedules")
public class SupplySchedule {
    @Id
    private String id;
    private String areaId;
    private String tankId;
    private Date startTime;
    private Date endTime;
    private double waterAmount; // liters to supply
    private String frequency; // DAILY, WEEKLY, CUSTOM
    private boolean isActive;
    
    // Transient fields for display purposes
    private transient String areaName;
    private transient String tankName;
    private Date createdAt;
    private Date updatedAt;

    // Constructors
    public SupplySchedule() {
        this.createdAt = new Date();
        this.updatedAt = new Date();
        this.isActive = true;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getAreaId() { return areaId; }
    public void setAreaId(String areaId) { this.areaId = areaId; }

    public String getTankId() { return tankId; }
    public void setTankId(String tankId) { this.tankId = tankId; }

    public Date getStartTime() { return startTime; }
    public void setStartTime(Date startTime) { this.startTime = startTime; }

    public Date getEndTime() { return endTime; }
    public void setEndTime(Date endTime) { this.endTime = endTime; }

    public double getWaterAmount() { return waterAmount; }
    public void setWaterAmount(double waterAmount) { this.waterAmount = waterAmount; }

    public String getFrequency() { return frequency; }
    public void setFrequency(String frequency) { this.frequency = frequency; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public String getAreaName() { return areaName; }
    public void setAreaName(String areaName) { this.areaName = areaName; }

    public String getTankName() { return tankName; }
    public void setTankName(String tankName) { this.tankName = tankName; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}