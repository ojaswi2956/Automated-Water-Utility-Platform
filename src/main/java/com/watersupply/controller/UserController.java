package com.watersupply.controller;

import com.watersupply.model.Bill;
import com.watersupply.model.Issue;
import com.watersupply.model.User;
import com.watersupply.service.BillingService;
import com.watersupply.service.IssueService;
import com.watersupply.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import java.util.*;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private IssueService issueService;

    @Autowired
    private UserService userService;

    @Autowired
    private BillingService billingService;

    @GetMapping("/dashboard")
public String dashboard(Model model) {
    Authentication auth = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication();
    User currentUser = (User) auth.getPrincipal();

    // Get user's recent issues
    List<Issue> userIssues = issueService.getIssuesByUser(currentUser.getId());
    model.addAttribute("recentIssues", userIssues.subList(0, Math.min(3, userIssues.size())));

    // Fetch bills and find latest unpaid or latest bill
    List<Bill> bills = billingService.getBillsByUserId(currentUser.getId());
    bills.sort(Comparator.comparing(Bill::getDueDate).reversed());
    Bill dashboardBill = bills.stream()
        .filter(b -> !b.isPaid())
        .findFirst()
        .orElse(bills.isEmpty() ? null : bills.get(0));
    model.addAttribute("dashboardBill", dashboardBill);

    return "user/dashboard";
}

    // Updated: Only one /bills endpoint, sets currentBill and billingHistory for JSP
    @GetMapping("/bills")
    public String userBills(Model model, Authentication authentication) {
        User currentUser = (User) authentication.getPrincipal();
        List<Bill> bills = billingService.getBillsByUserId(currentUser.getId());
        bills.sort(Comparator.comparing(Bill::getDueDate).reversed());

        // Find current unpaid bill or latest bill
        Bill currentBill = bills.stream()
            .filter(b -> !b.isPaid())
            .findFirst()
            .orElse(bills.isEmpty() ? null : bills.get(0));

        model.addAttribute("currentBill", currentBill);
        model.addAttribute("billingHistory", bills);
        return "user/bills";
    }

    @GetMapping("/report")
    public String report(Model model) {
        Authentication auth = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication();
        User currentUser = (User) auth.getPrincipal();

        // Get user's issues
        List<Issue> userIssues = issueService.getIssuesByUser(currentUser.getId());
        model.addAttribute("userIssues", userIssues);

        return "user/report";
    }

    @PostMapping("/report/submit")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> submitIssue(@RequestBody Map<String, String> issueData) {
        Map<String, Object> response = new HashMap<>();

        try {
            Authentication auth = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication();
            User currentUser = (User) auth.getPrincipal();

            Issue issue = new Issue();
            issue.setUserId(currentUser.getId());
            issue.setUsername(currentUser.getUsername());
            issue.setUserEmail(currentUser.getEmail());
            issue.setIssueType(issueData.get("issueType"));
            issue.setTitle(issueData.get("title"));
            issue.setDescription(issueData.get("description"));
            issue.setLocation(issueData.get("location"));
            issue.setPriority(issueData.get("priority"));
            issue.setContactPhone(issueData.get("contactPhone"));

            Issue savedIssue = issueService.createIssue(issue);

            response.put("success", true);
            response.put("message", "Issue reported successfully!");
            response.put("issueId", savedIssue.getIssueId());

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error reporting issue: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    @GetMapping("/issues")
    @ResponseBody
    public ResponseEntity<List<Issue>> getUserIssues() {
        try {
            Authentication auth = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication();
            Object principal = auth.getPrincipal();
            if (!(principal instanceof User)) {
                System.err.println("Principal is not of type User: " + principal.getClass().getName());
                return ResponseEntity.status(500).body(null);
            }
            User currentUser = (User) principal;
            List<Issue> userIssues = issueService.getIssuesByUser(currentUser.getId());
            return ResponseEntity.ok(userIssues);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(null);
        }
    }
}