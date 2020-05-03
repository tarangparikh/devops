FROM openjdk:8-jdk-slim
ARG JAR_FILE=target/calculator.war
ARG WEB_RUNNER=target/dependency/webapp-runner.jar
COPY ${JAR_FILE} application.war
COPY ${WEB_RUNNER} runner.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/runner.jar","/application.war"]