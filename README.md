[![Project logo](https://github.com/Tw1ddle/geometrize-haxe-unit-tests/blob/master/screenshots/logo.png?raw=true "Geometrize Haxe - recreating images as geometric shapes unit tests logo")](https://www.samcodes.co.uk/project/geometrize-haxe-web/)

[![License](https://img.shields.io/:license-mit-blue.svg?style=flat-square)](https://github.com/Tw1ddle/geometrize-haxe-unit-tests/blob/master/LICENSE)
[![Geometrize Haxe Unit Tests Build Status](https://ci.appveyor.com/api/projects/status/github/Tw1ddle/geometrize-haxe-unit-tests)](https://ci.appveyor.com/project/Tw1ddle/geometrize-haxe-unit-tests)

This is the unit test suite for Geometrize Haxe, a Haxe library for recreating images with geometric primitives. The intent is to achieve good test coverage of the codebase, and to add regression tests for fixed bugs.

[![Geometrized Cat](https://github.com/Tw1ddle/geometrize-haxe-unit-tests/blob/master/screenshots/gustave_courbet.jpg?raw=true "The Desperate Man")](https://www.samcodes.co.uk/project/geometrize-haxe-web/)

## Setup

```
haxelib install sure
haxelib install utest
```

## Building

Either open the project folder in VSCode, or run the build script from the command line:

```
./build_and_run_tests.sh
```

The test results will be printed to console:

[![Geometrize Haxe Unit Test Results](https://github.com/Tw1ddle/geometrize-haxe-unit-tests/blob/master/screenshots/test_output.png?raw=true "Geometrize Haxe Unit Test Results")](https://www.geometrize.co.uk/)