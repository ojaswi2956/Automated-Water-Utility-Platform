package com.watersupply.controller;

import com.watersupply.model.Area;
import com.watersupply.model.Tank;
import com.watersupply.service.AreaService;
import com.watersupply.service.TankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/test")
public class TestController {

    @Autowired
    private AreaService areaService;

    @Autowired
    private TankService tankService;

    @GetMapping("/areas-with-tank-names")
    public List<Area> getAreasWithTankNames() {
        List<Area> areas = areaService.getAllAreas();
        List<Tank> tanks = tankService.getAllTanks();
        
        // Create maps for ID to name resolution
        Map<String, String> tankIdToName = tanks.stream()
            .collect(Collectors.toMap(Tank::getId, Tank::getName));
        
        System.out.println("=== TEST CONTROLLER DEBUG ===");
        System.out.println("Tank ID to Name mapping:");
        tankIdToName.forEach((id, name) -> System.out.println("  Tank ID: " + id + " -> Name: " + name));
        
        // Add tank names to areas for display
        areas.forEach(area -> {
            System.out.println("Processing area: " + area.getName());
            System.out.println("  Primary Tank ID: " + area.getPrimaryTankId());
            System.out.println("  Backup Tank ID: " + area.getBackupTankId());
            
            if (area.getPrimaryTankId() != null) {
                String primaryTankName = tankIdToName.get(area.getPrimaryTankId());
                System.out.println("  Resolved Primary Tank Name: " + primaryTankName);
                area.setPrimaryTankName(primaryTankName);
            }
            if (area.getBackupTankId() != null) {
                String backupTankName = tankIdToName.get(area.getBackupTankId());
                System.out.println("  Resolved Backup Tank Name: " + backupTankName);
                area.setBackupTankName(backupTankName);
            }
        });
        
        return areas;
    }
}