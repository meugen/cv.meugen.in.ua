FROM sapmachine:21-jdk-ubuntu as build
WORKDIR /app
COPY .mvn .mvn/
COPY src src/
COPY mvnw pom.xml docker-compose.yml ./
RUN ./mvnw package

FROM sapmachine:21-jre-ubuntu
WORKDIR /app
COPY --from=build /app/target/cv-0.0.1-SNAPSHOT.jar cv-0.0.1-SNAPSHOT.jar
ENTRYPOINT java -jar cv-0.0.1-SNAPSHOT.jar
