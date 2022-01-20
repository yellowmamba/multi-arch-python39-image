FROM amazonlinux:2

RUN yum update -y \
    && yum install -y curl zip unzip wget tar gzip make which jq openssh-clients git -y \
    && yum install -y gcc openssl-devel bzip2-devel libffi-devel \
    && yum -y clean all 
    
RUN wget https://www.python.org/ftp/python/3.9.10/Python-3.9.10.tgz \
    && tar xzf Python-3.9.10.tgz \
    && cd Python-3.9.10 \
    && ./configure --enable-optimizations \
    && make altinstall \
    && rm -f Python-3.9.10.tgz

RUN pip3.9 install -U pip pipenv boto3

# install awsclis
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install --update

# install samcli
RUN pip3.9 install -U aws-sam-cli