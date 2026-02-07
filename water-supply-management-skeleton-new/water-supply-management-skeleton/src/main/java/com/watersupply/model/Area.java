package com.watersupply.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.Date;

@Document(collection = "areas")
public class Area {
    @Id
    private String id;
    private String name;
    private String zone;
    private int population;
    private double waterDemand; // liters per day
    private String primaryTankId;
    private String backupTankId;
    private String status; // SERVED, LOW_SUPPLY, CRITICAL
    
    // Transient fields for display purposes
    private transient String primaryTankName;
    private transient String backupTankName;
    private Date createdAt;
    private Date updatedAt;

    // Constructors
    public Area() {
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getZone() { return zone; }
    public void setZone(String zone) { this.zone = zone; }

    public int getPopulation() { return population; }
    public void setPopulation(int population) { this.population = population; }

    public double getWaterDemand() { return waterDemand; }
    public void setWaterDemand(double waterDemand) { this.waterDemand = waterDemand; }

    public String getPrimaryTankId() { return primaryTankId; }
    public void setPrimaryTankId(String primaryTankId) { this.primaryTankId = primaryTankId; }

    public String getBackupTankId() { return backupTankId; }
    public void setBackupTankId(String backupTankId) { this.backupTankId = backupTankId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPrimaryTankName() { return primaryTankName; }
    public void setPrimaryTankName(String primaryTankName) { this.primaryTankName = primaryTankName; }

    public String getBackupTankName() { return backupTankName; }
    public void setBackupTankName(String backupTankName) { this.backupTankName = backupTankName; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}