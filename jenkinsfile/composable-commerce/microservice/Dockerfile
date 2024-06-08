FROM openjdk:8-jdk-alpine
ADD . /micro-price
WORKDIR /micro-price
RUN chmod +x ./mvnw

EXPOSE 8082:8082
ENTRYPOINT ./mvnw spring-boot:run 