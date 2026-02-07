package com.watersupply.controller;

import com.watersupply.dto.LoginRequest;
import com.watersupply.dto.SignupRequest;
import com.watersupply.model.User;
import com.watersupply.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    // ✅ Show single login page
    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("loginRequest", new LoginRequest());
        return "auth/login";
    }

    // API login moved to ApiAuthController (REST)

    // ✅ Signup page
    @GetMapping("/signup")
    public String showSignupForm(Model model) {
        model.addAttribute("signupRequest", new SignupRequest());
        return "auth/signup";
    }

    // ✅ Handle signup
    @PostMapping("/signup")
    public String signup(@Valid @ModelAttribute SignupRequest signupRequest,
                         BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "auth/signup";
        }

        if (userService.usernameExists(signupRequest.getUsername())) {
            model.addAttribute("error", "Username already exists");
            return "auth/signup";
        }

        if (userService.emailExists(signupRequest.getEmail())) {
            model.addAttribute("error", "Email already exists");
            return "auth/signup";
        }

        User user = new User(
                signupRequest.getUsername(),
                signupRequest.getPassword(),
                signupRequest.getEmail(),
                signupRequest.getRole()
        );

        userService.createUser(user);
        model.addAttribute("success", "Registration successful! Please login.");
        return "redirect:/auth/login";
    }

    // ✅ Redirect after login based on role
    @GetMapping("/default")
    public String defaultAfterLogin() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        if (auth.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            return "redirect:/admin/dashboard";
        }

        if (auth.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_USER"))) {
            return "redirect:/user/dashboard";
        }

        return "redirect:/auth/access-denied";
    }

    @GetMapping("/access-denied")
    public String accessDenied() {
        return "auth/access-denied";
    }
}
