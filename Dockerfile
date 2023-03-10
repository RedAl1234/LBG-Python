FROM python:3
MAINTAINER Ahmed Lulat

#update the image
RUN apt-get update && apt-get clean

#install wget for maven
RUN apt-get install -y wget

#install git
RUN apt-get install -y git

#install pip

WORKDIR /LBG-Python

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080
CMD [ "python", "./lbg.py" ]
