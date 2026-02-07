package com.watersupply.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;

@Configuration
@EnableMongoRepositories(basePackages = "com.watersupply.repository")
public class MongoConfig {
    // MongoDB configuration is handled by Spring Boot auto-configuration
    // Additional custom configuration can be added here if needed
}