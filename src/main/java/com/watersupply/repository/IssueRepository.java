package com.watersupply.repository;

import com.watersupply.model.Issue;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface IssueRepository extends MongoRepository<Issue, String> {
    List<Issue> findByUserId(String userId);
    List<Issue> findByStatus(String status);
    List<Issue> findByPriority(String priority);
    List<Issue> findByIssueType(String issueType);
    List<Issue> findByAssignedTo(String assignedTo);
    List<Issue> findByStatusOrderByCreatedAtDesc(String status);
    List<Issue> findAllByOrderByCreatedAtDesc();
}

