
# Getting base image from DockerHub

FROM alpine


# Installing CURL
RUN apk --no-cache add curl

# Adding am authenticator

RUN curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator

RUN chmod +x ./aws-iam-authenticator

RUN mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH

RUN echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc

# Installing kubectl

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin
RUN mkdir /scripts
COPY hpa-downscaler.sh /scripts
WORKDIR /scripts
RUN pwd && ls

ENTRYPOINT ["sh","./hpa-downscaler.sh"]
