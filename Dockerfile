# Base image
FROM python:3.10-slim as base
FROM base as builder
# Install dependencies
COPY requirements.txt /requirements.txt
# RUN pip install --user -r /requirements.txt


FROM base
# copy only the dependencies installation from the 1st stage image
# COPY --from=builder /root/.local /root/.local
# Set working directory
WORKDIR /app
# Copy files
COPY . /app


RUN apt-get update && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
    git \
    wget \
    g++ \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && echo "Running $(conda --version)" && \
    conda init bash && \
    . /root/.bashrc && \
    conda update conda && \
    conda create -n python-app python=3.10 && \
    conda activate python-app && \
    pip install --user -r requirements.txt