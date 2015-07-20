%% Module used for grabbing the title from websites

-include_lib("eunit/include/eunit.hrl").

-module(utg).

-export([grab/1, grab/2]).

-author("dave@douchedata.com").

-define(HTML_ENTITIES, [
        {"nbsp", " "},
        {"iexcl", "¡"},
        {"cent", "¢"},
        {"pound", "£"},
        {"curren", "¤"},
        {"yen", "¥"},
        {"brvbar", "¦"},
        {"sect", "§"},
        {"uml", "¨"},
        {"copy", "©"},
        {"ordf", "ª"},
        {"laquo", "«"},
        {"not", "¬"},
        {"hy", "s"},
        {"reg", "®"},
        {"macr", "¯"},
        {"deg", "°"},
        {"plusmn", "±"},
        {"sup2", "²"},
        {"sup3", "³"},
        {"acute", "´"},
        {"micro", "µ"},
        {"para", "¶"},
        {"middot", "·"},
        {"cedil", "¸"},
        {"sup1", "¹"},
        {"ordm", "º"},
        {"raquo", "»"},
        {"frac14", "¼"},
        {"frac12", "½"},
        {"frac34", "¾"},
        {"iquest", "¿"},
        {"Agrave", "À"},
        {"Aacute", "Á"},
        {"Acirc", "Â"},
        {"Atilde", "Ã"},
        {"Auml", "Ä"},
        {"Aring", "Å"},
        {"AElig", "Æ"},
        {"Ccedil", "Ç"},
        {"Egrave", "È"},
        {"Eacute", "É"},
        {"Ecirc", "Ê"},
        {"Euml", "Ë"},
        {"Igrave", "Ì"},
        {"Iacute", "Í"},
        {"Icirc", "Î"},
        {"Iuml", "Ï"},
        {"ETH", "Ð"},
        {"Ntilde", "Ñ"},
        {"Ograve", "Ò"},
        {"Oacute", "Ó"},
        {"Ocirc", "Ô"},
        {"Otilde", "Õ"},
        {"Ouml", "Ö"},
        {"times", "×"},
        {"Oslash", "Ø"},
        {"Ugrave", "Ù"},
        {"Uacute", "Ú"},
        {"Ucirc", "Û"},
        {"Uuml", "Ü"},
        {"Yacute", "Ý"},
        {"THORN", "Þ"},
        {"szlig", "ß"},
        {"agrave", "à"},
        {"aacute", "á"},
        {"acirc", "â"},
        {"atilde", "ã"},
        {"auml", "ä"},
        {"aring", "å"},
        {"aelig", "æ"},
        {"ccedil", "ç"},
        {"egrave", "è"},
        {"eacute", "é"},
        {"ecirc", "ê"},
        {"euml", "ë"},
        {"igrave", "ì"},
        {"iacute", "í"},
        {"icirc", "î"},
        {"iuml", "ï"},
        {"eth", "ð"},
        {"ntilde", "ñ"},
        {"ograve", "ò"},
        {"oacute", "ó"},
        {"ocirc", "ô"},
        {"otilde", "õ"},
        {"ouml", "ö"},
        {"divide", "÷"},
        {"oslash", "ø"},
        {"ugrave", "ù"},
        {"uacute", "ú"},
        {"ucirc", "û"},
        {"uuml", "ü"},
        {"yacute", "ý"},
        {"thorn", "þ"},
        {"yuml", "ÿ"},
        {"fnof", "ƒ"},
        {"Alpha", "Α"},
        {"Beta", "Β"},
        {"Gamma", "Γ"},
        {"Delta", "Δ"},
        {"Epsilon", "Ε"},
        {"Zeta", "Ζ"},
        {"Eta", "Η"},
        {"Theta", "Θ"},
        {"Iota", "Ι"},
        {"Kappa", "Κ"},
        {"Lambda", "Λ"},
        {"Mu", "Μ"},
        {"Nu", "Ν"},
        {"Xi", "Ξ"},
        {"Omicron", "Ο"},
        {"Pi", "Π"},
        {"Rho", "Ρ"},
        {"Sigma", "Σ"},
        {"Tau", "Τ"},
        {"Upsilon", "Υ"},
        {"Phi", "Φ"},
        {"Chi", "Χ"},
        {"Psi", "Ψ"},
        {"Omega", "Ω"},
        {"alpha", "α"},
        {"beta", "β"},
        {"gamma", "γ"},
        {"delta", "δ"},
        {"epsilon", "ε"},
        {"zeta", "ζ"},
        {"eta", "η"},
        {"theta", "θ"},
        {"iota", "ι"},
        {"kappa", "κ"},
        {"lambda", "λ"},
        {"mu", "μ"},
        {"nu", "ν"},
        {"xi", "ξ"},
        {"omicron", "ο"},
        {"pi", "π"},
        {"rho", "ρ"},
        {"sigmaf", "ς"},
        {"sigma", "σ"},
        {"tau", "τ"},
        {"upsilon", "υ"},
        {"phi", "φ"},
        {"chi", "χ"},
        {"psi", "ψ"},
        {"omega", "ω"},
        {"thetasym", "ϑ"},
        {"upsih", "ϒ"},
        {"piv", "ϖ"},
        {"bull", "•"},
        {"hellip", "…"},
        {"prime", "′"},
        {"Prime", "″"},
        {"oline", "‾"},
        {"frasl", "⁄"},
        {"weierp", "℘"},
        {"image", "ℑ"},
        {"real", "ℜ"},
        {"trade", "™"},
        {"alefsym", "ℵ"},
        {"larr", "←"},
        {"uarr", "↑"},
        {"rarr", "→"},
        {"darr", "↓"},
        {"harr", "↔"},
        {"crarr", "↵"},
        {"lArr", "⇐"},
        {"uArr", "⇑"},
        {"rArr", "⇒"},
        {"dArr", "⇓"},
        {"hArr", "⇔"},
        {"forall", "∀"},
        {"part", "∂"},
        {"exist", "∃"},
        {"empty", "∅"},
        {"nabla", "∇"},
        {"isin", "∈"},
        {"notin", "∉"},
        {"ni", "∋"},
        {"prod", "∏"},
        {"sum", "∑"},
        {"minus", "−"},
        {"lowast", "∗"},
        {"radic", "√"},
        {"prop", "∝"},
        {"infin", "∞"},
        {"ang", "∠"},
        {"and", "∧"},
        {"or", "∨"},
        {"cap", "∩"},
        {"cup", "∪"},
        {"int", "∫"},
        {"there4", "∴"},
        {"sim", "∼"},
        {"cong", "≅"},
        {"asymp", "≈"},
        {"ne", "≠"},
        {"equiv", "≡"},
        {"le", "≤"},
        {"ge", "≥"},
        {"sub", "⊂"},
        {"sup", "⊃"},
        {"nsub", "⊄"},
        {"sube", "⊆"},
        {"supe", "⊇"},
        {"oplus", "⊕"},
        {"otimes", "⊗"},
        {"perp", "⊥"},
        {"sdot", "⋅"},
        {"lceil", "⌈"},
        {"rceil", "⌉"},
        {"lfloor", "⌊"},
        {"rfloor", "⌋"},
        {"lang", "〈"},
        {"rang", "〉"},
        {"loz", "◊"},
        {"spades", "♠"},
        {"clubs", "♣"},
        {"hearts", "♥"},
        {"diams", "♦"},
        {"quot", "\""},
        {"amp", "\\&"},
        {"lt", "<"},
        {"gt", ">"},
        {"OElig", "Œ"},
        {"oelig", "œ"},
        {"Scaron", "Š"},
        {"scaron", "š"},
        {"Yuml", "Ÿ"},
        {"circ", "ˆ"},
        {"tilde", "˜"},
        {"ensp", " "},
        {"emsp", " "},
        {"thinsp", " "},
        {"ndash", "–"},
        {"mdash", "—"},
        {"lsquo", "‘"},
        {"rsquo", "’"},
        {"sbquo", "‚"},
        {"ldquo", "“"},
        {"rdquo", "”"},
        {"bdquo", "„"},
        {"dagger", "†"},
        {"Dagger", "‡"},
        {"permil", "‰"},
        {"lsaquo", "‹"},
        {"rsaquo", "›"},
        {"euro", "€"}]).

is_match(Subject, Match) when hd(Subject) == hd(Match) ->
        is_match(tl(Subject), tl(Match));
is_match(_, []) ->
        true;
is_match(_, _) ->
        false.

match(Subject, Match, Pos, first) when hd(Subject) == hd(Match) ->
    case is_match(Subject, Match) of
        true -> {match, Pos};
        false -> match(tl(Subject), Match, Pos + 1, first)
    end;

match(Subject, Match, Pos, Acc) when hd(Subject) == hd(Match) ->
    case is_match(Subject, Match) of
        true -> match(Subject, Match, Pos + 1, [Pos|Acc]);
        false -> match(tl(Subject), Match, Pos + 1, Acc)
    end;

match([], _, _, first) ->
    nomatch;

match([], _, [], []) ->
    nomatch;

match(Subject, Match, Pos, Mode) ->
    match(tl(Subject), Match, Pos + 1, Mode).

match(Subject, Match) ->
    match(Subject, Match, 0, first). 

replace(Subject, Match, Replacement) ->
    case match(Subject, Match) of
        {match, Pos} when is_list(Replacement) ->
            replace(lists:sublist(Subject, Pos) ++ Replacement ++ lists:nthtail(Pos + length(Match), Subject), Match, Replacement);
        {match, Pos} when is_integer(Replacement) ->
            replace(lists:append([lists:sublist(Subject, Pos), [Replacement], lists:nthtail(Pos + length(Match), Subject)]), Match, Replacement);
        nomatch ->
            Subject
    end.

extract(String, From, Through) ->
    case match(String, From) of
        {match, _From} ->  
            _Tail = lists:nthtail(_From, String), 
            case match(_Tail, Through) of
                {match, _Through} -> lists:sublist(_Tail, _Through + length(Through));
                _ -> nomatch
            end;
        _ -> nomatch
    end.


grab(URL, Default) -> 
    case httpc:request(get, {URL, []}, [{ssl,[{verify,verify_none}, {depth, 5}]}], [{body_format, binary}, {stream, self}, {sync,false}]) of
        {ok, ReqId} -> receive_stream(now(), URL, ReqId, Default);
        {error, _ } -> Default
    end.

grab(URL) ->
    case grab(URL, grabfail) of
        grabfail ->
            throw(grabfail);
        Title ->
            Title
    end.

trim(Title) ->
    lists:reverse(lists:nthtail(7, lists:reverse(string:strip(string:strip(Title, both, $\n), both, $ )))).

convert_entities(Title)->
    case extract(Title, "&", "\;") of
        nomatch ->
            Title;
        HTML_Entity ->
            "&" ++ Code = lists:reverse(tl(lists:reverse(HTML_Entity))),
            Character = case hd(Code) of
                $x -> binary_to_list(unicode:characters_to_binary([list_to_integer(tl(Code), 16)]));
                _ when hd(tl(Code)) >= $0 andalso hd(tl(Code)) =< $9 -> binary_to_list(unicode:characters_to_binary([list_to_integer(tl(Code))]));
                _ -> case lists:keyfind(Code, 1, ?HTML_ENTITIES) of
                        {Code, Char} when is_list(Char) -> Char;
                        {Code, Char} -> Char;
                        false -> HTML_Entity
                    end
            end,
            convert_entities(replace(Title, HTML_Entity, Character))
    end.

epower(FloatString) when hd(FloatString) == $e ->
    erlang:list_to_integer(tl(FloatString));

epower(FloatString) ->
    epower(tl(FloatString)).

decimals(FloatString) ->
    case epower(FloatString) of
        N when N < 0 ->
            lists:sublist("0." ++ lists:flatten([ "0" || _ <- lists:seq(2, abs(N))] ++ [ X || X <- FloatString, X /= $.]),abs(N) + 3);
        0 ->
            lists:sublist(FloatString,4);
        N -> 
            lists:sublist([ X || X <- FloatString, X /= $.], N+1)
    end.


diff_secs({_MYears1, Secs1, Usecs1}, {_MYears2, Secs2, Usecs2}) ->
    decimals(erlang:float_to_list(abs(Secs1 - Secs2) + (abs(Usecs1 - Usecs2) * math:pow(10,-6)))).

find_title(Markup, Default) ->
    find_title("", string:tokens(Markup, ">"), Default).

find_title(_, [], Default) ->
    Default;

find_title(Head, Tail, Default) when length(Head) > 5 ->
    case match(Head, "<title") of
        {match, _ } ->
            convert_entities(trim(hd(Tail)));
        _ ->
            find_title(hd(Tail), tl(Tail), Default)
    end;

find_title(_, Tail, Default) ->
    find_title(hd(Tail), tl(Tail), Default).

receive_stream(RequestTime, URL, ReqId, Default) ->
    receive 
        {http, {ReqId, stream_start, Headers}} -> 
            case match(read_header("content-type", Headers), "text/html") of
                {match, _} -> receive_stream(RequestTime, URL, ReqId, Default);
                _ -> Default
            end;
        {http, {ReqId, stream, Body}} -> 
            case read_chunk(Body, RequestTime, Default) of
                Default -> receive_stream(RequestTime, URL, ReqId, Default);	
                Title -> spawn(fun() -> receive_stream(RequestTime, URL, ReqId, Default) end), Title ++ " " ++ diff_secs(RequestTime, now()) ++ "s"
            end;
        {http, {ReqId, stream_end, _}} -> Default
    after 5000 -> Default
    end.

read_chunk(Data, RequestTime, Default) when is_binary(Data) ->
    read_chunk(binary_to_list(Data), RequestTime, Default);

read_chunk(Data, _RequestTime, Default) ->
    case find_title(Data, Default) of
        Default ->
            Default;
        Title ->
            Title 
    end.

read_header(_Info, []) ->
    "text/unknown";

read_header(Info, [{Info, Value}|_]) ->
    Value;

read_header(Info, [{_, _}|T]) ->
    read_header(Info, T).

eunit_test_() ->
    Match = [ {"match test 1", ?_assertMatch({match, 0}, match("heyhey", "he"))},
                  {"match test 2", ?_assertMatch({match, 2}, match("heyhey", "yh"))},
                  {"match test 3", ?_assertMatch(nomatch, match("heyhey", "xoxo"))}],

    Replace = [ {"replace test 1", ?_assertMatch("hoho", replace("heyhey", "ey", "o"))},
                    {"replace test 2", ?_assertMatch("hey", replace("heyhey", "yhe", ""))},
                    {"replace test 3", ?_assertMatch("heyhey", replace("heyhey", "xoxo", "no"))}],

    Extract = [ {"extract test 1", ?_assertMatch("yzqw", extract("xyzqwe", "y", "w"))},
                    {"extract test 2", ?_assertMatch("zq", extract("xyzqwe", "zq", "q"))},
                    {"extract test 3", ?_assertMatch(nomatch, extract("xyzqwe", "qwe", "xyz"))}],

    Grab = [ {"erlang.org", ?_assertMatch("Erlang Programming Language" ++ _, grab("http://www.erlang.org")) },
                 {"news.ycombinator.com", ?_assertMatch("Hacker News" ++ _, grab("https://news.ycombinator.com")) },
                 {"github.com", ?_assertMatch("GitHub" ++ _, grab("https://www.github.com")) } ],

    Entity = [ {"euro", ?_assertMatch("€€€", convert_entities("&euro;&#8364;&x20AC;")) },
              {"snowmen", ?_assertMatch("☃⛄⛇", convert_entities("&x2603;&#9924;&#9927;")) }],

    [{"Utility tests", {foreach, fun () -> ok end, [[Match | Replace] | Extract]}}, 
     {"HTML Entity conversion tests", {foreach, fun () -> ok end, Entity}},
     {"Grabbing websites", {foreach, fun () -> application:start(?MODULE) end, Grab}}].


