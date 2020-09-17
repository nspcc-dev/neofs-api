#!/usr/bin/make -f
SHELL=bash

# BRanch to match for BReaking changes
BRBR?=master

.PHONY: lint
lint:
	buf check lint
	buf check breaking --against-input '.git#branch=$(BRBR)'

.PHONY: doc
# Regenerate documentation for proto files:
doc:
	@for f in `find . -type f -name '*.proto' -exec dirname {} \; | sort -u `; do \
		echo "⇒ Documentation for $$(basename $$f)"; \
		protoc \
			--doc_opt=.github/markdown.tmpl,$${f}.md \
			--proto_path=.:/usr/local/include \
			--doc_out=proto-docs/ $${f}/*.proto; \
	done
