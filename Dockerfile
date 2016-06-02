FROM openshift/base-rhel7

ENV PYTHON_VERSION=2.7 \
    PATH=$HOME/.local/bin/:$PATH

LABEL io.k8s.description="Platform for building and running Python 2.7 applications" \
      io.k8s.display-name="Python 2.7" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,python,python27,rh-python27"

# Labels consumed by Red Hat build service
LABEL Name="rhscl/python-27-rhel7" \
      BZComponent="python27-docker" \
      Version="2.7" \
      Release="1" \
      Architecture="x86_64"

RUN yum-config-manager --enable rhel-server-rhscl-7-rpms \
    yum-config-manager --enable rhel-7-server-optional-rpms && \
    yum-config-manager --disable epel >/dev/null || : && \
    yum install -y --setopt=tsflags=nodocs python27 python27-python-devel python27-python-setuptools python27-python-pip nss_wrapper && \
    yum clean all -y
    
RUN pip install uwsgi
COPY . /opt/app-root

EXPOSE 8080
CMD uwsgi --http 127.0.0.1:8080
