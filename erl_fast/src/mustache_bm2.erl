-module(mustache_bm2).

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
    [parse(Data, Bindings2) || _ <- lists:seq(1, NumTests)],
    T2 = erlang:system_time(milli_seconds),
    io:format("~p~n", [T2 - T1]),
    init:stop().


parse(Str, Data) when is_binary(Str) ->
    Parts = binary:split(Str, [<<"{{">>], [global]),
    Parts2 =
        lists:map(
            fun(Part) ->
                case binary:split(Part, [<<"}}">>]) of
                    [PartWithNoParam] -> PartWithNoParam;
                    [Param | Rest] ->
                        case maps:find(Param, Data) of
                            error -> Rest;
                            {ok, Value} -> [val(Value), Rest]
                        end
                end
            end, Parts),
    unicode:characters_to_binary(Parts2).


val(Val) when is_binary(Val) -> Val;
val(Val) when is_list(Val) -> Val;
val(Val) when is_integer(Val) -> integer_to_binary(Val);
val(true) -> <<"true">>;
val(false) -> <<"false">>;
val(_) -> <<>>.