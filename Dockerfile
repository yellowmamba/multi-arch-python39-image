FROM public.ecr.aws/lambda/python:3.9 as builder
RUN yum update -y \
    && yum install curl unzip jq git -y \
    && yum -y clean all

# install awsclis
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install --update

# install samcli
RUN pip3 install -U aws-sam-cli

ENTRYPOINT ["/bin/bash"]