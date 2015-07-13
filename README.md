URL Title Grabber
=====

A simple module that extracts the title of a given URL.

### Features

  - Reads markup chunk-wise, so it's rather fast 
  - converts HTML entitites to their UTF-8 counterpart

Build
-----

    $ rebar3 compile

API
-----

### get_title(URL, Default) -> string()
    URL = string() | binary()
    Default = term()

    Attempts to get the title of URL. 
    Returns Default if the title could not be found or throw an exception if a connection error has occured.
