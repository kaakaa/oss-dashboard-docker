FROM ubuntu:16.04
RUN apt update \
  && apt install -y apt-file \
  && apt-file update \
  && apt-file search add-apt-repository \
  && apt install -y software-properties-common \
  && apt-add-repository ppa:brightbox/ruby-ng \
  && apt update \
  && apt install -y ruby2.2 ruby2.2-dev git

ENV SRC_ROOT=/usr/local/src

COPY ./oss-dashboard ${SRC_ROOT}/oss-dashboard
WORKDIR ${SRC_ROOT}/oss-dashboard
RUN apt install -y build-essential cmake pkg-config libpq-dev libxml2-dev libxslt1-dev \
  && gem install bundler \
  && bundle install --path vendor/bundle

ENTRYPOINT ["bundle", "exec", "ruby", "refresh-dashboard.rb"]
CMD ["config-dashboard.yaml"]
