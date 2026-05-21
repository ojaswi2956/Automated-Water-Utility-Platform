package com.watersupply.repository;

import com.watersupply.model.SupplySchedule;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;
import java.util.Date;

public interface ScheduleRepository extends MongoRepository<SupplySchedule, String> {
    List<SupplySchedule> findByAreaId(String areaId);
    List<SupplySchedule> findByTankId(String tankId);
    List<SupplySchedule> findByIsActive(boolean isActive);
    List<SupplySchedule> findByStartTimeBetween(Date start, Date end);
}