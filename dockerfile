#FROM ubuntu:22.04
FROM gradle:latest AS BUILD
WORKDIR /samples-java/Basic/cordapp-example
COPY . .
RUN gradle init
RUN ./gradlew clean deployNodes

