FROM python:3.9-alpine3.13

COPY requirements.txt /

RUN buildDeps='.pynacl_deps gcc musl-dev cargo' && \
    apk add --no-cache libffi-dev openssl-dev tzdata && \
    apk add --no-cache --wait 10 --virtual .pynacl_deps build-base python3-dev $buildDeps && \
    pip3 install -r /requirements.txt && \
    apk del $buildDeps

COPY . /app
WORKDIR /app

CMD ["python3", "/app/sbb.py"]
