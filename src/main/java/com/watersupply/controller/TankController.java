
package com.watersupply.controller;

import com.watersupply.model.Tank;
import com.watersupply.service.TankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/tanks")
public class TankController {

    @Autowired
    private TankService tankService;

    @GetMapping
    public List<Tank> getAllTanks() {
        return tankService.getAllTanks();
    }

    @GetMapping("/{id}")
    public Optional<Tank> getTankById(@PathVariable String id) {
        return tankService.getTankById(id);
    }

    @GetMapping("/status/{status}")
    public List<Tank> getTanksByStatus(@PathVariable String status) {
        return tankService.getTanksByStatus(status);
    }

    @PostMapping
    public Tank createTank(@RequestBody Tank tank) {
        return tankService.createTank(tank);
    }

    @PutMapping("/{id}")
    public Tank updateTank(@PathVariable String id, @RequestBody Tank tankDetails) {
        return tankService.updateTank(id, tankDetails);
    }

    @DeleteMapping("/{id}")
    public boolean deleteTank(@PathVariable String id) {
        return tankService.deleteTank(id);
    }
}
