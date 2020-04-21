FROM maven:3.6.3-jdk-8
MAINTAINER "Pipl"

# https://stackoverflow.com/questions/11118237/maven-error-could-not-find-or-load-main-class-org-codehaus-plexus-classworlds-l
ENV M2_HOME=/usr/share/maven

RUN set -x \
  && apt-get update \
  && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

RUN set -x \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable" \
  && apt-get update \
  && apt-get install -y rsync \
  && apt-get install -y git \
  && apt-get install -y docker-ce docker-ce-cli containerd.io



ADD entrypoint.sh /entrypoint.sh
RUN chmod +x  /entrypoint.sh
COPY settings-docker.xml /root/.m2/settings.xml

ENTRYPOINT [ "/entrypoint.sh" ]
