#!/usr/bin/make -f
SHELL=bash

# BRanch to match for BRaking changes
BRBR?=master

.PHONY: lint
lint:
	buf check lint
	buf check breaking --against-input '.git#branch=$(BRBR)'

.PHONY: doc
# Regenerate documentation for protot files:
doc:
	@for f in `find . -type f -name '*.proto' -exec dirname {} \; | sort -u `; do \
		echo "${B}${G}⇒ Documentation for $$(basename $$f) ${R}"; \
		protoc \
			--doc_opt=.github/markdown.tmpl,$${f}.md \
			--proto_path=.:/usr/local/include \
			--doc_out=proto-docs/ $${f}/*.proto; \
	done
