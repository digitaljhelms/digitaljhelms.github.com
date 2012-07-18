---
layout: post
title: "Creating a Git Branch w/out Parents"
categories: []
tags: [git]
date: 2012-07-02 17:05:35
published: true
---
{% include JB/setup %}

`git checkout` has an `--orphan` option that will create a branch with no "parents" or relation at all to other branches/commits in the repository.

From the man page:

> Create a new *orphan* branch, named \<new_branch>, started from \<start_point> and switch to it. The first commit made on this new branch will have no parents and it will be the root of a new history totally disconnected from all the other branches and commits.
>  
> The index and the working tree are adjusted as if you had previously run `git checkout <start_point>`. This allows you to start a new history that records a set of paths similar to \<start_point> by easily running `git commit -a` to make the root commit.
>  
> This can be useful when you want to publish the tree from a commit without exposing its full history. You might want to do this to publish an open source branch of a project whose current tree is "clean", but whose full history contains proprietary or otherwise encumbered bits of code.
>  
> If you want to start a disconnected history that records a set of paths that is totally different from the one of \<start_point>, then you should clear the index and the working tree right after creating the orphan branch by running `git rm -rf .` from the top level of the working tree. Afterwards you will be ready to prepare your new files, repopulating the working tree, by copying them from elsewhere, extracting a tarball, etc.

When I shared this "feature" with a few colleagues, one response I received was:

> "bizarre -- why would you want that?"

A few possibilities:

1. **Documentation** -- An *orphan* branch could be used to house your documentation within the project repository itself while keeping it from polluting actual code branch(es); the "documentation" branch would have it's own history, including initial commit and working tree. The documentation could even still be in wiki format, perhaps using Jekyll for static file generation.
2. **Local Bootstrapping** -- Things like database schemas, sample data, and bootstrapping scripts for preparing a local development environment could live in an *orphan* branch, again, to keep from polluting the actual code branch(es) with material not frequently used.
3. **Testing & Deployment** -- Running scripts and utilities used to test, build, compile, and deploy a project is often the responsibility of a small subset of people on the project team (possibly only a single person) so these resources could easily be pushed into an *orphan* branch.

Obviously there are other ways to handle all of these possibilities; for instance, hosting documentation in a GitHub Wiki, or pushing resources for bootstrapping, testing, and deployment into various `git-submodules` that are initialized/updated only if necessary.

Regardless of the use-case, something to keep in mind when using an *orphan* branch: Communicate clearly to others who may interact with the repository what the branch is and how to work with it; blindly stumbling across an *orphan* branch could be pretty confusing.
