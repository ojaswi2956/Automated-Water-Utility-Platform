package com.watersupply.service;

import com.watersupply.model.Tank;
import com.watersupply.repository.TankRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class TankService {
    @Autowired
    private TankRepository tankRepository;

    public List<Tank> getAllTanks() {
        return tankRepository.findAll();
    }

    public Optional<Tank> getTankById(String id) {
        return tankRepository.findById(id);
    }

    public List<Tank> getTanksByStatus(String status) {
        return tankRepository.findByStatus(status);
    }

    public Tank createTank(Tank tank) {
        return tankRepository.save(tank);
    }

    public Tank updateTank(String id, Tank tankDetails) {
        Optional<Tank> optionalTank = tankRepository.findById(id);
        if (optionalTank.isPresent()) {
            Tank tank = optionalTank.get();
            tank.setName(tankDetails.getName());
            tank.setLocation(tankDetails.getLocation());
            tank.setCapacity(tankDetails.getCapacity());
            tank.setCurrentLevel(tankDetails.getCurrentLevel());
            tank.setStatus(tankDetails.getStatus());
            tank.setLastMaintenance(tankDetails.getLastMaintenance());
            tank.setUpdatedAt(new java.util.Date());
            return tankRepository.save(tank);
        }
        return null;
    }

    public boolean deleteTank(String id) {
        if (tankRepository.existsById(id)) {
            tankRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public double getTotalCapacity() {
        return getAllTanks().stream()
                .mapToDouble(Tank::getCapacity)
                .sum();
    }

    public double getTotalCurrentWater() {
        return getAllTanks().stream()
                .mapToDouble(Tank::getCurrentLevel)
                .sum();
    }
}