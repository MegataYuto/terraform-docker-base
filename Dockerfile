FROM python:3.10-buster

RUN apt-get update && apt-get install -y \
git \
curl \
build-essential \
file \
less

#tfenv install
RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv && \
	echo 'PATH=${HOME}/.tfenv/bin:${PATH}' >> ~/.bashrc

#node.js
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
apt-get install -y nodejs

# awscli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \
./aws/install && rm awscliv2.zip &&\
pip install aws-mfa

#assumerole
RUN wget https://dl.google.com/go/go1.7.linux-amd64.tar.gz && \
tar -C /usr/local -xzf go1.7.linux-amd64.tar.gz && rm go1.7.linux-amd64.tar.gz
ENV GOPATH $HOME/work
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin
RUN go get -u github.com/remind101/assume-role
