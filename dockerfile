#FROM ubuntu:22.04
FROM gradle:latest AS BUILD
RUN gradle init
RUN gradle clean deployNodes
