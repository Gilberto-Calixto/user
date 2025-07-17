# Stage1: build for gradle

FROM gradle:8.2.1-jdk17 AS build

WORKDIR /app

COPY . .

RUN ./gradlew clean shadowJar --no-daemon

# Stage2: Runtime

FROM amazoncorretto:21

WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]