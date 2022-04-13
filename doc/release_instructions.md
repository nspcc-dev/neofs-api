# Release instructions

This documents outlines the neofs-api release process and can be used as a TODO
list for a new release.

## Pre-release checks

This should run successfully:
* `make lint`

## Pre-release actions

This must be run:
* `make doc`

## Writing CHANGELOG

Add an entry to the CHANGELOG.md following the style established there.

Add a codename for releases with the new major version, version and release date in
the heading. Write a paragraph describing the most significant changes done in
this release. Then add sections with what has been added, changed and removed,
describing each change briefly with a reference to GitHub issues, where
available.

## Release commit

Release commit summary should follow the template:

`Release v<Version> - <Codename island> (<Hangeul>, <Hanja>)`, e.g.:

```
Release v2.9.0 - Anmyeondo (안면도, 安眠島)
```

## Tag the release

Use `vX.Y.Z` tag following the semantic versioning standard. For pre-release
versions use `vX.Y.Z-rc.N` scheme.

## Push changes and release tag to Github

This step should bypass the default PR mechanism to get a correct result (so
that releasing requires admin privileges for the project), both the `master`
branch update and tag must be pushed simultaneously like this:

```
$ git push origin master v2.7.0
```

## Make a proper Github release

Edit an automatically-created release on Github.

Release title has to follow `<version> <Romanized codename> (<Hangeul, Hanja
codename> )` scheme for major releases and just `<version>` for regular point
releases.

## Post-release actions

* Close corresponding X.Y.Z Github milestone
* Make announcements in Matrix and Discord channels
* Update [NeoFS Technical Specification](https://github.com/nspcc-dev/neofs-spec)
