# homebrew-themis

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
brew install themis-openssl
```

In order to upgrade run this:

```console
brew update
brew upgrade themis-openssl
```

## Selecting Crypto Backend

Currently Themis leverages existing cryptographic libraries for its operation.
Themis supports OpenSSL, LibreSSL, and BoringSSL as engine backends.
Homebrew core currently provides only OpenSSL and LibreSSL.
You need to select the backend by installing an appropriate Themis flavor:

- `themis-openssl`
- `themis-libressl`

The appropriate backend library will be pulled and installed automatically.

Please note that you cannot have both flavors simultaneously _linked_
(installed into the default search path).
You can have both available, but first you must `brew unlink` one of them.

## Usage

By default,
Themis installation will be linked into `/usr/local/include` and `/usr/local/lib`.
With this the library is available in the standard search path for compilers.

You can check the installation like this
by asking Homebrew to compile a simple C program linking it against Themis:

```console
brew test themis-openssl
```

## Licensing

The code is distributed under [Apache 2.0 license](LICENSE).
