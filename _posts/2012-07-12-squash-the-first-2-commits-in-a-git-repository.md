---
layout: post
title: "Squash the First 2 Commits in a Repo"
categories: []
tags: [git]
date: 2012-07-12 20:58:10
published: true
---
{% include JB/setup %}

## The scenario

Your repository has two commits:

``` sh
$ git log --oneline
957fbfb No, I am your father.
9bb71ff A long time ago in a galaxy far, far away....
```

Use the interactive rebase tool to squash the two commits:

``` sh
$ git rebase -i 9bb71ff
```

When your editor opens, only a single commit is listed:

    pick 957fbfb No, I am your father.

You change `pick` to `squash`, save & close your editor.

## The problem

Git complains...

``` sh
Cannot 'squash' without a previous commit
```

## The fix

``` sh
$ git rebase -i 9bb71ff
```

This time, when your editor opens, change `pick` to `edit` instead of `squash`, save & close your editor.

``` sh
$ git reset --soft HEAD^
$ git commit --amend
```

Your editor again so that you can modify the commit message of the soon-to-be squashed commit; make your changes, save & close the editor.

``` sh
$ git rebase --continue
```
