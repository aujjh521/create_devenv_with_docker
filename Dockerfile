FROM python:3.9-slim as base
FROM base as builder
# Install dependencies
COPY requirements.txt /requirements.txt
RUN pip install --user -r /requirements.txt


FROM base
# copy only the dependencies installation from the 1st stage image
COPY --from=builder /root/.local /root/.local
# Set working directory
WORKDIR /app
# Copy files
COPY . /app

#intall git
RUN apt-get update && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
    git \
    htop

#git settings (password is personal token created from github website, will expired and need to be updated)
RUN git config --global user.name aujjh521 \
  && git config --global user.email aujjh521@gmail.com
