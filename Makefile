NETMAP_VERSION=v1.7.0
GOGOPROTO_VERSION=v1.3.1

NETMAP_URL=https://github.com/nspcc-dev/netmap/archive/$(NETMAP_VERSION).tar.gz
GOGOPROTO_URL=https://github.com/gogo/protobuf/archive/$(GOGOPROTO_VERSION).tar.gz

.PHONY: deps docgen

deps:
	@echo "=> Prepare"
	@rm -rf ./vendor/github.com/gogo/protobuf
	@rm -rf ./vendor/github.com/nspcc-dev/netmap
	@mkdir -p ./vendor/github.com/gogo/protobuf
	@mkdir -p ./vendor/github.com/nspcc-dev/netmap

	@echo "=> Download"
	@curl -sL -o ./vendor/gogo.tar.gz $(GOGOPROTO_URL)
	@curl -sL -o ./vendor/netmap.tar.gz $(NETMAP_URL)

	@echo "=> Vendoring"
	@tar -xzf ./vendor/gogo.tar.gz --strip-components 1 -C ./vendor/github.com/gogo/protobuf
	@tar -xzf ./vendor/netmap.tar.gz --strip-components 1 -C ./vendor/github.com/nspcc-dev/netmap

	@echo "=> Cleanup"
	@rm ./vendor/gogo.tar.gz
	@rm ./vendor/netmap.tar.gz

# Regenerate documentation for protot files:
docgen: deps
	@for f in `find . -type f -name '*.proto' -not -path './vendor/*' -exec dirname {} \; | sort -u `; do \
		echo "${B}${G}⇒ Documentation for $$(basename $$f) ${R}"; \
		protoc \
			--doc_opt=.github/markdown.tmpl,$${f}.md \
			--proto_path=.:./vendor:/usr/local/include \
			--doc_out=proto-docs/ $${f}/*.proto; \
	done
