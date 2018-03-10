FROM python:2
RUN apt-get update
RUN apt-get install emacs -y
RUN pip install tensorflow numpy scikit-image
WORKDIR /usr/src/app
RUN git clone https://github.com/gorenje/stylenet.git
