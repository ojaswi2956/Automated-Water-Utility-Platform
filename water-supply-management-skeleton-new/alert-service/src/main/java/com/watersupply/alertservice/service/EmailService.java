package com.watersupply.alertservice.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    
    @Autowired(required = false)
    private JavaMailSender mailSender;
    
    @Value("${spring.mail.username:test@example.com}")
    private String fromEmail;
    
    public boolean sendShortageAlert(String recipientEmail, String shortageDate) {
        try {
            // If mailSender is not configured, simulate sending for testing
            if (mailSender == null) {
                System.out.println("=== EMAIL SIMULATION (No SMTP configured) ===");
                System.out.println("To: " + recipientEmail);
                System.out.println("Subject: 🚨 Water Shortage Alert - AquaFlow System");
                System.out.println("Content: " + buildShortageAlertMessage(shortageDate));
                System.out.println("=== END EMAIL SIMULATION ===");
                return true;
            }
            
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(recipientEmail);
            message.setSubject("🚨 Water Shortage Alert - AquaFlow System");
            message.setText(buildShortageAlertMessage(shortageDate));
            message.setFrom(fromEmail);
            
            mailSender.send(message);
            System.out.println("Email successfully sent to: " + recipientEmail);
            return true;
        } catch (Exception e) {
            System.err.println("Failed to send shortage alert email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    private String buildShortageAlertMessage(String shortageDate) {
        return String.format("""
            Dear Valued Customer,
            
            This is an automated alert from the AquaFlow Water Supply Management System.
            
            🚨 WATER SHORTAGE NOTICE 🚨
            
            We are writing to inform you about an upcoming water shortage scheduled for: %s
            
            IMPORTANT INFORMATION:
            • Please conserve water usage during this period
            • Store water in advance if possible
            • Contact our support team if you have urgent water needs
            • Regular updates will be provided as the situation develops
            
            We apologize for any inconvenience and appreciate your understanding.
            
            For more information or assistance, please contact:
            📞 Support Hotline: +1-800-AQUAFLOW
            📧 Email: support@aquaflow.com
            🌐 Website: www.aquaflow.com
            
            Thank you for your cooperation.
            
            Best regards,
            AquaFlow Water Supply Management Team
            """, shortageDate);
    }
}