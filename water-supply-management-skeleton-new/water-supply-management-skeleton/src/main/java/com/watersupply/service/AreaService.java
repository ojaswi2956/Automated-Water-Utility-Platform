package com.watersupply.service;

import com.watersupply.model.Area;
import com.watersupply.repository.AreaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class AreaService {
    @Autowired
    private AreaRepository areaRepository;

    public List<Area> getAllAreas() {
        return areaRepository.findAll();
    }

    public Optional<Area> getAreaById(String id) {
        return areaRepository.findById(id);
    }

    public List<Area> getAreasByZone(String zone) {
        return areaRepository.findByZone(zone);
    }

    public List<Area> getAreasByStatus(String status) {
        return areaRepository.findByStatus(status);
    }

    public Area createArea(Area area) {
        return areaRepository.save(area);
    }

    public Area updateArea(String id, Area areaDetails) {
        Optional<Area> optionalArea = areaRepository.findById(id);
        if (optionalArea.isPresent()) {
            Area area = optionalArea.get();
            area.setName(areaDetails.getName());
            area.setZone(areaDetails.getZone());
            area.setPopulation(areaDetails.getPopulation());
            area.setWaterDemand(areaDetails.getWaterDemand());
            area.setPrimaryTankId(areaDetails.getPrimaryTankId());
            area.setBackupTankId(areaDetails.getBackupTankId());
            area.setStatus(areaDetails.getStatus());
            area.setUpdatedAt(new java.util.Date());
            return areaRepository.save(area);
        }
        return null;
    }

    public boolean deleteArea(String id) {
        if (areaRepository.existsById(id)) {
            areaRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public double getTotalWaterDemand() {
        return getAllAreas().stream()
                .mapToDouble(Area::getWaterDemand)
                .sum();
    }

    public int getTotalPopulation() {
        return getAllAreas().stream()
                .mapToInt(Area::getPopulation)
                .sum();
    }
}