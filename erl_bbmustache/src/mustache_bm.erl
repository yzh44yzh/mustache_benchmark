-module(mustache_bm).

-export([main/1]).

main(Args) ->
    io:format("main ~p~n", [Args]),
    case Args of
        [DataFile, BindingsFile, NumTests | _] ->
            do_test(
                atom_to_list(DataFile),
                atom_to_list(BindingsFile),
                list_to_integer(atom_to_list(NumTests))
            );
        _ -> io:format("invalid arguments~n"),
            init:stop(1)
    end,
    ok.

do_test(DataFile, BindingsFile, NumTests) ->
    io:format("do_test ~p ~p ~p~n", [DataFile, BindingsFile, NumTests]),
    {ok, Data} = file:read_file(DataFile),
    {ok, Bindings} = file:read_file(BindingsFile),
    Bindings2 = jiffy:decode(Bindings, [return_maps]),

    T1 = erlang:system_time(milli_seconds),
    [bbmustache:render(Data, Bindings2, [{key_type, string}]) || _ <- lists:seq(1, NumTests)],
    T2 = erlang:system_time(milli_seconds),
    io:format("~p~n", [T2 - T1]),
    init:stop().

