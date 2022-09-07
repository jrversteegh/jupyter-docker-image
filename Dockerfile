FROM python:3-alpine

RUN apk add build-base gfortran openblas-dev linux-headers

RUN python -m venv venv

RUN . venv/bin/activate \
  && pip install --upgrade pip

RUN . venv/bin/activate \
  && pip install \
        setuptools \
        wheel \
  && pip cache purge

RUN . venv/bin/activate \
  && pip install \
        numpy \
        scipy \
        matplotlib \
  && pip cache purge

RUN . venv/bin/activate \
  && pip install \
        ipython \
        jupyter \
        jupyterlab \
  && pip cache purge

RUN . venv/bin/activate \
  && pip install \
        pydantic \
        attrs \
        appdirs \
        pytest \ 
        pytest-asyncio \ 
        isort \
        black \
        flake8 \
        Pint \
        python-dateutil \
        fastapi \
        fastapi-utils \
        async_property \
        aiohttp \
        hypercorn \
  && pip cache purge

RUN mkdir -p /jupyter/.local
RUN chmod 777 /jupyter/.local
COPY config.py /jupyter/config.py
COPY profile /jupyter/.profile
COPY start.sh /jupyter/start.sh
