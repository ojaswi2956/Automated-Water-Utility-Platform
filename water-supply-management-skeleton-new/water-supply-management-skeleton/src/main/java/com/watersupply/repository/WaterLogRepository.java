package com.watersupply.repository;

import com.watersupply.model.WaterLog;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;
import java.util.Date;

public interface WaterLogRepository extends MongoRepository<WaterLog, String> {
    List<WaterLog> findByTankId(String tankId);
    List<WaterLog> findByAreaId(String areaId);
    List<WaterLog> findByLogType(String logType);
    List<WaterLog> findByTimestampBetween(Date start, Date end);
    List<WaterLog> findByStatus(String status);
}