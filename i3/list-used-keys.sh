#!/bin/bash

# PRints what one letter keybinds are in use
ag "^bindsym \\\$mod\+[a-z] " . --nonumber | sort
