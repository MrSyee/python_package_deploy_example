FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
RUN apt-get update && \
    apt-get install -y build-essential wget libbz2-dev zlib1g-dev \
    libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
    libreadline-dev libffi-dev openssl libsqlite3-dev \
    software-properties-common
RUN apt-get install -y software-properties-common vim
RUN apt-get install -y libsm6 libxext6 libxrender-dev libusb-1.0-0-dev && apt-get update
RUN apt-get install -y git

RUN wget https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y tk-dev
RUN tar xzvf Python-3.7.9.tgz
RUN cd Python-3.7.9 && ./configure && make && make install
RUN pip3 install -U pip
RUN update-alternatives --install /usr/bin/python python /usr/local/bin/python3.7 1

RUN pip install twine
COPY .pypirc /root/.pypirc
