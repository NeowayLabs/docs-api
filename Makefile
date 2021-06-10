.PHONY: build
build:
	docker run --rm --name slate -v $(shell pwd)/build:/srv/slate/build -v $(shell pwd)/source:/srv/slate/source slatedocs/slate

.PHONY: start
start:
	docker run --rm --name slate -p 4567:4567 -v $(shell pwd)/source:/srv/slate/source slatedocs/slate serve
