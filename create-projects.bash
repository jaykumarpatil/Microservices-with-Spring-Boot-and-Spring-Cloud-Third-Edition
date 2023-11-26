#!/usr/bin/env bash

spring init \
--boot-version=3.2.1-SNAPSHOT \
--type=gradle-project \
--java-version=21 \
--packaging=jar \
--name=api \
--package-name=com.example.api \
--groupId=com.example.api \
--dependencies=webflux \
--version=1.0.0-SNAPSHOT \
api

rm -r ./api/gradle
rm ./api/HELP.md
rm ./api/gradlew
rm ./api/gradlew.bat

spring init \
--boot-version=3.2.1-SNAPSHOT \
--type=gradle-project \
--java-version=21 \
--packaging=jar \
--name=util \
--package-name=com.example.util \
--groupId=com.example.util \
--dependencies=webflux \
--version=1.0.0-SNAPSHOT \
util

rm ./util/gradle
rm ./util/HELP.md
rm ./util/gradlew
rm ./util/gradlew.bat

mkdir microservices
# shellcheck disable=SC2164
cd microservices

spring init \
--boot-version=3.2.1-SNAPSHOT \
--type=gradle-project \
--java-version=21 \
--packaging=jar \
--name=product-service \
--package-name=com.example.microservices.core.product \
--groupId=com.example.microservices.core.product \
--dependencies=actuator,webflux \
--version=1.0.0-SNAPSHOT \
product-service

rm -r ./microservices/product-composite-service/gradle
rm ./microservices/product-composite-service/HELP.md
rm ./microservices/product-composite-service/gradlew
rm ./microservices/product-composite-service/gradlew.bat

spring init \
--boot-version=3.2.1-SNAPSHOT \
--type=gradle-project \
--java-version=21 \
--packaging=jar \
--name=review-service \
--package-name=com.example.microservices.core.review \
--groupId=com.example.microservices.core.review \
--dependencies=actuator,webflux \
--version=1.0.0-SNAPSHOT \
review-service

rm -r ./microservices/product-service/gradle
rm ./microservices/product-service/HELP.md
rm ./microservices/product-service/gradlew
rm ./microservices/product-service/gradlew.bat

spring init \
--boot-version=3.2.1-SNAPSHOT \
--type=gradle-project \
--java-version=21 \
--packaging=jar \
--name=recommendation-service \
--package-name=com.example.microservices.core.recommendation \
--groupId=com.example.microservices.core.recommendation \
--dependencies=actuator,webflux \
--version=1.0.0-SNAPSHOT \
recommendation-service

rm -r ./microservices/recommendation-service/gradle
rm ./microservices/recommendation-service/HELP.md
rm ./microservices/recommendation-service/gradlew
rm ./microservices/recommendation-service/gradlew.bat

spring init \
--boot-version=3.2.1-SNAPSHOT \
--type=gradle-project \
--java-version=21  \
--packaging=jar \
--name=product-composite-service \
--package-name=com.example.microservices.composite.product \
--groupId=com.example.microservices.composite.product \
--dependencies=actuator,webflux \
--version=1.0.0-SNAPSHOT \
product-composite-service

# shellcheck disable=SC2103
cd ..

rm -r ./microservices/review-service/gradle
rm ./microservices/review-service/HELP.md
rm ./microservices/review-service/gradlew
rm ./microservices/review-service/gradlew.bat