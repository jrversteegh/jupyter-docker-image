NAME=jupyter
VERSION=1.0
TAG=$(NAME):$(VERSION)
CMD=sh

# use `make run ROOT=1` to run as root
UID=$(shell id -u)
GID=$(shell id -g)
ifeq ($(ROOT),)
    USER_OPTION = --user $(UID):$(GID) \
                  --env HOME=/jupyter \
                  --env ENV=/jupyter/.profile \
                  --env XDG_CACHE_HOME=/tmp/cache
endif

image:
	docker build --tag=$(TAG) .

run: image
	(cd .. && docker run --rm -it \
	    --volume `pwd`/notebooks:/jupyter/notebooks \
		--workdir /jupyter \
		--publish 8888:8888 \
		$(USER_OPTION) \
		$(TAG) $(CMD))
