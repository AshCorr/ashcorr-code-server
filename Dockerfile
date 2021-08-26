FROM codercom/code-server:3.11.1

RUN sudo apt-get update

RUN sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    lsb-release

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg --output /usr/share/keyrings/docker-archive-keyring.gpg
RUN curl -fsSL https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public --output /usr/share/keyrings/adoptopenjdk-archive-keyring.gpg

RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
RUN echo "deb [signed-by=/usr/share/keyrings/adoptopenjdk-archive-keyring.gpg] https://adoptopenjdk.jfrog.io/adoptopenjdk/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/adoptopenjdk.list

RUN sudo apt-get update

RUN sudo apt-get -y install docker-ce docker-ce-cli containerd.io adoptopenjdk-11-hotspot maven

ENTRYPOINT ["/usr/bin/entrypoint.sh" "--bind-addr" "0.0.0.0:8080" "."]