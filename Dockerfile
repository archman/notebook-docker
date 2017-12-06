FROM python:2.7-slim
LABEL maintainer="Tong Zhang <zhangt@frib.msu.edu>"

ENV WKDIR "/phyapps"
ENV DEBPKG "$WKDIR/debs"
ENV WHLPKG "$WKDIR/whls"
ENV TINI_VERSION v0.15.0

WORKDIR $WKDIR

COPY scripts /usr/local/bin/
COPY debian-packages $DEBPKG
COPY wheel-packages $WHLPKG
COPY config/jupyter_notebook_config.py /root/.jupyter/
COPY requirements.txt .

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        libboost-dev \
        libboost-system-dev \
        libboost-filesystem-dev \
        libboost-program-options-dev \
        libhdf5-dev \
        python-numpy \
        libreadline6-dev \
        perl \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        libxext6 \
        && \
    rm -rf /var/lib/apt/lists/* && \
    cd $DEBPKG && dpkg -i *.deb && rm -rf $DEBPKG

RUN for i in `cat requirements.txt`; \
    do \
        pip-install -n $i -m $WHLPKG; \
    done && rm -rf $WHLPKG && rm $WKDIR/requirements.txt

ENV PYFLAME "/usr/lib/python2.7/dist-packages"
ENV PYTHONPATH "/usr/local/lib/python2.7/site-packages:$PYFLAME:$PYTHONPATH"

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

EXPOSE 8888
ENTRYPOINT ["/usr/bin/tini", "--", "startup.sh"]
