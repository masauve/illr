FROM registry.access.redhat.com/openshift3/python-33-rhel7

CMD yum update -y

ENTRYPOINT ['top', '-b']
