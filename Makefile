GOCMD := go
GOBUILD := $(GOCMD) build
GOCLEAN := $(GOCMD) clean
GOTEST := $(GOCMD) test
GOGET := $(GOCMD) get
BINARY_NAME := etui

all: test build
build:
	$(GOBUILD) -o $(BINARY_NAME) -v
test:
	$(GOTEST) -v ./...
clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
run:
	$(GOBUILD) -o $(BINARY_NAME) -v ./...
	./$(BINARY_NAME)
dep:
	dep ensure

lint:
	@echo "gometalinter"
	@gometalinter --vendor ./...
	@echo "gofmt (simplify)"
	@! gofmt -s -l . 2>&1 | grep -v vendor
	@echo "goimports"
	@! goimports -l . | grep -v vendor
