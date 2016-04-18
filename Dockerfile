FROM python:3-alpine

# add aptly dependencies
RUN apk -Uuv add openssl bzip2 ca-certificates gnupg && \
  rm /var/cache/apk/*

# install aptly
RUN wget -qO- https://bintray.com/artifact/download/smira/aptly/aptly_0.9.6_linux_amd64.tar.gz | tar -zx \
  mv aptly_0.9.6_linux_amd64/aptly /usr/local/bin/

# install python requirements
ADD requirements*.txt setup.cfg /tmp/
WORKDIR /tmp/
RUN pip --disable-pip-version-check install --no-cache-dir -r requirements.txt

# install utils
ADD scripts/* /tmp/
RUN /tmp/install_test.sh

# install tests
ADD tests/ /opt/tests/

# install resource assets
ADD assets/ /opt/resource/

# test and cleanup
RUN /tmp/test.sh
RUN /tmp/cleanup_test.sh
