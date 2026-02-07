package com.watersupply.alertservice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.watersupply.alertservice.service.EmailService;

@Controller
@RequestMapping("/alerts")
public class AlertWebController {

    @Autowired
    private EmailService emailService;

    @GetMapping("/shortage-alert")
    public String shortageAlertPage() {
        return "shortage-alert";
    }

    @PostMapping("/send-shortage-alert")
    public String sendShortageAlert(
            @RequestParam("email") String email,
            @RequestParam("date") String date,
            Model model) {
        
        boolean emailSent = emailService.sendShortageAlert(email, date);
        
        if (emailSent) {
            model.addAttribute("message", "✅ Shortage alert successfully sent to " + email + " for " + date + "!");
            model.addAttribute("messageType", "success");
        } else {
            model.addAttribute("message", "❌ Failed to send shortage alert to " + email + ". Please check email configuration.");
            model.addAttribute("messageType", "error");
        }
        
        return "shortage-alert";
    }
}