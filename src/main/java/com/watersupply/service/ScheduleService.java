package com.watersupply.service;

import com.watersupply.model.SupplySchedule;
import com.watersupply.repository.ScheduleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;
import java.util.Date;

@Service
public class ScheduleService {
    @Autowired
    private ScheduleRepository scheduleRepository;

    public List<SupplySchedule> getAllSchedules() {
        try {
            return scheduleRepository.findAll();
        } catch (Exception e) {
            System.err.println("Error getting all schedules: " + e.getMessage());
            return new java.util.ArrayList<>();
        }
    }

    public Optional<SupplySchedule> getScheduleById(String id) {
        return scheduleRepository.findById(id);
    }

    public List<SupplySchedule> getSchedulesByArea(String areaId) {
        return scheduleRepository.findByAreaId(areaId);
    }

    public List<SupplySchedule> getSchedulesByTank(String tankId) {
        return scheduleRepository.findByTankId(tankId);
    }

    public List<SupplySchedule> getActiveSchedules() {
        return scheduleRepository.findByIsActive(true);
    }

    public List<SupplySchedule> getSchedulesByDateRange(Date start, Date end) {
        return scheduleRepository.findByStartTimeBetween(start, end);
    }

    public SupplySchedule createSchedule(SupplySchedule schedule) {
        try {
            if (scheduleRepository == null) {
                throw new RuntimeException("ScheduleRepository is not properly injected");
            }
            
            SupplySchedule savedSchedule = scheduleRepository.save(schedule);
            return savedSchedule;
        } catch (Exception e) {
            System.err.println("ERROR saving schedule: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    public SupplySchedule updateSchedule(String id, SupplySchedule scheduleDetails) {
        Optional<SupplySchedule> optionalSchedule = scheduleRepository.findById(id);
        if (optionalSchedule.isPresent()) {
            SupplySchedule schedule = optionalSchedule.get();
            schedule.setAreaId(scheduleDetails.getAreaId());
            schedule.setTankId(scheduleDetails.getTankId());
            schedule.setStartTime(scheduleDetails.getStartTime());
            schedule.setEndTime(scheduleDetails.getEndTime());
            schedule.setWaterAmount(scheduleDetails.getWaterAmount());
            schedule.setFrequency(scheduleDetails.getFrequency());
            schedule.setActive(scheduleDetails.isActive());
            schedule.setUpdatedAt(new java.util.Date());
            return scheduleRepository.save(schedule);
        }
        return null;
    }

    public boolean deleteSchedule(String id) {
        if (scheduleRepository.existsById(id)) {
            scheduleRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public boolean toggleScheduleStatus(String id, boolean active) {
        Optional<SupplySchedule> optionalSchedule = scheduleRepository.findById(id);
        if (optionalSchedule.isPresent()) {
            SupplySchedule schedule = optionalSchedule.get();
            schedule.setActive(active);
            schedule.setUpdatedAt(new java.util.Date());
            scheduleRepository.save(schedule);
            return true;
        }
        return false;
    }
}