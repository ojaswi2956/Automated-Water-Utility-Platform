// package com.watersupply.service;

// import com.watersupply.model.Tank;
// import com.watersupply.model.Area;
// import com.watersupply.model.WaterLog;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.mail.SimpleMailMessage;
// import org.springframework.mail.javamail.JavaMailSender;
// import org.springframework.scheduling.annotation.Scheduled;
// import org.springframework.stereotype.Service;
// import java.util.Date;
// import java.util.List;

// @Service
// public class AlertService {
//     @Autowired
//     private TankService tankService;
    
//     @Autowired
//     private AreaService areaService;
    
//     @Autowired
//     private WaterLogService waterLogService;
    
//     @Autowired
//     private JavaMailSender mailSender;
    
//     private static final double LOW_WATER_THRESHOLD = 0.2; // 20% capacity
//     private static final double CRITICAL_WATER_THRESHOLD = 0.1; // 10% capacity
    
//     @Scheduled(fixedRate = 300000) // Check every 5 minutes
//     public void checkWaterLevels() {
//         List<Tank> tanks = tankService.getAllTanks();
        
//         for (Tank tank : tanks) {
//             double percentage = tank.getCurrentLevel() / tank.getCapacity();
            
//             if (percentage <= CRITICAL_WATER_THRESHOLD) {
//                 sendCriticalAlert(tank);
//             } else if (percentage <= LOW_WATER_THRESHOLD) {
//                 sendLowWaterAlert(tank);
//             }
//         }
//     }
    
//     private void sendCriticalAlert(Tank tank) {
//         // Log the critical alert
//         WaterLog log = new WaterLog();
//         log.setTankId(tank.getId());
//         log.setLogType("ALERT");
//         log.setStatus("CRITICAL");
//         log.setNotes("Critical water level: " + String.format("%.1f", tank.getPercentage()) + "%");
//         waterLogService.createLog(log);
        
//         // Send email alert (if configured)
//         sendEmailAlert("CRITICAL: Tank " + tank.getName() + " water level is critically low!", 
//                       "Tank " + tank.getName() + " at " + tank.getLocation() + 
//                       " has only " + String.format("%.1f", tank.getPercentage()) + "% water remaining.");
//     }
    
//     private void sendLowWaterAlert(Tank tank) {
//         // Log the low water alert
//         WaterLog log = new WaterLog();
//         log.setTankId(tank.getId());
//         log.setLogType("ALERT");
//         log.setStatus("WARNING");
//         log.setNotes("Low water level: " + String.format("%.1f", tank.getPercentage()) + "%");
//         waterLogService.createLog(log);
        
//         // Send email alert (if configured)
//         sendEmailAlert("WARNING: Tank " + tank.getName() + " water level is low!", 
//                       "Tank " + tank.getName() + " at " + tank.getLocation() + 
//                       " has " + String.format("%.1f", tank.getPercentage()) + "% water remaining.");
//     }
    
//     private void sendEmailAlert(String subject, String message) {
//         try {
//             SimpleMailMessage mailMessage = new SimpleMailMessage();
//             mailMessage.setTo("admin@watersupply.com"); // Configure this in application.properties
//             mailMessage.setSubject(subject);
//             mailMessage.setText(message);
//             mailSender.send(mailMessage);
//         } catch (Exception e) {
//             // Log error but don't fail the application
//             System.err.println("Failed to send email alert: " + e.getMessage());
//         }
//     }
// }