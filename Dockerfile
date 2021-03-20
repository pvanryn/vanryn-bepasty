FROM debian:stable-slim
LABEL maintainer= Patrick Van Ryn

RUN apt-get update -y && apt-get install --no-install-recommends -y python3-dev python3-pip python3-venv python3-setuptools build-essential && \ 
pip3 install bepasty uwsgi && \
rm -rf /var/lib/apt/lists/* && \
apt-get remove -y build-essential && \
apt-get autoremove -y

VOLUME /srv/bepasty
ENV BEPASTY_CONFIG /srv/bepasty/bepasty.conf
ENV PYTHONUNBUFFERED 0
EXPOSE 5000

WORKDIR /opt

ADD start.sh /opt/start.sh
ADD bepasty.conf /opt/bepasty.conf
ADD wsgi.py /opt/wsgi.py
RUN chmod 550 /opt/start.sh

CMD ["./start.sh"]
