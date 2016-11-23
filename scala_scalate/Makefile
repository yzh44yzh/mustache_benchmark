compile:
	sbt compile


test1: compile
	sbt "run-main MustacheBM ../data/template1.html ../data/bindings1.json 100"

test2: compile
	sbt "run-main MustacheBM ../data/template2.html ../data/bindings2.json 100"

test3: compile
	sbt "run-main MustacheBM ../data/template3.html ../data/bindings3.json 100"

test4: compile
	sbt "run-main MustachePC_BM ../data/template1.html ../data/bindings1.json 1000000"

test5: compile
	sbt "run-main MustachePC_BM ../data/template2.html ../data/bindings2.json 1000000"

test6: compile
	sbt "run-main MustachePC_BM ../data/template3.html ../data/bindings3.json 1000000"
