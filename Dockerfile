FROM maven:3.6.3-jdk-8

MAINTAINER "Pipl"

# https://stackoverflow.com/questions/11118237/maven-error-could-not-find-or-load-main-class-org-codehaus-plexus-classworlds-l
ENV M2_HOME=/usr/share/maven


ADD entrypoint.sh /entrypoint.sh
RUN chmod +x  /entrypoint.sh
COPY settings-docker.xml /root/.m2/settings.xml

ENTRYPOINT [ "/entrypoint.sh" ]
