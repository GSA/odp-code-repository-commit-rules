GOBIN := $(GOPATH)/bin
GOLANGCILINT := $(GOBIN)/golangci-lint

.PHONY: test tidy lint dependencies
default: test

test: lint tidy
	go test -v ./...

tidy:
	go mod tidy

lint: dependencies
	$(GOLANGCILINT) run ./...

go.mod:
ifeq (,$(wildcard go.mod))
	go mod init
endif

dependencies: $(GOLANGCILINT) go.mod

$(GOLANGCILINT):
	go get -u github.com/golangci/golangci-lint/cmd/golangci-lint