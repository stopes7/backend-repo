FROM maven:3.9.6-eclipse-temurin-8 AS build
WORKDIR /app


COPY pom.xml ./
COPY src ./src


RUN mvn clean package -DskipTests


FROM eclipse-temurin:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar


ENV SERVER_PORT=8081
EXPOSE 8081


ENTRYPOINT ["java", "-jar", "app.jar"]
