.PHONY: build
build:
	docker build . -t developer-docs-public

.PHONY: start
start:
	docker run --rm \
		--name slate \
		-p 4567:4567 \
		-v $(shell pwd)/source:/srv/slate/source \
		developer-docs-public serve
