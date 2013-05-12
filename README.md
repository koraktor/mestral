Mestral
=======

[![Build Status](https://travis-ci.org/mestral/mestral.png?branch=master)](https://travis-ci.org/mestral/mestral) [![Coverage Status](https://coveralls.io/repos/mestral/mestral/badge.png?branch=master)](https://coveralls.io/r/mestral/mestral) [![Dependency Status](https://gemnasium.com/mestral/mestral.png)](https://gemnasium.com/mestral/mestral)

A hook manager for Git

## About

Mestral allows to easily manage your Git hooks. Combine so called *hooklets* to
form the hooks fitting your needs.

## Installation

Mestral can be installed via a simple installation script:

```sh
$ ruby -e "$(curl -fLsS https://raw.github.com/mestral/mestral/install/install.rb)"
```

On Unix-like system, this will install Mestral into `/usr/local/mestral`. On
Windows, this will install Mestral into `%ALLUSERSPROFILE%/Mestral`. An
executable called `git-hooks` will be put into place, so you can run Mestral
using `$ git hooks`.

You can also clone the Git repository and symlink the executable into your
`$PATH`. For example:

```sh
$ git clone http://github.com/mestral/mestral.git
$ ln -s mestral/bin/mestral /usr/local/bin/mestral
```

Additionally, you might want to add it as a command to Git, for example:

```sh
$ ln -s mestral/bin/mestral /usr/local/bin/git-hooks
```

## Getting started

Initially, you should add a hook repository, also known as a *tape*.

```sh
$ mestral add-tape https://github.com/mestral/tape
```

After that, list the available *hooklets*…

```sh
$ mestral list
```

… and enable those you like for the current Git repository:

```sh
$ mestral enable pre-commit check-whitespace
```

## License

This code is free software; you can redistribute it and/or modify it under the
terms of the new BSD License. A copy of this license can be found in the
LICENSE file.

## Credits

* Sebastian Staudt – koraktor(at)gmail.com
