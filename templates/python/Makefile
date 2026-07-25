.PHONY: all format lint test clean

PROJECT_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

all: format lint test

format:
	ruff format $(PROJECT_DIR)

lint:
	ruff check $(PROJECT_DIR)
	mypy $(PROJECT_DIR)src

test:
	python -m pytest $(PROJECT_DIR)tests

clean:
	rm -rf $(PROJECT_DIR).venv
	rm -rf $(PROJECT_DIR)__pycache__
	rm -rf $(PROJECT_DIR).pytest_cache
	rm -rf $(PROJECT_DIR).ruff_cache
	rm -rf $(PROJECT_DIR).mypy_cache
	rm -rf $(PROJECT_DIR)build/
	rm -rf $(PROJECT_DIR)dist/
	rm -rf $(PROJECT_DIR)*.egg-info
	find $(PROJECT_DIR) \( -name "*.pyc" -o -name "__pycache__" \) -exec rm -rf {} + 2>/dev/null; true
	@echo "Cleaned."
