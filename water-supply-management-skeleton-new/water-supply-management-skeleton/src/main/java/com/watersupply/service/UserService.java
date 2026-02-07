package com.watersupply.service;

import com.watersupply.model.User;
import com.watersupply.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;


@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    public List<User> getAllUsers() {
        try {
            return userRepository.findAll();
        } catch (Exception e) {
            System.err.println("Error getting all users: " + e.getMessage());
            return new java.util.ArrayList<>();
        }
    }

    public Optional<User> getUserById(String id) {
        try {
            return userRepository.findById(id);
        } catch (Exception e) {
            System.err.println("Error getting user by id: " + e.getMessage());
            return Optional.empty();
        }
    }

    public Optional<User> getUserByUsername(String username) {
        try {
            return userRepository.findByUsername(username);
        } catch (Exception e) {
            System.err.println("Error getting user by username: " + e.getMessage());
            return Optional.empty();
        }
    }

    public User createUser(User user) {
        try {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            return userRepository.save(user);
        } catch (Exception e) {
            System.err.println("Error creating user: " + e.getMessage());
            throw new RuntimeException("Failed to create user: " + e.getMessage());
        }
    }

    public User updateUser(String id, User userDetails) {
        try {
            Optional<User> optionalUser = userRepository.findById(id);
            if (optionalUser.isPresent()) {
                User user = optionalUser.get();
                user.setUsername(userDetails.getUsername());
                user.setEmail(userDetails.getEmail());
                user.setRole(userDetails.getRole());
                if (userDetails.getPassword() != null && !userDetails.getPassword().isEmpty()) {
                    user.setPassword(passwordEncoder.encode(userDetails.getPassword()));
                }
                return userRepository.save(user);
            }
            return null;
        } catch (Exception e) {
            System.err.println("Error updating user: " + e.getMessage());
            throw new RuntimeException("Failed to update user: " + e.getMessage());
        }
    }

    public boolean deleteUser(String id) {
        try {
            if (userRepository.existsById(id)) {
                userRepository.deleteById(id);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("Error deleting user: " + e.getMessage());
            return false;
        }
    }

    public boolean usernameExists(String username) {
        try {
            return userRepository.existsByUsername(username);
        } catch (Exception e) {
            System.err.println("Error checking username existence: " + e.getMessage());
            return false;
        }
    }

    public boolean emailExists(String email) {
        try {
            return userRepository.existsByEmail(email);
        } catch (Exception e) {
            System.err.println("Error checking email existence: " + e.getMessage());
            return false;
        }
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        try {
            Optional<User> user = userRepository.findByUsername(username);
            if (user.isPresent()) {
                return user.get();
            } else {
                throw new UsernameNotFoundException("User not found: " + username);
            }
        } catch (Exception e) {
            System.err.println("Error loading user by username: " + e.getMessage());
            throw new UsernameNotFoundException("Database error: " + e.getMessage());
        }
    }
}