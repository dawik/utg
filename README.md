URL Title Grabber
=====

A little library that attempts to retreive the title of a given website.

### Features

  - Reads markup chunk-wise, so it's rather fast 
  - converts HTML entitites to their UTF-8 counterpart

Build
-----

    % rebar3 compile

Tests
-----

    % rebar3 eunit --verbose

API
-----

### grab(URL) -> string()
### grab(URL, Default) -> string()
    URL = string() | binary()
    Default = term()

    Attempts to get the title of URL, returns Default if the title could not be found otherwise throws an exception if an error has occured.
