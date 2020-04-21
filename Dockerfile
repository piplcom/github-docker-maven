FROM maven:3.6.3-jdk-8

MAINTAINER "Pipl"

# https://stackoverflow.com/questions/11118237/maven-error-could-not-find-or-load-main-class-org-codehaus-plexus-classworlds-l
ENV M2_HOME=/usr/share/maven


ADD .gitconfig /tmp/.gitconfig
ADD entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x  ./tmp/entrypoint.sh

COPY settings-docker.xml /root/.m2/settings.xml

ENTRYPOINT [ "/tmp/entrypoint.sh" ]