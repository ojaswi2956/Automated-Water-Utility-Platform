package com.watersupply.service;

import com.watersupply.model.WaterLog;
import com.watersupply.repository.WaterLogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;
import java.util.Date;

@Service
public class WaterLogService {
    @Autowired
    private WaterLogRepository waterLogRepository;

    public List<WaterLog> getAllLogs() {
        return waterLogRepository.findAll();
    }

    public Optional<WaterLog> getLogById(String id) {
        return waterLogRepository.findById(id);
    }

    public List<WaterLog> getLogsByTank(String tankId) {
        return waterLogRepository.findByTankId(tankId);
    }

    public List<WaterLog> getLogsByArea(String areaId) {
        return waterLogRepository.findByAreaId(areaId);
    }

    public List<WaterLog> getLogsByType(String logType) {
        return waterLogRepository.findByLogType(logType);
    }

    public List<WaterLog> getLogsByDateRange(Date start, Date end) {
        return waterLogRepository.findByTimestampBetween(start, end);
    }

    public List<WaterLog> getLogsByStatus(String status) {
        return waterLogRepository.findByStatus(status);
    }

    public WaterLog createLog(WaterLog log) {
        return waterLogRepository.save(log);
    }

    public boolean deleteLog(String id) {
        if (waterLogRepository.existsById(id)) {
            waterLogRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public double getTotalWaterSupplied(Date start, Date end) {
        return getLogsByDateRange(start, end).stream()
                .filter(log -> "SUPPLY".equals(log.getLogType()) && "SUCCESS".equals(log.getStatus()))
                .mapToDouble(WaterLog::getWaterAmount)
                .sum();
    }

    public double getTotalWaterConsumed(Date start, Date end) {
        return getLogsByDateRange(start, end).stream()
                .filter(log -> "CONSUMPTION".equals(log.getLogType()) && "SUCCESS".equals(log.getStatus()))
                .mapToDouble(WaterLog::getWaterAmount)
                .sum();
    }
}