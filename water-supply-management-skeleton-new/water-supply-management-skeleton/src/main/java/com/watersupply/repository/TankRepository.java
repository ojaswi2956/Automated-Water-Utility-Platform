package com.watersupply.repository;

import com.watersupply.model.Tank;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface TankRepository extends MongoRepository<Tank, String> {
    List<Tank> findByStatus(String status);
    List<Tank> findByLocationContaining(String location);
}