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

# courtesy of https://medium.com/@jgautheron/quality-pipeline-for-go-projects-497e34d6567
lint:
	@echo "gometalinter"
	@! gometalinter ./... | \
	grep -vE '(Godeps|vendor)'
	@echo "gofmt (simplify)"
	@! gofmt -s -d -l . 2>&1 | grep -vE '^\.git/'
	@echo "goimports"
	@! goimports -l . | grep -vF 'No Exceptions'
