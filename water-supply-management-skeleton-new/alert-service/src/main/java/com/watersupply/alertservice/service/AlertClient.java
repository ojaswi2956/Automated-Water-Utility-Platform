package com.watersupply.alertservice.service;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.util.List;
import java.util.Map;

@Service
public class AlertClient {
    private final RestTemplate restTemplate = new RestTemplate();
    private final String alertServiceUrl = "http://localhost:8081/alerts/list"; // adjust port as needed

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> fetchAlerts() {
        return restTemplate.getForObject(alertServiceUrl, List.class);
    }
}