build:
	docker build -t aptly-resource .

integration: build
	docker run \
		--env AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
		--env AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
		--env AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) \
		--env AWS_BUCKET=$(AWS_BUCKET_NAME) \
		aptly-resource /opt/test-resource/integration.sh
