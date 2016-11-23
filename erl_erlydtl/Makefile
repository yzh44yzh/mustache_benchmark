compile:
	rebar3 compile

test1: compile
	erl -pa _build/default/lib/*/ebin -s mustache_bm3 main \
	"../data/template1.html" "../data/bindings1.json" "1000000"

test2: compile
	erl -pa _build/default/lib/*/ebin -s mustache_bm3 main \
	"../data/template2.html" "../data/bindings2.json" "1000000"


