package com.watersupply.service;

import com.watersupply.model.Bill;
import com.watersupply.model.User;
import com.watersupply.repository.BillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.*;
import java.time.format.TextStyle;

@Service
public class BillingService {

    @Autowired
    private BillRepository billRepository;

    @Autowired
    private UserService userService;

    public List<Bill> getAllBills() {
        return billRepository.findAll();
    }

    public List<Bill> getBillsByUserId(String userId) {
        return billRepository.findByUserId(userId);
    }

    public void generateBillForUser(String userId) {
        Optional<User> userOpt = userService.getUserById(userId);
        if (userOpt.isEmpty()) return;
        User user = userOpt.get();

        Bill bill = new Bill();
        bill.setBillId(UUID.randomUUID().toString());
        bill.setUserId(user.getId());
        bill.setUsername(user.getUsername());
        bill.setEmail(user.getEmail());
        bill.setConsumption(1000 + new Random().nextInt(2000)); // Example
        bill.setAmount(bill.getConsumption() * 0.05); // Example rate
        bill.setPaid(false);
        bill.setDueDate(LocalDate.now().plusDays(15));

        String period = LocalDate.now().getMonth().getDisplayName(TextStyle.FULL, Locale.ENGLISH) + " " + LocalDate.now().getYear();
        bill.setPeriod(period);
        billRepository.save(bill);
    }

    public void generateBillsForAllUsers() {
        List<User> users = userService.getAllUsers();
        for (User user : users) {
            generateBillForUser(user.getId());
        }
    }
}