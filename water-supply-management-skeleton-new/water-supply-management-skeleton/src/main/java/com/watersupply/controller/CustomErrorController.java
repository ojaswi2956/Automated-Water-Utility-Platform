package com.watersupply.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Controller
public class CustomErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        // Get error attributes
        Object status = request.getAttribute("javax.servlet.error.status_code");
        Object message = request.getAttribute("javax.servlet.error.message");
        Object requestUri = request.getAttribute("javax.servlet.error.request_uri");
        
        model.addAttribute("status", status);
        model.addAttribute("message", message);
        model.addAttribute("path", requestUri);
        model.addAttribute("timestamp", new Date());
        
        // Log the error
        System.err.println("=== Error Page Accessed ===");
        System.err.println("Status: " + status);
        System.err.println("Message: " + message);
        System.err.println("Path: " + requestUri);
        System.err.println("========================");
        
        return "error";
    }
}