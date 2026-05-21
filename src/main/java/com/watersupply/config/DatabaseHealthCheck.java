package com.watersupply.config;

import com.watersupply.model.Issue;
import com.watersupply.model.User;
import com.watersupply.repository.IssueRepository;
import com.watersupply.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class DatabaseHealthCheck implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private IssueRepository issueRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) throws Exception {
        System.out.println("=== Database Health Check ===");
        
        try {
            // Check if MongoDB is accessible
            long userCount = userRepository.count();
            System.out.println("✅ MongoDB connection successful. Users in database: " + userCount);
            
            // Create default admin user if none exists
            if (userCount == 0) {
                createDefaultUsers();
            }
            
            // Create sample issues if none exist
            long issueCount = issueRepository.count();
            if (issueCount == 0) {
                createSampleIssues();
            }
            
            System.out.println("✅ Database initialization completed successfully");
            
        } catch (Exception e) {
            System.err.println("❌ MongoDB connection failed: " + e.getMessage());
            System.err.println("Please ensure MongoDB is running on localhost:27017");
            System.err.println("You can install MongoDB from: https://www.mongodb.com/try/download/community");
        }
        
        System.out.println("=== End Database Health Check ===");
    }
    
    private void createDefaultUsers() {
        System.out.println("Creating default users...");
        
        // Create admin user
        User admin = new User();
        admin.setUsername("admin");
        admin.setPassword(passwordEncoder.encode("admin123"));
        admin.setEmail("admin@aquaflow.com");
        admin.setRole("ADMIN");
        admin.setEnabled(true);
        userRepository.save(admin);
        
        // Create regular user
        User user = new User();
        user.setUsername("user");
        user.setPassword(passwordEncoder.encode("user123"));
        user.setEmail("user@aquaflow.com");
        user.setRole("USER");
        user.setEnabled(true);
        userRepository.save(user);
        
        System.out.println("✅ Default users created successfully");
    }
    
    private void createSampleIssues() {
        System.out.println("Creating sample issues...");
        
        // Sample issue 1
        Issue issue1 = new Issue();
        issue1.setUserId("user_id_1");
        issue1.setUsername("John Doe");
        issue1.setUserEmail("john.doe@example.com");
        issue1.setIssueType("WATER_QUALITY");
        issue1.setTitle("Water has unusual taste");
        issue1.setDescription("The water from my tap has a strange metallic taste. This started about 2 days ago.");
        issue1.setLocation("Sector 5, Block A");
        issue1.setPriority("MEDIUM");
        issue1.setStatus("OPEN");
        issue1.setContactPhone("+1-555-0123");
        issue1.setCreatedAt(new Date());
        issue1.setUpdatedAt(new Date());
        issueRepository.save(issue1);
        
        // Sample issue 2
        Issue issue2 = new Issue();
        issue2.setUserId("user_id_2");
        issue2.setUsername("Jane Smith");
        issue2.setUserEmail("jane.smith@example.com");
        issue2.setIssueType("WATER_PRESSURE");
        issue2.setTitle("Low water pressure in morning");
        issue2.setDescription("Water pressure is very low between 7-9 AM every day. Makes it difficult to shower.");
        issue2.setLocation("Sector 3, Block C");
        issue2.setPriority("HIGH");
        issue2.setStatus("IN_PROGRESS");
        issue2.setContactPhone("+1-555-0456");
        issue2.setAssignedTo("admin");
        issue2.setCreatedAt(new Date());
        issue2.setUpdatedAt(new Date());
        issueRepository.save(issue2);
        
        // Sample issue 3
        Issue issue3 = new Issue();
        issue3.setUserId("user_id_3");
        issue3.setUsername("Bob Johnson");
        issue3.setUserEmail("bob.johnson@example.com");
        issue3.setIssueType("LEAKAGE");
        issue3.setTitle("Water leak in building basement");
        issue3.setDescription("There's a significant water leak in the basement of Building 12. Water is pooling and could cause damage.");
        issue3.setLocation("Sector 7, Building 12");
        issue3.setPriority("HIGH");
        issue3.setStatus("RESOLVED");
        issue3.setContactPhone("+1-555-0789");
        issue3.setAssignedTo("admin");
        issue3.setResolution("Leak was caused by a broken pipe. Pipe has been replaced and leak is fixed.");
        issue3.setCreatedAt(new Date());
        issue3.setUpdatedAt(new Date());
        issue3.setResolvedAt(new Date());
        issueRepository.save(issue3);
        
        System.out.println("✅ Sample issues created successfully");
    }
}