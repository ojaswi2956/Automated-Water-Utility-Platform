package com.watersupply.repository;

import com.watersupply.model.Area;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface AreaRepository extends MongoRepository<Area, String> {
    List<Area> findByZone(String zone);
    List<Area> findByStatus(String status);
    List<Area> findByPrimaryTankId(String tankId);
}