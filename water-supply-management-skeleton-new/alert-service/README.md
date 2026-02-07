# Alert Service Microservice

This project is a microservice for managing alerts in a water supply management system. It is built using Spring Boot and follows a standard Java project structure.

## Project Structure

```
alert-service
├── src
│   ├── main
│   │   ├── java
│   │   │   └── com
│   │   │       └── watersupply
│   │   │           └── alertservice
│   │   │               ├── AlertServiceApplication.java
│   │   │               └── controller
│   │   │                   └── AlertController.java
│   │   └── resources
│   │       ├── application.properties
│   │       └── static
│   │       └── templates
│   └── test
│       └── java
│           └── com
│               └── watersupply
│                   └── alertservice
│                       └── AlertServiceApplicationTests.java
├── pom.xml
└── README.md
```

## Setup Instructions

1. **Clone the repository:**
   ```
   git clone <repository-url>
   cd alert-service
   ```

2. **Build the project:**
   ```
   mvn clean install
   ```

3. **Run the application:**
   ```
   mvn spring-boot:run
   ```

4. **Access the alerts endpoint:**
   Open your browser or use a tool like Postman to access:
   ```
   http://localhost:8080/alerts/list
   ```

## Usage

The Alert Service provides an endpoint to retrieve a list of alerts. The alerts are returned in JSON format and include details such as ID, type, message, timestamp, and severity.

## Dependencies

This project uses Maven for dependency management. The `pom.xml` file contains all necessary dependencies for the Spring Boot application.

## Testing

Unit tests are provided in the `src/test/java` directory. You can run the tests using:
```
mvn test
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.