FROM rhscl/python-27-rhel7

RUN yum update -y && install uwsgi
COPY . /opt/app-root

EXPOSE 8080
CMD uwsgi --http 127.0.0.1:8080
