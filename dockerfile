FROM tomcat:latest
MAINTAINER Dziadkou Dzianis

ARG vTask

RUN wget -P /usr/local/tomcat/webapps/ http://172.192.10.30:8081/nexus/content/repositories/releases/task3/$vTask/task3.war
