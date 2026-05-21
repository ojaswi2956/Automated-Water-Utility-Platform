
package com.watersupply.controller;

import com.watersupply.model.SupplySchedule;
import com.watersupply.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.Date;

@RestController
@RequestMapping("/api/schedules")
public class ScheduleController {

    @Autowired
    private ScheduleService scheduleService;

    @GetMapping
    public List<SupplySchedule> getAllSchedules() {
        return scheduleService.getAllSchedules();
    }

    @GetMapping("/{id}")
    public Optional<SupplySchedule> getScheduleById(@PathVariable String id) {
        return scheduleService.getScheduleById(id);
    }

    @GetMapping("/area/{areaId}")
    public List<SupplySchedule> getSchedulesByArea(@PathVariable String areaId) {
        return scheduleService.getSchedulesByArea(areaId);
    }

    @GetMapping("/tank/{tankId}")
    public List<SupplySchedule> getSchedulesByTank(@PathVariable String tankId) {
        return scheduleService.getSchedulesByTank(tankId);
    }

    @GetMapping("/active")
    public List<SupplySchedule> getActiveSchedules() {
        return scheduleService.getActiveSchedules();
    }

    @PostMapping
    public SupplySchedule createSchedule(@RequestBody SupplySchedule schedule) {
        return scheduleService.createSchedule(schedule);
    }

    @PutMapping("/{id}")
    public SupplySchedule updateSchedule(@PathVariable String id, @RequestBody SupplySchedule scheduleDetails) {
        return scheduleService.updateSchedule(id, scheduleDetails);
    }

    @DeleteMapping("/{id}")
    public boolean deleteSchedule(@PathVariable String id) {
        return scheduleService.deleteSchedule(id);
    }

    @PatchMapping("/{id}/toggle")
    public boolean toggleSchedule(@PathVariable String id, @RequestParam boolean active) {
        return scheduleService.toggleScheduleStatus(id, active);
    }
}
