---
layout: post
title: "Build & Install Git on OS X Lion"
categories: []
tags: [git, osx]
date: 2012-06-14 10:07:21
published: true
---
{% include JB/setup %}

This outline for building and installing Git has only been tested against Mac OS X 10.7.x (Lion). While these steps may work for previous versions of Mac OS X, I cannot confirm this. *Furthermore, you're on your own, if you screw something up, it's not my fault.*

## If you have Xcode 4, you have Git!

Xcode 4 includes the Git binary at the application level so it's available to itself (located at `/Applications/Xcode.app/Contents/Developer/usr/bin/git`). Additionally, Xcode 4 includes a new "Downloads" preference pane to install optional components, one of which are the Command Line Tools (similar to the Dev Tools package that shipped with older versions of Xcode) and once installed, Git (and many other utilities, such as `make`) is installed at the system level (located at `/usr/bin`).

*Note: You don't have to install Xcode to use the Command Line Tools; it can be downloaded independently from the Apple Developer site (you need to login, but it's free). Here's a direct link for the June 2012 download (dmg file): [http://bit.ly/xcodeclt_062012](http://bit.ly/xcodeclt_062012)*

### If you don't want to use the version provided by Apple...

Now, because the the Git binary provided by Apple is placed in `/usr/bin` you need to make sure your `$PATH` environment variable is setup properly (see below) and that you install your own build of Git into `/usr/local/bin` for two reasons:

1. Apple will silently overwrite whatever Git binary lives at `/usr/bin` whenever Xcode and/or the Command Line Tools are updated.
1. If `/usr/bin` is in the `$PATH` variable BEFORE the location where you install your own build of the Git binary (I'm suggesting `/usr/local/bin/git`) then the Apple binary located at `/usr/bin/git` will always be used when the git command is run.

Unfortunately, Apple doesn't make managing the `$PATH` environment variable easy -- there are nearly a dozen ways this variable can be set or changed. I've done plenty of digging on this topic over the years, and here's the skinny (to my knowledge) listed in order of operation:

* `/etc/profile` (interactive login shell, or as a non-interactive shell with the `--login` option, if exists)
* `/etc/paths` (relies on `/usr/libexec/path_helper` being called from `/etc/profile`)
* `/etc/paths.d/*` (relies on `/usr/libexec/path_helper` being * called from `/etc/profile`)
* `/etc/bashrc` (sourced from `/etc/profile`, if exists)
* `~/.bash_profile` (if exists)
* `~/.bashrc` (optional, usually sourced from `.bash_profile`, if exists)
* `~/.bash_login` (if `.bash_profile` does not exist)
* `~/.profile` (if `.bash_login` does not exist)
* `~/.MacOSX/environment.plist` (searched by `loginwindow`, useful for paths needed by CLI daemons)

It's easy to get all twisted up here, but all you need to do is ensure `/usr/local/bin` is in the `$PATH` variable BEFORE `/usr/bin`. For me that simply meant reordering the directories listed in `/etc/paths` to the following, ensuring `/usr/local/bin` is first:

```
/usr/local/bin
/usr/bin
/usr/sbin
/bin
/sbin
```

*Note: When making `$PATH` changes, you'll likely need to restart your console session (either a new window or a new tab) to test/verify your changes (which is as easy as `$ echo $PATH`).*

## Building the Git binary

There are two ways to do this, the first uses Git (if you've installed Command Line Tools, either with or without Xcode) and the second simply downloads a compressed archive of the files needed from the Google project page.

#### Use Git to download Git

``` sh
$ git clone git://github.com/gitster/git.git`
$ cd git`
$ git fetch`
$ git tag -v v1.7.10.4` # verify latest stable tag
$ git checkout v1.7.10.4` # checkout latest stable tag
```

#### Download the Git files

``` sh
$ curl -O http://git-core.googlecode.com/files/git-1.7.10.4.tar.gz` # download the latest stable from [Google code](http://code.google.com/p/git-core/downloads/list)
$ tar -xzvf git-1.7.10.4.tar.gz
$ cd git-1.7.10.4
```

### Configure & Build

``` sh
$ make configure` # this is optional, requires GNU Autoconf be installed
$ ./configure --prefix=/usr/local` # you can only run this if you've run the command above
$ make prefix=/usr/local`
$ sudo make prefix=/usr/local install`
```

## Building the Git documentation

A whole separate mission is getting the Git documentation to build on OS X. For the sake of time, here are the steps, and if anyone decides to dive in, feel free to ping me with questions on how I did it.

* Install AsciiDoc
* Install xmlto
   * Install getopt
   * Install gettext
   * Install DocBook

``` sh
$ make prefix=/usr/local doc
$ sudo make prefix=/usr/local install-doc
```

### An alternative (read FASTER/BETTER/EASIER) method...

If you're lazy (I wasn't, however I didn't learn about this "alternative" method until AFTER going through the steps above) there's a MUCH easier way to install the Git documentation:

``` sh
$ cd .. # the directory where you cloned the git repo (not into the git repo directory, but it's parent)
$ git clone https://github.com/gitster/git-manpages.git
$ cd git
$ make prefix=/usr/local
$ sudo make quick-install-man
```

## tl;dr

This isn't for the faint of heart. If you skipped to down here, you should probably just download the [Git OS X Installer](http://code.google.com/p/git-osx-installer/) package (generally one maintenance release behind latest), or use MacPorts or Homebrew both of which are current to the latest stable release of Git.

## Reference Links

* https://github.com/git/git/blob/master/INSTALL
* http://ayanim97.com/mac/installing-and-upgrading-git-mac-os-lion
* https://wincent.com/wiki/Installing_Git_1.7.9.3_on_Mac_OS_X_10.7.3
* https://wincent.com/wiki/Updating_to_Git_1.7.10_on_Mac_OS_X_10.7.3
* https://wincent.com/wiki/Setting_up_the_Git_documentation_build_chain_on_Mac_OS_X_Leopard
* https://wincent.com/wiki/Installing_pre-built_Git_documentation_from_the_Git_repo#comment_7325
