#!/bin/sh

set -ve

cd /tmp

wget -q http://repo.aptly.info/pool/main/a/aptly/aptly_0.9.6_amd64.deb

aptly repo create test
aptly repo add test aptly_0.9.6_amd64.deb

aptly snapshot create test from repo test

cat > config.json <<EOF
{
  "S3PublishEndpoints": {
    "test": {
      "region": "${AWS_DEFAULT_REGION}",
      "bucket": "${AWS_BUCKET}"
    }
  }
}
EOF

aptly -config=config.json -skip-signing -distribution=trusty publish snapshot test s3:test:
