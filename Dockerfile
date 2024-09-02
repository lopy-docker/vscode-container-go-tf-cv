
ARG VARIANT=1
FROM ghcr.io/lopy-docker/vscode-devcontainer:go-${VARIANT}

ENV TF_VERSION=2.14.1
ENV GOCV_VERSION=0.37.0
RUN cd /tmp \
  && echo "install gocv start ......" \
  && wget https://github.com/hybridgroup/gocv/archive/refs/tags/v${GOCV_VERSION}.tar.gz \
  && tar -zxvf v${GOCV_VERSION}.tar.gz \
  && mv gocv-${GOCV_VERSION} gocv \
  && cd gocv && make install \
  && go build -ldflags="-w -s" -o gocv_version cmd/version/main.go \
  && mv gocv_version `go env GOPATH`/bin \
  && cd .. && rm -rf gocv \
  && echo "install gocv finish" \
  && echo "install tf start ......" \
  && wget https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-${TF_VERSION}.tar.gz \
  && tar -C /usr/local -xzf libtensorflow-cpu-linux-x86_64-${TF_VERSION}.tar.gz \
  && rm -rf libtensorflow-cpu-linux-x86_64-${TF_VERSION}.tar.gz \
  && echo "install tf finish" \
  && ldconfig \
  && apt autoclean && apt autoremove -y