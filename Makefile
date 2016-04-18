reportdir=testreports

# order matters!
images=centos:7 centos-dev:7 golang java:7 java:8 java-dev:8 php:56 php-dev:56 ruby testrunner

build-all: clean
	docker pull centos:7

	# not using Dockerfile.* as the order matters!
	set -e; for image in $(images); do PUSH_IMAGE=$(PUSH_IMAGE) NOCACHE=true ./build-image Dockerfile.$${image}; done

	make test-all

test-all:
	rm -rf $(reportdir) *.xml
	reportdir=$(reportdir) ./test-image test.*
	./compare-against-upstream-php 56 | tee $(reportdir)/php-56-latest.log
	make reports

reports:
	docker run --rm -v $(CURDIR):$(CURDIR) -w $(CURDIR) golang ./create-junit-reports.sh $(reportdir) $(shell id -u)

clean:
	find .php-* -name .git -exec rm -rf {} \; || exit 0
	git clean -fdx
