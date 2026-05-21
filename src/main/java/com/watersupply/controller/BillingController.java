package com.watersupply.controller;

import com.watersupply.model.Bill;
import com.watersupply.model.User;
import com.watersupply.service.BillingService;
import com.watersupply.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/billing")
public class BillingController {

    @Autowired
    private BillingService billingService;

    @Autowired
    private UserService userService;

    // @GetMapping
    // public String billingPage(Model model) {
    //     List<Bill> bills = billingService.getAllBills();
    //     List<User> users = userService.getAllUsers();
    //     model.addAttribute("bills", bills);
    //     model.addAttribute("users", users);
    //     return "admin/billing";
    // }

    @PostMapping("/generate/{userId}")
    @ResponseBody
    public Map<String, Object> generateBill(@PathVariable String userId) {
        billingService.generateBillForUser(userId);
        return Map.of("message", "Bill generated for user!");
    }

    @PostMapping("/generate-all")
    @ResponseBody
    public Map<String, Object> generateAllBills() {
        billingService.generateBillsForAllUsers();
        return Map.of("message", "Bills generated for all users!");
    }
}