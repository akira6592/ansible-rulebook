FROM registry.access.redhat.com/ubi8/python-39

ARG USER_ID=${USER_ID:-1001}
WORKDIR $HOME

USER 0
RUN dnf install -y java-11-openjdk-devel maven
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk
ENV PIP_NO_BINARY=jpy
RUN pip install -U pip \
    && pip install ansible \
    ansible-runner \
    jmespath \
    asyncio \
    aiohttp \
    aiokafka \
    watchdog \
    azure-servicebus \
    && ansible-galaxy collection install benthomasson.eda

COPY . $WORKDIR
RUN chown -R $USER_ID ./

USER $USER_ID
RUN pip install .
