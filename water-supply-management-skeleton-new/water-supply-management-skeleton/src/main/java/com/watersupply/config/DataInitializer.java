package com.watersupply.config;

import com.watersupply.model.User;
import com.watersupply.model.Tank;
import com.watersupply.model.Area;
import com.watersupply.model.SupplySchedule;
import com.watersupply.service.UserService;
import com.watersupply.service.TankService;
import com.watersupply.service.AreaService;
import com.watersupply.service.ScheduleService;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private UserService userService;

    @Autowired
    private TankService tankService;

    @Autowired
    private AreaService areaService;

    @Autowired
    private ScheduleService scheduleService;

    @Override
    public void run(String... args) throws Exception {
        // Create default admin user if it doesn't exist
        if (!userService.usernameExists("admin")) {
            User admin = new User("admin", "admin123", "admin@watersupply.com", "ADMIN");
            userService.createUser(admin);
            System.out.println("Created default admin user: admin/admin123");
        }

        // Create additional admin users
        if (!userService.usernameExists("superadmin")) {
            User superAdmin = new User("superadmin", "super123", "superadmin@watersupply.com", "ADMIN");
            userService.createUser(superAdmin);
            System.out.println("Created super admin user: superadmin/super123");
        }

        if (!userService.usernameExists("manager")) {
            User manager = new User("manager", "manager123", "manager@watersupply.com", "ADMIN");
            userService.createUser(manager);
            System.out.println("Created manager user: manager/manager123");
        }

        if (!userService.usernameExists("operator")) {
            User operator = new User("operator", "operator123", "operator@watersupply.com", "ADMIN");
            userService.createUser(operator);
            System.out.println("Created operator user: operator/operator123");
        }

        // Create default regular user if it doesn't exist
        if (!userService.usernameExists("user")) {
            User user = new User("user", "user123", "user@watersupply.com", "USER");
            userService.createUser(user);
            System.out.println("Created default user: user/user123");
        }

        // Create additional regular users
        if (!userService.usernameExists("customer1")) {
            User customer1 = new User("customer1", "customer123", "customer1@example.com", "USER");
            userService.createUser(customer1);
            System.out.println("Created customer user: customer1/customer123");
        }

        if (!userService.usernameExists("resident")) {
            User resident = new User("resident", "resident123", "resident@example.com", "USER");
            userService.createUser(resident);
               System.out.println("Created resident user: resident/resident123");
           }

           // Initialize sample data in correct order
           initializeSampleTanks();
           
           // Wait a moment for tanks to be fully saved
           Thread.sleep(500);
           
           // Initialize sample areas (depends on tanks)
           initializeSampleAreas();
           
           // Wait a moment for areas to be fully saved
           Thread.sleep(500);
           
           // Initialize sample schedules (depends on areas and tanks)
           initializeSampleSchedules();
       }

       private void initializeSampleTanks() {
           if (tankService.getAllTanks().isEmpty()) {
               // Create sample tanks
               Tank tank1 = new Tank("Main Reservoir A", "Central District", 1000000, 850000, "ACTIVE");
               Tank tank2 = new Tank("Tower Tank B", "North District", 250000, 200000, "ACTIVE");
               Tank tank3 = new Tank("Sector 12 Tank C", "South District", 150000, 22500, "ACTIVE");
               Tank tank4 = new Tank("Emergency Tank D", "East District", 500000, 400000, "ACTIVE");
               
               tankService.createTank(tank1);
               tankService.createTank(tank2);
               tankService.createTank(tank3);
               tankService.createTank(tank4);
               
               System.out.println("Created sample tanks");
           }
       }

       private void initializeSampleAreas() {
           try {
               if (areaService.getAllAreas().isEmpty()) {
                   // Get tank IDs for reference
                   var tanks = tankService.getAllTanks();
                   
                   // Check if we have enough tanks
                   if (tanks.size() < 3) {
                       System.out.println("Not enough tanks to create sample areas. Found: " + tanks.size());
                       return;
                   }
               
               String tank1Id = tanks.get(0).getId();
               String tank2Id = tanks.get(1).getId();
               String tank3Id = tanks.get(2).getId();
               
               // Create sample areas
               Area area1 = new Area();
               area1.setName("Sector 8");
               area1.setZone("North Zone");
               area1.setPopulation(15000);
               area1.setWaterDemand(12000); // L/day
               area1.setPrimaryTankId(tank1Id);
               area1.setBackupTankId(tank2Id);
               area1.setStatus("SERVED");
               
               Area area2 = new Area();
               area2.setName("Sector 4");
               area2.setZone("Central Zone");
               area2.setPopulation(12500);
               area2.setWaterDemand(10000); // L/day
               area2.setPrimaryTankId(tank2Id);
               area2.setBackupTankId(tank1Id);
               area2.setStatus("LOW_SUPPLY");
               
               Area area3 = new Area();
               area3.setName("Sector 12");
               area3.setZone("South Zone");
               area3.setPopulation(22000);
               area3.setWaterDemand(18000); // L/day
               area3.setPrimaryTankId(tank3Id);
               area3.setBackupTankId(tank1Id);
               area3.setStatus("CRITICAL");
               
               areaService.createArea(area1);
               areaService.createArea(area2);
               areaService.createArea(area3);
               
               System.out.println("Created sample areas");
               }
           } catch (Exception e) {
               System.err.println("Error initializing sample areas: " + e.getMessage());
               e.printStackTrace();
           }
       }

       private void initializeSampleSchedules() {
           try {
               if (scheduleService.getAllSchedules().isEmpty()) {
                   // Get area and tank IDs for reference
                   var areas = areaService.getAllAreas();
                   var tanks = tankService.getAllTanks();
                   
                   // Check if we have enough areas and tanks
                   if (areas.size() < 3 || tanks.size() < 3) {
                       System.out.println("Not enough areas or tanks to create sample schedules. Areas: " + areas.size() + ", Tanks: " + tanks.size());
                       return;
                   }
               
               String area1Id = areas.get(0).getId();
               String area2Id = areas.get(1).getId();
               String area3Id = areas.get(2).getId();
               String tank1Id = tanks.get(0).getId();
               String tank2Id = tanks.get(1).getId();
               String tank3Id = tanks.get(2).getId();
               
               // Create sample schedules
               SupplySchedule schedule1 = new SupplySchedule();
               schedule1.setAreaId(area1Id);
               schedule1.setTankId(tank1Id);
               schedule1.setStartTime(new Date(System.currentTimeMillis() + 3600000)); // 1 hour from now
               schedule1.setEndTime(new Date(System.currentTimeMillis() + 7200000)); // 3 hours from now
               schedule1.setWaterAmount(5000);
               schedule1.setFrequency("DAILY");
               schedule1.setActive(true);
               
               SupplySchedule schedule2 = new SupplySchedule();
               schedule2.setAreaId(area2Id);
               schedule2.setTankId(tank2Id);
               schedule2.setStartTime(new Date(System.currentTimeMillis() + 5400000)); // 1.5 hours from now
               schedule2.setEndTime(new Date(System.currentTimeMillis() + 9000000)); // 3.5 hours from now
               schedule2.setWaterAmount(3000);
               schedule2.setFrequency("DAILY");
               schedule2.setActive(true);
               
               SupplySchedule schedule3 = new SupplySchedule();
               schedule3.setAreaId(area3Id);
               schedule3.setTankId(tank3Id);
               schedule3.setStartTime(new Date(System.currentTimeMillis() + 7200000)); // 2 hours from now
               schedule3.setEndTime(new Date(System.currentTimeMillis() + 10800000)); // 4 hours from now
               schedule3.setWaterAmount(4000);
               schedule3.setFrequency("DAILY");
               schedule3.setActive(false); // Inactive due to low water levels
               
               scheduleService.createSchedule(schedule1);
               scheduleService.createSchedule(schedule2);
               scheduleService.createSchedule(schedule3);
               
               System.out.println("Created sample schedules");
               }
           } catch (Exception e) {
               System.err.println("Error initializing sample schedules: " + e.getMessage());
               e.printStackTrace();
           }
       }
   }


