FROM openjdk:8u191-jre-alpine
MAINTAINER AoZeliu <aozeliu18@otcaix.iscas.ac.cn>

WORKDIR /hadoop

# install bash
RUN apk add --no-cache bash

ARG HADOOP_VERSION=2.7.6
ARG HADOOP_PACKAGE=hadoop-${HADOOP_VERSION}

RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/${HADOOP_PACKAGE}/${HADOOP_PACKAGE}.tar.gz && \
	tar -xzf ${HADOOP_PACKAGE}.tar.gz && \
	mv ${HADOOP_PACKAGE} /usr/hadoop && \
	rm ${HADOOP_PACKAGE}.tar.gz

ENV HADOOP_HOME=/usr/hadoop
ENV PATH=$PATH:${HADOOP_HOME}/bin:$HADOOP_HOME}/sbin

ADD core-site.xml ${HADOOP_HOME}/etc/hadoop/core-site.xml
ADD hdfs-site.xml ${HADOOP_HOME}/etc/hadoop/hdfs-site.xml
ADD mapred-site.xml ${HADOOP_HOME}/etc/hadoop/mapred-site.xml
ADD yarn-site.xml ${HADOOP_HOME}/etc/hadoop/yarn-site.xml
RUN hdfs namenode -format
