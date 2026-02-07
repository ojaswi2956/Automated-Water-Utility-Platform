package com.watersupply.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.Date;

@Document(collection = "water_logs")
public class WaterLog {
    @Id
    private String id;
    private String tankId;
    private String areaId;
    private String scheduleId;
    private double waterAmount;
    private String logType; // SUPPLY, CONSUMPTION, REFILL, LEAKAGE
    private String status; // SUCCESS, FAILED, PENDING
    private String notes;
    private Date timestamp;
    private Date createdAt;

    // Constructors
    public WaterLog() {
        this.timestamp = new Date();
        this.createdAt = new Date();
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTankId() { return tankId; }
    public void setTankId(String tankId) { this.tankId = tankId; }

    public String getAreaId() { return areaId; }
    public void setAreaId(String areaId) { this.areaId = areaId; }

    public String getScheduleId() { return scheduleId; }
    public void setScheduleId(String scheduleId) { this.scheduleId = scheduleId; }

    public double getWaterAmount() { return waterAmount; }
    public void setWaterAmount(double waterAmount) { this.waterAmount = waterAmount; }

    public String getLogType() { return logType; }
    public void setLogType(String logType) { this.logType = logType; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public Date getTimestamp() { return timestamp; }
    public void setTimestamp(Date timestamp) { this.timestamp = timestamp; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}