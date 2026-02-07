package com.watersupply.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class IssueTestController {
    
    @GetMapping("/issues")
    public String testIssues(Model model) {
        model.addAttribute("message", "Test controller is working!");
        model.addAttribute("issues", new java.util.ArrayList<>());
        model.addAttribute("admins", new java.util.ArrayList<>());
        model.addAttribute("totalIssues", 0);
        model.addAttribute("openIssues", 0);
        model.addAttribute("inProgressIssues", 0);
        model.addAttribute("resolvedIssues", 0);
        return "admin/issues";
    }
}