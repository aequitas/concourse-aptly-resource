FROM alpine:latest

RUN \
	apk -Uuv add jq openssl bzip2 ca-certificates gnupg && \
	rm /var/cache/apk/*

RUN wget -qO- https://bintray.com/artifact/download/smira/aptly/aptly_0.9.6_linux_amd64.tar.gz | tar -zx
RUN mv aptly_0.9.6_linux_amd64/aptly /usr/local/bin/

# for jq
ENV PATH=/usr/local/bin:$PATH

# install asserts
ADD assets/ /opt/resource/
RUN chmod +x /opt/resource/*

# test
ADD tests/ /opt/test-resource/
RUN set -ve; /opt/test-resource/tests.sh
