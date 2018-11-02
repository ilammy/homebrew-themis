# homebrew-themis

[![Build Status](https://travis-ci.org/ilammy/homebrew-themis.svg?branch=master)](https://travis-ci.org/ilammy/homebrew-themis)

Homebrew formulas for [Themis] crypto library.

[Themis]: https://github.com/cossacklabs/themis

## Installation

The formulas aren't the part of the core Homebrew repository
so you will need to add this repository as a new _tap_:

```console
brew tap ilammy/homebrew-themis
```

Then you may install the latest stable release:

```console
brew install themis
```

In order to upgrade run this:

```console
brew update
brew upgrade themis
```

## Selecting Crypto Backend

Themis leverages existing cryptographic libraries for its operation.
Currently BoringSSL, LibreSSL, OpenSSL are supported as engine backends.
You may select the backend by installing an appropriate Themis flavor:

- `themis` (BoringSSL is the default)
- `themis-openssl`
- `themis-libressl`

By default, Themis uses its own private version of BoringSSL.
OpenSSL and LibreSSL flavors use libraries provided by Homebrew,
they will be pulled and installed automatically if necessary.

Please note that you cannot have multiple flavors simultaneously _linked_
(installed into the default search path).
You can have them installed and available for applications,
but you must `brew unlink` them to avoid conflicts.

## Usage

By default,
Themis installation will be linked into `/usr/local/include` and `/usr/local/lib`.
With this the library is available in the standard search path for compilers.

You can check the installation like this
by asking Homebrew to compile a simple C program linking it against Themis:

```console
brew test themis
```

## Licensing

The code is distributed under [Apache 2.0 license](LICENSE).
