FROM python:3.8
COPY install.sh /
RUN /bin/sh -c /install.sh