FROM registry.access.redhat.com/rhscl/python-27-rhel7:latest

CMD yum update -y

ENTRYPOINT ['top', '-b']
