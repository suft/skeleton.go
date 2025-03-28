# Variables
BINARY_NAME=app
BUILD_DIR=bin
GO_FILES=$(shell find . -name '*.go')

# Tools
GO=$(shell which go)
GOLINT=$(shell which golangci-lint || echo '$(GOPATH)/bin/golangci-lint')

.PHONY: all build clean run test lint fmt tidy install-deps

# Default target
all: build

# Build the project
build: $(GO_FILES)
	@echo "Building..."
	@mkdir -p $(BUILD_DIR)
	@$(GO) build -o $(BUILD_DIR)/$(BINARY_NAME) ./...

# Run the application
run: build
	@echo "Running..."
	@./$(BUILD_DIR)/$(BINARY_NAME)

# Run tests
test:
	@echo "Running tests..."
	@$(GO) test -v ./...

# Lint the code
lint:
	@echo "Linting..."
	@$(GOLINT) run ./...

# Format the code
fmt:
	@echo "Formatting..."
	@$(GO) fmt ./...

# Tidy up Go modules
tidy:
	@echo "Tidying up..."
	@$(GO) mod tidy

# Install dependencies
install-deps:
	@echo "Installing dependencies..."
	@$(GO) mod download

# Clean up binaries and cache
clean:
	@echo "Cleaning up..."
	@rm -rf $(BUILD_DIR)
	@$(GO) clean
