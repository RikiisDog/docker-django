FROM python:3.10
RUN apt-get update && apt-get install -y tzdata && rm -rf /var/lib/apt/lists/*
RUN mkdir project/
WORKDIR /project
COPY requirements.txt /project/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
ENV PYTHONUNBUFFERED 1
ENV TZ=Asia/Tokyo
COPY . /project/