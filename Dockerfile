FROM codercom/code-server:4.0.2

RUN sudo apt-get update

RUN sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg \
    curl \
    lsb-release \
    unzip \
    make \
    build-essential \
    libgtk2.0-0 \
    libgtk-3-0 \
    libgbm-dev \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
    libxtst6 \
    xauth\
    xvfb

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN curl -fsSL https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo gpg --dearmor -o /usr/share/keyrings/adoptopenjdk-archive-keyring.gpg

RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
RUN echo "deb [signed-by=/usr/share/keyrings/adoptopenjdk-archive-keyring.gpg] https://adoptopenjdk.jfrog.io/adoptopenjdk/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/adoptopenjdk.list

RUN sudo apt-get update

RUN sudo apt-get -y install docker-ce docker-ce-cli containerd.io adoptopenjdk-11-hotspot maven

RUN curl http://www.byond.com/download/build/514/514.1564_byond_linux.zip -o byond.zip \
        && unzip byond.zip \
        && cd byond \
        && sudo mkdir -p /usr/share/man/man6 \
        && sudo make install \
        && cd .. \
        && rm -rf byond.zip byond

apt-get install 

ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "."]
