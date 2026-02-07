package com.watersupply.alertservice.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/alerts")
public class AlertController {

    @GetMapping("/list")
    public List<Map<String, Object>> getAlerts() {
        List<Map<String, Object>> alerts = new ArrayList<>();
        Map<String, Object> alert1 = new HashMap<>();
        alert1.put("id", "1");
        alert1.put("type", "WATER_LEVEL_LOW");
        alert1.put("message", "Tank A water level is below 20%");
        alert1.put("timestamp", "2025-09-14T17:50:00Z");
        alert1.put("severity", "HIGH");
        alerts.add(alert1);

        Map<String, Object> alert2 = new HashMap<>();
        alert2.put("id", "2");
        alert2.put("type", "MAINTENANCE_DUE");
        alert2.put("message", "Tank B requires scheduled maintenance");
        alert2.put("timestamp", "2025-09-14T17:45:00Z");
        alert2.put("severity", "MEDIUM");
        alerts.add(alert2);

        return alerts;
    }
    
}