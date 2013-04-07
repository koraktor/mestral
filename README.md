Mestral
=======

[![Build Status](https://travis-ci.org/koraktor/mestral.png?branch=master)](https://travis-ci.org/koraktor/mestral) [![Coverage Status](https://coveralls.io/repos/koraktor/mestral/badge.png?branch=master)](https://coveralls.io/r/koraktor/mestral) [![Dependency Status](https://gemnasium.com/koraktor/mestral.png)](https://gemnasium.com/koraktor/mestral)

A hook manager for Git

## Installation

Mestral can be installed via a simple installation script:

```sh
$ ruby -e "$(curl -fLsS https://raw.github.com/koraktor/mestral/install)"
```

On Unix-like system, this will install Mestral into `/usr/local/mestral`. On
Windows, this will install Mestral into `%ALLUSERSPROFILE%/Mestral`. An
executable called `git-hooks` will be put into place, so you can run Mestral
using `$ git hooks`.

You can also clone the Git repository and symlink the executable into your
`$PATH`. For example:

```sh
$ git clone http://github.com/koraktor/mestral.git
$ ln -s mestral/bin/mestral /usr/local/bin/mestral
$ ln -s mestral/bin/mestral /usr/local/bin/git-hooks
```

## License

This code is free software; you can redistribute it and/or modify it under the
terms of the new BSD License. A copy of this license can be found in the
LICENSE file.

## Credits

* Sebastian Staudt – koraktor(at)gmail.com
