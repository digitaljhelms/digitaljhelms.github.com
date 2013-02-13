---
layout: post
title: "Sublime Text 2 CLI Project Helper"
categories: []
tags: [git, bash, st2]
date: 2012-06-28 15:08:31
published: true
---
{% include JB/setup %}

With this this helper function you can open a Sublime Text 2.0 project file (ex: `foobar.sublime-project`) from the command-line by simply typing `st -p foobar` instead of `subl --project foobar.sublime-project`. In the case where you have an existing ST2 window open, the project will always be opened in a new ST2 window.

You can also supply additional ST2 options, such as the `-b` flag to open ST2 in the background, in the arguments list. One caveat to this is that, because `getopts` isn't being used to parse the options passed to bash, the `-p` flag and the project file "shortname" must be the first and second option passed to the shell function -- basically, you can't do `st -b -p lig`, you have to do `st -p lig -b`.

```sh ST2 bash alias & CLI function https://gist.github.com/digitaljhelms/3014302 gistfile1.sh
# bash alias
alias subl='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'

# bash function, usage: $ st -p [projectname] -opt2 -opt3
function st() {
  if [ -n "$1" -a -n "$2" ]; then # if more than one argument
    if [ "$1" = "-p" -o "$1" = "--project" ]; then # if arg1 is -p or --project
      local projectfile="$2"
      [[ $projectfile != *.sublime-project ]] && projectfile="$2.sublime-project" # detect if arg2 already includes the ext
      if [ -e $projectfile ]; then # does project file exist?
        subl -n --project $projectfile ${*:3} # open project file, in new window, include trailing args
        #echo "project specified, and project file exists, execute: subl -n --project $projectfile ${*:3}"
      else
        subl ${*:3} # open sublime but drop -p||--project and project name from args
        #echo "project specified, but project file doesn't exist, execute: subl ${*:3}"
      fi
    else
      subl $* # open sublime and pass args as usual
      #echo "project argument not passed, execute: subl $*"
    fi
  else
    subl $* # open sublime and pass args as usual
    #echo "only 1 argument passed, execute: subl $*"
  fi
}
```

I've included a bit of rudimentary logic to ensure the project shortname you're passing actually matches a project file in the current directory, and if no match is found, the `-p` flag and project "shortname" are dropped from the command arguments (while the rest of the options remain) and ST2 is opened with an empty window (or new file, however you have configured ST2). May not be the desired behavior for some, but it works for me...
