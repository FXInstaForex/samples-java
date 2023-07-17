#FROM ubuntu:22.04
FROM gradle:latest AS BUILD
WORKDIR Basic/cordapp-example
RUN gradle init
RUN ./gradlew clean deployNodes

FROM openjdk:8-jre-alpine3.9
# copy only the artifacts we need from the first stage and discard the rest
COPY --from=MAVEN_BUILD /docker-multi-stage-build-demo/target/demo-0.0.1-SNAPSHOT.jar /demo.jar
# set the startup command to execute the jar
CMD ["java", "-jar", "/corda.jar"]



FROM gradle:4.2.1-jdk8-alpine
WORKDIR /app
COPY --from=0 /app/myProject /app

USER root                # This changes default user to root
RUN chown -R gradle /app # This changes ownership of folder
USER gradle              # This changes the user back to the default user "gradle"

RUN ./gradlew build --stacktrace