
ARG VARIANT=1
FROM ghcr.io/lopy-docker/vscode-devcontainer:go-${VARIANT}

ENV TF_VERSION=2.14.1
RUN cd /tmp && git clone https://github.com/hybridgroup/gocv.git && cd gocv && make install && cd .. && rm -rf gocv \
  && wget https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-${TF_VERSION}.tar.gz \
  && tar -C /usr/local -xzf libtensorflow-cpu-linux-x86_64-${TF_VERSION}.tar.gz \
  && rm -rf libtensorflow-cpu-linux-x86_64-${TF_VERSION}.tar.gz \
  && ldconfig \
  && apt autoclean && apt autoremove -y