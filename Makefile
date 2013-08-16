build:
	node build.js

clean:
	rm -f test/support/big.db*
	rm -f test/tmp/*
	rm -rf ./deps/sqlite-autoconf-*/
	rm -rf ./build
	rm -rf ./out
	rm -f ./lib/node_sqlite3.node

test:
	npm test

.PHONY: build clean test
