package com.watersupply.service;

import com.watersupply.model.Issue;
import com.watersupply.repository.IssueRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class IssueService {
    @Autowired
    private IssueRepository issueRepository;

    public List<Issue> getAllIssues() {
        try {
            return issueRepository.findAllByOrderByCreatedAtDesc();
        } catch (Exception e) {
            System.err.println("Error getting all issues: " + e.getMessage());
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }

    public List<Issue> getIssuesByUser(String userId) {
        try {
            return issueRepository.findByUserId(userId);
        } catch (Exception e) {
            System.err.println("Error getting issues by user: " + e.getMessage());
            return new java.util.ArrayList<>();
        }
    }

    public List<Issue> getIssuesByStatus(String status) {
        try {
            return issueRepository.findByStatusOrderByCreatedAtDesc(status);
        } catch (Exception e) {
            System.err.println("Error getting issues by status: " + e.getMessage());
            return new java.util.ArrayList<>();
        }
    }

    public List<Issue> getIssuesByPriority(String priority) {
        try {
            return issueRepository.findByPriority(priority);
        } catch (Exception e) {
            System.err.println("Error getting issues by priority: " + e.getMessage());
            return new java.util.ArrayList<>();
        }
    }

    public List<Issue> getIssuesByType(String issueType) {
        try {
            return issueRepository.findByIssueType(issueType);
        } catch (Exception e) {
            System.err.println("Error getting issues by type: " + e.getMessage());
            return new java.util.ArrayList<>();
        }
    }

    public List<Issue> getIssuesByAssignedTo(String assignedTo) {
        try {
            return issueRepository.findByAssignedTo(assignedTo);
        } catch (Exception e) {
            System.err.println("Error getting issues by assigned to: " + e.getMessage());
            return new java.util.ArrayList<>();
        }
    }

    public Optional<Issue> getIssueById(String id) {
        try {
            return issueRepository.findById(id);
        } catch (Exception e) {
            System.err.println("Error getting issue by id: " + e.getMessage());
            return Optional.empty();
        }
    }

    public Issue createIssue(Issue issue) {
        try {
            return issueRepository.save(issue);
        } catch (Exception e) {
            System.err.println("Error creating issue: " + e.getMessage());
            throw new RuntimeException("Failed to create issue: " + e.getMessage());
        }
    }

    public Issue updateIssue(String id, Issue issueDetails) {
        try {
            Optional<Issue> optionalIssue = issueRepository.findById(id);
            if (optionalIssue.isPresent()) {
                Issue issue = optionalIssue.get();
                issue.setTitle(issueDetails.getTitle());
                issue.setDescription(issueDetails.getDescription());
                issue.setLocation(issueDetails.getLocation());
                issue.setPriority(issueDetails.getPriority());
                issue.setStatus(issueDetails.getStatus());
                issue.setAssignedTo(issueDetails.getAssignedTo());
                issue.setResolution(issueDetails.getResolution());
                issue.setContactPhone(issueDetails.getContactPhone());
                issue.setUpdatedAt(new java.util.Date());
                
                if ("RESOLVED".equals(issueDetails.getStatus()) && issue.getResolvedAt() == null) {
                    issue.setResolvedAt(new java.util.Date());
                }
                
                return issueRepository.save(issue);
            }
            return null;
        } catch (Exception e) {
            System.err.println("Error updating issue: " + e.getMessage());
            throw new RuntimeException("Failed to update issue: " + e.getMessage());
        }
    }

    public boolean deleteIssue(String id) {
        try {
            if (issueRepository.existsById(id)) {
                issueRepository.deleteById(id);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("Error deleting issue: " + e.getMessage());
            return false;
        }
    }

    public long getTotalIssues() {
        try {
            return issueRepository.count();
        } catch (Exception e) {
            System.err.println("Error getting total issues count: " + e.getMessage());
            return 0;
        }
    }

    public long getOpenIssues() {
        try {
            return issueRepository.findByStatus("OPEN").size();
        } catch (Exception e) {
            System.err.println("Error getting open issues count: " + e.getMessage());
            return 0;
        }
    }

    public long getInProgressIssues() {
        try {
            return issueRepository.findByStatus("IN_PROGRESS").size();
        } catch (Exception e) {
            System.err.println("Error getting in-progress issues count: " + e.getMessage());
            return 0;
        }
    }

    public long getResolvedIssues() {
        try {
            return issueRepository.findByStatus("RESOLVED").size();
        } catch (Exception e) {
            System.err.println("Error getting resolved issues count: " + e.getMessage());
            return 0;
        }
    }
}