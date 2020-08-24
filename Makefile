lint:
        git clone https://github.com/hadolint/hadolint
        cd hadolint
        stack install
	hadolint Dockerfile
	pylint3 --disable=R,C,W1203 app.py

build:
	docker build --build-arg APP_PORT=5000 --tag=shubhi19/k8-flask-api .

upload:
	sh ./scripts/upload_docker.sh
