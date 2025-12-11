FROM openjdk:17-jre-slim
WORKDIR /app
COPY target/*.jar .
EXPOSE 8080
ENTRYPOINT ["java","-jar","*.jar"]
