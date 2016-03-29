reportdir=testreports

# order matters!
images=centos:7 java:7 java:8 java-dev:8 php:56 php-dev:56 testrunner

build-all: clean
	docker pull centos:7

	# not using Dockerfile.* as the order matters!
	for image in $(images); do PUSH_IMAGE=$(PUSH_IMAGE) NOCACHE=true ./build-image Dockerfile.$${image}; done

	make reports

test-all:
	rm -rf $(reportdir) *.xml
	reportdir=$(reportdir) ./test-image test.*
	make reports

reports:
	docker run --rm -v $(CURDIR):$(CURDIR) -w $(CURDIR) golang ./create-junit-reports.sh $(reportdir) $(shell id -u)

clean:
	git clean -fdx
