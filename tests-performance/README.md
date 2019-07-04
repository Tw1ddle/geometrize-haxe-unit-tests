# Performance, integration tests for geometrize-haze library.

These tests are not meant to be executed in travis. The idea is to be personal developer tests to compare, in the same machine, the evolution of speed in the short term when implementing / fixing important things. 

## Usage

 * Install lime https://lime.software/docs/home/ . The command `lime` should work

```
cd tests-performance
lime test cpp
```

It takes a while. Each tests writes the result images as svg in this folder.


## haxe/lime beginner notes

## Objective 

 * write the whole user experience in haxe to execute it in Node.js and C++ or similar targets
 * document it
 * write tests based on that to measure performance.

## targets

Personally interested in JavaScript performance but don't want to impact in people that might be targetting other languages. I think the next choice is Cpp since is not interpreted and popular(?) than the rest.
Must have: 

- [x] cpp 
- [ ] node.js
 
## Nice to have
- [ ] browser (hard to measure / compare)
- [ ] Java 
- [ ] Python
- [ ] neko didn't work, (too slow hangs)
 
## why lime ? 

 * to load PNG images from files - I fail loading with other libs
 * Have the possibility to display the result images 
 <!-- * and progress and measure also that. -->
 <!-- * using the same API in different targets results / animations / progress -->
 * possibility of measure rendering progress on each step in different technologies
   * research efficient ways of rendering the progress



   