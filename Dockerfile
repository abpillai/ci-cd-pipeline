# Build stage
FROM openjdk:8-jre-alpine AS builder

WORKDIR /app
COPY pom.xml ./
COPY sonar-project.properties ./
COPY src ./src

# Install Maven
RUN apk --no-cache add maven

# Build the application
RUN mvn package -e

# Final stage
FROM openjdk:8-jre-alpine

ARG PROFILE
ENV PROFILE=$PROFILE

WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/*.jar ./metadata-service.jar

EXPOSE 8080
ENTRYPOINT ["java", "-Dspring.profiles.active=${PROFILE}", "-jar", "./metadata-service.jar"]
