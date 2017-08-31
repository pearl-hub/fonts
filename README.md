Fonts
=====

|Project Status|Communication|
|:-----------:|:-----------:|
|[![Build status](https://api.travis-ci.org/pearl-hub/fonts.png?branch=master)](https://travis-ci.org/pearl-hub/fonts) | [![Join the gitter chat at https://gitter.im/pearl-core/pearl](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/pearl-core/pearl?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) |

**Table of Contents**
- [Description](#description)
- [Installation](#installation)
- [Troubleshooting](#troubleshooting)

Description
===========

- name: `fonts`
- description: A handy collection of fonts ready to use
- author: Filippo Squillace
- username: fsquillace
- OS compatibility: linux, osx

The list of available fonts are:

- [Powerline fonts](https://github.com/powerline/fonts)
- [Awesome terminal fonts](https://github.com/gabrielelana/awesome-terminal-fonts)
- [Adobe fonts](https://github.com/adobe-fonts)
  - [Source code pro](https://github.com/adobe-fonts/source-code-pro)
  - [Source sans pro](https://github.com/adobe-fonts/source-sans-pro)
  - [Source serif pro](https://github.com/adobe-fonts/source-serif-pro)
- [Cantarell fonts](https://github.com/GNOME/cantarell-fonts)
- [Ubuntu fonts](http://font.ubuntu.com/)

Installation
============
This package can be installed via [Pearl](https://github.com/pearl-core/pearl) system.

```sh
pearl install fonts
```

Dependencies
------------
The `fonts` package requires to have the
[GNU findutils](https://www.gnu.org/software/findutils/) commands for finding
all the installed fonts that needs to be
removed during the [removal of the package](https://github.com/pearl-core/pearl#remove).

In OSX `findutils` is available via [Homebrew](https://brew.sh/index_it.html).

Troubleshooting
===============
This section has been left blank intentionally.
It will be filled up as soon as troubles come in!

