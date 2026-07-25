.PHONY: run test lint clean build

PROJECT_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

run:
	python $(PROJECT_DIR)src/main.py

test:
	python -m unittest discover -s $(PROJECT_DIR)tests -v

lint:
	python -m py_compile $(PROJECT_DIR)src/main.py
	@echo "Syntax check passed."

clean:
	rm -rf $(PROJECT_DIR)__pycache__
	rm -rf $(PROJECT_DIR).pytest_cache
	rm -rf $(PROJECT_DIR)build/
	rm -rf $(PROJECT_DIR)dist/
	rm -rf $(PROJECT_DIR)*.egg-info
	find $(PROJECT_DIR) -name "*.pyc" -delete
	find $(PROJECT_DIR) -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
	@echo "Cleaned."

build:
	@echo "Build target — define in your project's Makefile."
	@echo "Examples: pyinstaller, docker build, cargo build."
