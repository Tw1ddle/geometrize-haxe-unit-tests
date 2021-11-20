[![Project logo](https://github.com/Tw1ddle/geometrize-haxe-unit-tests/blob/master/screenshots/logo.png?raw=true "Geometrize Haxe - recreating images as geometric shapes unit tests logo")](https://www.samcodes.co.uk/project/geometrize-haxe-web/)

[![Travis Unit Test Build Status](https://img.shields.io/travis/Tw1ddle/geometrize-haxe-unit-tests.svg?style=flat-square)](https://travis-ci.org/Tw1ddle/geometrize-haxe-unit-tests)
[![Geometrize Build Status](https://ci.appveyor.com/api/projects/status/github/Tw1ddle/geometrize-haxe-unit-tests)](https://ci.appveyor.com/project/Tw1ddle/geometrize-haxe-unit-tests)

This is the unit test suite for Geometrize Haxe, a Haxe library for recreating images with geometric primitives. The intent is to achieve good test coverage of the codebase, and to add regression tests for fixed bugs.

The tests are run through CI on [Travis](https://travis-ci.org/Tw1ddle/geometrize-haxe-unit-tests) using the Travis helper [Travix](https://github.com/back2dos/travix).


[![Geometrized Cat](https://github.com/Tw1ddle/geometrize-haxe-unit-tests/blob/master/screenshots/gustave_courbet.jpg?raw=true "The Desperate Man")](https://www.samcodes.co.uk/project/geometrize-haxe-web/)

## Setup

```
haxelib install sure
haxelib install utest
```

## Usage

Open and build the FlashDevelop project in this directory to run the tests. Edit *run_tests_local.hxml* to change the platform to test locally.