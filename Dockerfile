FROM openshift/python-27-centos7
USER root 

ENV PYTHON_VERSION=2.7 \
    PATH=$HOME/.local/bin/:$PATH

LABEL io.k8s.description="Platform for building and running Python 2.7 applications" \
      io.k8s.display-name="Python 2.7" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,python,python27,rh-python27"

RUN yum update -y
RUN yum install -y virtualenv
RUN virtualenv $HOME/illr \
  && source $HOME/illr/bin/activate \
  && wget -O /tmp/pip_install.py https://bootstrap.pypa.io/get-pip.py
  && python /tmp/pip_install.py

RUN pip install uwsgi
COPY . /opt/app-root

EXPOSE 8080
CMD uwsgi --http 127.0.0.1:8080
