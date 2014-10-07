autorun
=======
[![Build Status](https://travis-ci.org/yamadapc/autorun.svg?branch=master)](https://travis-ci.org/yamadapc/autorun)
[![Gitter chat](https://badges.gitter.im/yamadapc/autorun.png)](https://gitter.im/yamadapc/autorun)
- - -
Run ~~all~~ *lots of* source-code files on any system with [`Docker`](https://docker.com)
and a binary, without having to install anything else.

*It's still in an almost shameful state of development and is just 46L trivial
lines of code - which don't really work that well... :P But it currently stands
as a PoC, more than anything else. It also only runs JS... hehehe*

## Installing
I'm really sorry to say that this currently only compatible with linux. This is
due to a [docker bug which prevents us from mounting volumes when the docker
daemon is running remotely](https://github.com/docker/docker/issues/4023) (I
took an infinite amount of time to figure that out). Also, since `sudo` is
required, `cabal install` won't work :P.

This makes the current state of the project a little unusable, but that's
alright.

That being said:
```
git clone https://github.com/yamadapc/autorun
cd autorun
cabal install --only-dependencies
cabal build
sudo cp dist/build/autorun/autorun /usr/bin # Or something like this
```

These are the instructions required to test on the vagrant vm, which is the only
tested environment so far.

## Usage
```
$ echo "console.log('hello world')" > something.js
$ sudo autorun something.js # Sadly sudo is currently needed

hello world
```

## License
This code is released under the GPLv2 license for Pedro Tacla Yamada. Please
refer to [LICENSE](/LICENSE) for more information.
