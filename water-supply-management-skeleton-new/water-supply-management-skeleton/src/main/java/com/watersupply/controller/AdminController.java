package com.watersupply.controller;

import com.watersupply.model.Area;
import com.watersupply.model.Bill;
import com.watersupply.model.SupplySchedule;
import com.watersupply.model.User;
import com.watersupply.model.Tank;
import com.watersupply.model.Issue;
import com.watersupply.service.TankService;
import com.watersupply.service.AreaService;
import com.watersupply.service.ScheduleService;
import com.watersupply.service.UserService;
import com.watersupply.service.WaterLogService;
import com.watersupply.service.IssueService;
import com.watersupply.service.BillingService;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private TankService tankService;

    @Autowired
    private AreaService areaService;

    @Autowired
    private ScheduleService scheduleService;

    @Autowired
    private UserService userService;

    @Autowired
    private WaterLogService waterLogService;

    @Autowired
    private IssueService issueService;

    @Autowired
    private BillingService billingService;

    // --- ADMIN BILLING MANAGEMENT ---
    @GetMapping("/billing")
public String billingPage(Model model) {
    List<Bill> bills = billingService.getAllBills();
    List<User> users = userService.getAllUsers();
    model.addAttribute("bills", bills);
    model.addAttribute("users", users);
    return "admin/billing";
}

    

    // ... (rest of your admin endpoints: dashboard, tanks, areas, schedules, users, issues, etc.) ...
    // Your previous endpoints remain unchanged below this section.

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        double totalCapacity = tankService.getTotalCapacity();
        double currentWater = tankService.getTotalCurrentWater();
        double totalDemand = areaService.getTotalWaterDemand();
        int totalPopulation = areaService.getTotalPopulation();
        
        model.addAttribute("totalCapacity", totalCapacity);
        model.addAttribute("currentWater", currentWater);
        model.addAttribute("totalDemand", totalDemand);
        model.addAttribute("totalPopulation", totalPopulation);
        model.addAttribute("systemStatus", currentWater >= totalDemand ? "OK" : "CRITICAL");
        
        return "admin/dashboard";
    }

    @GetMapping("/tanks")
    public String manageTanks(Model model) {
        List<Tank> tanks = tankService.getAllTanks();
        model.addAttribute("tanks", tanks);
        model.addAttribute("tank", new Tank());
        return "admin/tanks";
    }

    @PostMapping("/tanks/create")
    public String createTank(@ModelAttribute Tank tank) {
        tankService.createTank(tank);
        return "redirect:/admin/tanks";
    }

    @PostMapping("/tanks/update/{id}")
    public String updateTank(@PathVariable String id, @ModelAttribute Tank tank) {
        tankService.updateTank(id, tank);
        return "redirect:/admin/tanks";
    }

    @PostMapping("/tanks/delete/{id}")
    public String deleteTank(@PathVariable String id) {
        tankService.deleteTank(id);
        return "redirect:/admin/tanks";
    }

    // AJAX endpoints for Tank CRUD
    @GetMapping("/tanks/edit/{id}")
    @ResponseBody
    public ResponseEntity<Tank> getTankForEdit(@PathVariable String id) {
        Optional<Tank> tank = tankService.getTankById(id);
        return tank.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/tanks/update-ajax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateTankAjax(@RequestBody Tank tank) {
        Map<String, Object> response = new HashMap<>();
        try {
            tankService.updateTank(tank.getId(), tank);
            response.put("success", true);
            response.put("message", "Tank updated successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error updating tank: " + e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/tanks/delete-ajax/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteTankAjax(@PathVariable String id) {
        Map<String, Object> response = new HashMap<>();
        try {
            tankService.deleteTank(id);
            response.put("success", true);
            response.put("message", "Tank deleted successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error deleting tank: " + e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @GetMapping("/areas")
    public String manageAreas(Model model) {
        List<Area> areas = areaService.getAllAreas();
        List<Tank> tanks = tankService.getAllTanks();
        
        // Create maps for ID to name resolution
        Map<String, String> tankIdToName = tanks.stream()
            .collect(Collectors.toMap(Tank::getId, Tank::getName));
        
        System.out.println("=== TANK ID TO NAME MAPPING ===");
        tankIdToName.forEach((id, name) -> System.out.println("Tank ID: " + id + " -> Name: " + name));
        
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
        
        model.addAttribute("areas", areas);
        model.addAttribute("tanks", tanks);
        model.addAttribute("area", new Area());
        return "admin/areas";
    }

    @PostMapping("/areas/create")
    public String createArea(@ModelAttribute Area area) {
        areaService.createArea(area);
        return "redirect:/admin/areas";
    }

    @PostMapping("/areas/update/{id}")
    public String updateArea(@PathVariable String id, @ModelAttribute Area area) {
        areaService.updateArea(id, area);
        return "redirect:/admin/areas";
    }

    @PostMapping("/areas/delete/{id}")
    public String deleteArea(@PathVariable String id) {
        areaService.deleteArea(id);
        return "redirect:/admin/areas";
    }

    // AJAX endpoints for Area CRUD
    @GetMapping("/areas/edit/{id}")
    @ResponseBody
    public ResponseEntity<Area> getAreaForEdit(@PathVariable String id) {
        Optional<Area> area = areaService.getAreaById(id);
        return area.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/areas/update-ajax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateAreaAjax(@RequestBody Area area) {
        Map<String, Object> response = new HashMap<>();
        try {
            areaService.updateArea(area.getId(), area);
            response.put("success", true);
            response.put("message", "Area updated successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error updating area: " + e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/areas/delete-ajax/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteAreaAjax(@PathVariable String id) {
        Map<String, Object> response = new HashMap<>();
        try {
            areaService.deleteArea(id);
            response.put("success", true);
            response.put("message", "Area deleted successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error deleting area: " + e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @GetMapping("/schedules")
    public String manageSchedules(Model model) {
        try {
            System.out.println("=== LOADING SCHEDULES PAGE ===");
            List<SupplySchedule> schedules = scheduleService.getAllSchedules();
            List<Area> areas = areaService.getAllAreas();
            List<Tank> tanks = tankService.getAllTanks();
            
            System.out.println("Found " + schedules.size() + " schedules");
            System.out.println("Found " + areas.size() + " areas");
            System.out.println("Found " + tanks.size() + " tanks");
            
            // Create maps for ID to name resolution
            Map<String, String> areaIdToName = areas.stream()
                .collect(Collectors.toMap(Area::getId, Area::getName));
            Map<String, String> tankIdToName = tanks.stream()
                .collect(Collectors.toMap(Tank::getId, Tank::getName));
            
            System.out.println("=== SCHEDULE RESOLUTION DEBUG ===");
            System.out.println("Area ID to Name mapping:");
            areaIdToName.forEach((id, name) -> System.out.println("  Area ID: " + id + " -> Name: " + name));
            System.out.println("Tank ID to Name mapping:");
            tankIdToName.forEach((id, name) -> System.out.println("  Tank ID: " + id + " -> Name: " + name));
            
            // Add names to schedules for display
            schedules.forEach(schedule -> {
                System.out.println("Processing schedule ID: " + schedule.getId());
                System.out.println("  Area ID: " + schedule.getAreaId());
                System.out.println("  Tank ID: " + schedule.getTankId());
                
                if (schedule.getAreaId() != null) {
                    String areaName = areaIdToName.get(schedule.getAreaId());
                    System.out.println("  Resolved Area Name: " + areaName);
                    schedule.setAreaName(areaName);
                }
                if (schedule.getTankId() != null) {
                    String tankName = tankIdToName.get(schedule.getTankId());
                    System.out.println("  Resolved Tank Name: " + tankName);
                    schedule.setTankName(tankName);
                }
            });
            
            model.addAttribute("schedules", schedules);
            model.addAttribute("areas", areas);
            model.addAttribute("tanks", tanks);
            model.addAttribute("schedule", new SupplySchedule());
            return "admin/schedules";
        } catch (Exception e) {
            System.err.println("Error loading schedules page: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("schedules", new java.util.ArrayList<SupplySchedule>());
            model.addAttribute("areas", new java.util.ArrayList<Area>());
            model.addAttribute("tanks", new java.util.ArrayList<Tank>());
            model.addAttribute("schedule", new SupplySchedule());
            return "admin/schedules";
        }
    }
    
    
    

    @PostMapping("/schedules/create")
    public String createSchedule(@RequestParam Map<String, String> allParams) {
        try {
            
            // Create a new schedule object
            SupplySchedule schedule = new SupplySchedule();
            
            // Extract and validate required fields
            String areaId = allParams.get("areaId");
            String tankId = allParams.get("tankId");
            String waterAmountStr = allParams.get("waterAmount");
            String frequency = allParams.get("frequency");
            String isActiveStr = allParams.get("isActive");
            String startTime = allParams.get("startTime");
            String endTime = allParams.get("endTime");
            
            
            // Validate required fields
            if (areaId == null || areaId.isEmpty()) {
                System.err.println("ERROR: AreaId is required but not provided");
                return "redirect:/admin/schedules?error=true&message=Area is required";
            }
            if (tankId == null || tankId.isEmpty()) {
                System.err.println("ERROR: TankId is required but not provided");
                return "redirect:/admin/schedules?error=true&message=Tank is required";
            }
            if (waterAmountStr == null || waterAmountStr.isEmpty()) {
                System.err.println("ERROR: WaterAmount is required but not provided");
                return "redirect:/admin/schedules?error=true&message=Water amount is required";
            }
            
            // Set basic properties
            schedule.setAreaId(areaId);
            schedule.setTankId(tankId);
            schedule.setWaterAmount(Double.parseDouble(waterAmountStr));
            schedule.setFrequency(frequency != null ? frequency : "DAILY");
            schedule.setActive(isActiveStr != null && "true".equals(isActiveStr));
            
            // Set default times if not provided
            if (startTime == null || startTime.isEmpty()) {
                startTime = "08:00";
            }
            if (endTime == null || endTime.isEmpty()) {
                endTime = "17:00";
            }
            
            // Convert time strings to Date objects (using today's date)
            java.time.LocalDate today = java.time.LocalDate.now();
            java.time.LocalTime start = java.time.LocalTime.parse(startTime);
            java.time.LocalTime end = java.time.LocalTime.parse(endTime);
            
            java.time.LocalDateTime startDateTime = java.time.LocalDateTime.of(today, start);
            java.time.LocalDateTime endDateTime = java.time.LocalDateTime.of(today, end);
            
            schedule.setStartTime(java.sql.Timestamp.valueOf(startDateTime));
            schedule.setEndTime(java.sql.Timestamp.valueOf(endDateTime));
            
            // Set timestamps
            schedule.setCreatedAt(new java.util.Date());
            schedule.setUpdatedAt(new java.util.Date());
            
            SupplySchedule savedSchedule = scheduleService.createSchedule(schedule);
            
            return "redirect:/admin/schedules?success=true";
        } catch (Exception e) {
            // Log the error and redirect back to schedules page
            System.err.println("ERROR creating schedule: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/admin/schedules?error=true&message=" + e.getMessage();
        }
    }

    @PostMapping("/schedules/update/{id}")
    public String updateSchedule(@PathVariable String id, @ModelAttribute SupplySchedule schedule) {
        scheduleService.updateSchedule(id, schedule);
        return "redirect:/admin/schedules";
    }

    @PostMapping("/schedules/delete/{id}")
    public String deleteSchedule(@PathVariable String id) {
        scheduleService.deleteSchedule(id);
        return "redirect:/admin/schedules";
    }

    @PostMapping("/schedules/toggle/{id}")
    public String toggleSchedule(@PathVariable String id, @RequestParam boolean active) {
        scheduleService.toggleScheduleStatus(id, active);
        return "redirect:/admin/schedules";
    }

    // AJAX endpoints for Schedule CRUD
    @GetMapping("/schedules/edit/{id}")
    @ResponseBody
    public ResponseEntity<SupplySchedule> getScheduleForEdit(@PathVariable String id) {
        Optional<SupplySchedule> schedule = scheduleService.getScheduleById(id);
        return schedule.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/schedules/update-ajax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateScheduleAjax(@RequestBody SupplySchedule schedule) {
        Map<String, Object> response = new HashMap<>();
        try {
            scheduleService.updateSchedule(schedule.getId(), schedule);
            response.put("success", true);
            response.put("message", "Schedule updated successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error updating schedule: " + e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/schedules/delete-ajax/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteScheduleAjax(@PathVariable String id) {
        Map<String, Object> response = new HashMap<>();
        try {
            scheduleService.deleteSchedule(id);
            response.put("success", true);
            response.put("message", "Schedule deleted successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error deleting schedule: " + e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/schedules/toggle-ajax/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleScheduleAjax(@PathVariable String id, @RequestParam boolean active) {
        Map<String, Object> response = new HashMap<>();
        try {
            scheduleService.toggleScheduleStatus(id, active);
            response.put("success", true);
            response.put("message", "Schedule " + (active ? "activated" : "deactivated") + " successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error toggling schedule: " + e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @GetMapping("/users")
    public String manageUsers(Model model) {
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        model.addAttribute("user", users);
        return "admin/user-management";
    }

    @GetMapping("/operations")
    public String operations(Model model) {
        try {
            // Get actual data for overview sections with error handling
            List<Tank> tanks = new java.util.ArrayList<>();
            List<Area> areas = new java.util.ArrayList<>();
            List<SupplySchedule> schedules = new java.util.ArrayList<>();
            
            try {
                tanks = tankService.getAllTanks();
            } catch (Exception e) {
                System.err.println("Error getting tanks: " + e.getMessage());
            }
            
            try {
                areas = areaService.getAllAreas();
            } catch (Exception e) {
                System.err.println("Error getting areas: " + e.getMessage());
            }
            
            try {
                schedules = scheduleService.getAllSchedules();
            } catch (Exception e) {
                System.err.println("Error getting schedules: " + e.getMessage());
            }
            
            model.addAttribute("tanks", tanks);
            model.addAttribute("areas", areas);
            model.addAttribute("schedules", schedules);
            
            return "admin/operations";
        } catch (Exception e) {
            System.err.println("Error loading operations page: " + e.getMessage());
            // Return with empty data if there's an error
            model.addAttribute("tanks", new java.util.ArrayList<Tank>());
            model.addAttribute("areas", new java.util.ArrayList<Area>());
            model.addAttribute("schedules", new java.util.ArrayList<SupplySchedule>());
            return "admin/operations";
        }
    }

    @GetMapping("/distribution")
    public String distribution() {
        return "admin/distribution";
    }

    @PostMapping("/users/create")
    public String createUser(@ModelAttribute User user) {
        userService.createUser(user);
        return "redirect:/admin/user-management";
    }

    @PostMapping("/users/update/{id}")
    public String updateUser(@PathVariable String id, @ModelAttribute User user) {
        userService.updateUser(id, user);
        return "redirect:/admin/user-management";
    }

    @PostMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable String id) {
        userService.deleteUser(id);
        return "redirect:/admin/user-management";
    }

    // AJAX endpoints for User CRUD
    @GetMapping("/users/edit/{id}")
    @ResponseBody
    public ResponseEntity<User> getUserForEdit(@PathVariable String id) {
        System.out.println("Requested user id: " + id);
        Optional<User> user = userService.getUserById(id);
        System.out.println("User found: " + user.isPresent());
        return user.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/users/update-ajax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateUserAjax(@RequestBody User user) {
        Map<String, Object> response = new HashMap<>();
        try {
            userService.updateUser(user.getId(), user);
            response.put("success", true);
            response.put("message", "User updated successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error updating user: " + e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/users/delete-ajax/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteUserAjax(@PathVariable String id) {
        Map<String, Object> response = new HashMap<>();
        try {
            userService.deleteUser(id);
            response.put("success", true);
            response.put("message", "User deleted successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error deleting user: " + e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/users/create-ajax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createUserAjax(@RequestBody User user) {
        Map<String, Object> response = new HashMap<>();
        try {
            userService.createUser(user);
            response.put("success", true);
            response.put("message", "User created successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error creating user: " + e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @GetMapping("/logs")
    public String viewLogs(Model model) {
        model.addAttribute("logs", waterLogService.getAllLogs());
        return "admin/logs";
    }

    // Issue Management
    @GetMapping("/issues")
    public String manageIssues(Model model) {
        try {
            System.out.println("=== DEBUG: Entering manageIssues method ===");
            
            // Initialize empty lists for safety
            List<Issue> issues = new java.util.ArrayList<>();
            List<User> admins = new java.util.ArrayList<>();
            
            try {
                issues = issueService.getAllIssues();
                System.out.println("DEBUG: Retrieved " + issues.size() + " issues");
            } catch (Exception e) {
                System.err.println("DEBUG: Error getting issues: " + e.getMessage());
            }
            
            try {
                List<User> allUsers = userService.getAllUsers();
                admins = allUsers.stream()
                        .filter(user -> "ADMIN".equals(user.getRole()))
                        .collect(Collectors.toList());
                System.out.println("DEBUG: Retrieved " + admins.size() + " admin users");
            } catch (Exception e) {
                System.err.println("DEBUG: Error getting admin users: " + e.getMessage());
            }
            
            model.addAttribute("issues", issues);
            model.addAttribute("admins", admins);
            model.addAttribute("issue", new Issue());
            
            // Statistics with error handling
            try {
                model.addAttribute("totalIssues", issueService.getTotalIssues());
                model.addAttribute("openIssues", issueService.getOpenIssues());
                model.addAttribute("inProgressIssues", issueService.getInProgressIssues());
                model.addAttribute("resolvedIssues", issueService.getResolvedIssues());
                System.out.println("DEBUG: Statistics loaded successfully");
            } catch (Exception e) {
                // Set default values if statistics fail
                model.addAttribute("totalIssues", 0);
                model.addAttribute("openIssues", 0);
                model.addAttribute("inProgressIssues", 0);
                model.addAttribute("resolvedIssues", 0);
                System.err.println("DEBUG: Error getting issue statistics, using defaults: " + e.getMessage());
            }
            
            System.out.println("DEBUG: Returning admin/issues view");
            return "admin/issues";
            
        } catch (Exception e) {
            System.err.println("=== DEBUG: Critical error in manageIssues ===");
            e.printStackTrace();
            
            // Return with empty data if there's an error
            model.addAttribute("issues", new java.util.ArrayList<Issue>());
            model.addAttribute("admins", new java.util.ArrayList<User>());
            model.addAttribute("issue", new Issue());
            model.addAttribute("totalIssues", 0);
            model.addAttribute("openIssues", 0);
            model.addAttribute("inProgressIssues", 0);
            model.addAttribute("resolvedIssues", 0);
            model.addAttribute("error", "Database connection error. Please check MongoDB status.");
            
            System.out.println("DEBUG: Returning admin/issues view with error data");
            return "admin/issues";
        }
    }

    @PostMapping("/issues/update/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateIssue(@PathVariable String id, @RequestBody Issue issueDetails) {
        Map<String, Object> response = new HashMap<>();
        try {
            issueService.updateIssue(id, issueDetails);
            response.put("success", true);
            response.put("message", "Issue updated successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error updating issue: " + e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/issues/assign/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> assignIssue(@PathVariable String id, @RequestParam String assignedTo) {
        Map<String, Object> response = new HashMap<>();
        try {
            Optional<Issue> optionalIssue = issueService.getIssueById(id);
            if (optionalIssue.isPresent()) {
                Issue issue = optionalIssue.get();
                issue.setAssignedTo(assignedTo);
                issue.setStatus("IN_PROGRESS");
                issueService.updateIssue(id, issue);
                response.put("success", true);
                response.put("message", "Issue assigned successfully");
            } else {
                response.put("success", false);
                response.put("message", "Issue not found");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error assigning issue: " + e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/issues/resolve/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> resolveIssue(@PathVariable String id, @RequestParam String resolution) {
        Map<String, Object> response = new HashMap<>();
        try {
            Optional<Issue> optionalIssue = issueService.getIssueById(id);
            if (optionalIssue.isPresent()) {
                Issue issue = optionalIssue.get();
                issue.setStatus("RESOLVED");
                issue.setResolution(resolution);
                issueService.updateIssue(id, issue);
                response.put("success", true);
                response.put("message", "Issue resolved successfully");
            } else {
                response.put("success", false);
                response.put("message", "Issue not found");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error resolving issue: " + e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @GetMapping("/shortage-alert")
    public String shortageAlertPage() {
        return "shortage-alert";
    }

    @PostMapping("/send-shortage-alert")
    public String sendShortageAlert(
            @RequestParam("email") String email,
            @RequestParam("date") String date,
            Model model) {
        model.addAttribute("message", "Shortage alert sent to " + email + " for " + date + "!");
        return "shortage-alert";
    }
} 
