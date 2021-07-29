image = docs-api

.PHONY: build
build:
	docker build . -t $(image)

.PHONY: start
start: build
	docker run --rm \
		-p 4567:4567 \
		-v $(shell pwd)/source:/srv/slate/source \
		$(image) serve

.PHONY: publish
publish: build
	docker run --rm \
		-v $(shell pwd):/srv/slate \
		$(image) ./deploy.sh --push-only
