
package com.watersupply.controller;

import com.watersupply.model.Area;
import com.watersupply.service.AreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/areas")
public class AreaController {

    @Autowired
    private AreaService areaService;

    @GetMapping
    public List<Area> getAllAreas() {
        return areaService.getAllAreas();
    }

    @GetMapping("/{id}")
    public Optional<Area> getAreaById(@PathVariable String id) {
        return areaService.getAreaById(id);
    }

    @GetMapping("/zone/{zone}")
    public List<Area> getAreasByZone(@PathVariable String zone) {
        return areaService.getAreasByZone(zone);
    }

    @GetMapping("/status/{status}")
    public List<Area> getAreasByStatus(@PathVariable String status) {
        return areaService.getAreasByStatus(status);
    }

    @PostMapping
    public Area createArea(@RequestBody Area area) {
        return areaService.createArea(area);
    }

    @PutMapping("/{id}")
    public Area updateArea(@PathVariable String id, @RequestBody Area areaDetails) {
        return areaService.updateArea(id, areaDetails);
    }

    @DeleteMapping("/{id}")
    public boolean deleteArea(@PathVariable String id) {
        return areaService.deleteArea(id);
    }
}
