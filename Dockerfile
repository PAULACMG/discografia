FROM gradle:jdk21 as builder

WORKDIR /app

COPY ./build.gradle .
COPY ./setting.gradle .

COPY src ./src

RUN gradle build --no-daemon


FROM openjdk:21-jdk-slim

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar discografia-1.jar

EXPOSE 443

CMD [ "java", "-jar", "discografia-1.jar" ]
