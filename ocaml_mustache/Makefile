compile:
	corebuild -pkg ezjsonm -pkg mustache -I src mustache_bm.native


gep_deps:
	opam install ezjsonm
	opam install mustache

clean:
	corebuild -clean


test1: compile
	./mustache_bm.native ../data/template1.html ../data/bindings1.json 1000000

test2: compile
	./mustache_bm.native ../data/template2.html ../data/bindings2.json 1000000

test3: compile
	./mustache_bm.native ../data/template3.html ../data/bindings3.json 1000000
