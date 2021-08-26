FROM codercom/code-server:3.11.1

RUN sudo apt-get update

RUN sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    lsb-release

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN curl -fsSL https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -

RUN echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
RUN echo "deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/adoptopenjdk.list

RUN sudo apt-get update

RUN sudo apt-get -y install docker-ce docker-ce-cli containerd.io adoptopenjdk-11-hotspot maven

ENTRYPOINT ["/usr/bin/entrypoint.sh" "--bind-addr" "0.0.0.0:8080" "."]