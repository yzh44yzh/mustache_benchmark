compile:
	export GOPATH=${CURDIR}; go install mbm

get_deps:
	export GOPATH=${CURDIR}; go get github.com/cbroglie/mustache

test1: compile
	./bin/mbm ../data/template1.html ../data/bindings1.json 1000000

test2: compile
	./bin/mbm ../data/template2.html ../data/bindings2.json 1000000

test3: compile
	./bin/mbm ../data/template3.html ../data/bindings3.json 1000000

