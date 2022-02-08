APP = my_app_name
HAS_LINT := $(shell command -v golangci-lint;)
HAS_IMPORTS := $(shell command -v goimports;)
RELEASE_DATE = $(shell date +%FT%T%Z)
RELEASE = 0.0.1


LDFLAGS = "-s -w \
    -X cmd/main.RELEASE=$(RELEASE) \
    -X $(PROJECT)/cmd/main.DATE=$(RELEASE_DATE)"

#bootstrap:
#ifndef HAS_LINT
#	go get github.com/golangci/golangci-lint/cmd/golangci-lint@v1.44.0
#endif
#ifndef HAS_IMPORTS
#	go get -u golang.org/x/tools/cmd/goimports
#endif

all: clean build

.PHONY: build
build: lint test
	@echo "+ $@"
	@go mod tidy

.PHONY: lint
lint:
	golangci-lint run -c ./configs/golangci.yml -v cmd/*.go

.PHONY: test
test:
	go test -race ./...

.PHONY: clean
clean:
	@rm -f ./${APP}