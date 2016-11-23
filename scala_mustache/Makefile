compile:
	sbt compile


test1: compile
	sbt "run-main MustacheBM ../data/template1.html ../data/bindings1.json 1000000"

test2: compile
	sbt "run-main MustacheBM ../data/template2.html ../data/bindings2.json 1000000"

test3: compile
	sbt "run-main MustacheBM ../data/template3.html ../data/bindings3.json 1000000"
