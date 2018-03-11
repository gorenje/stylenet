FROM python:2
RUN apt-get update
RUN apt-get install emacs htop -y
RUN pip install tensorflow numpy scikit-image
WORKDIR /usr/src/app
COPY . .
RUN mkdir train
RUN ln -s images test_data
