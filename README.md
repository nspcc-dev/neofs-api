<p align="center">
<img src="./.github/logo.svg" width="500px" alt="NeoFS">
</p>
<p align="center">
  <a href="https://fs.neo.org">NeoFS</a> API language-agnostic protocol definitions
</p>

---
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/nspcc-dev/neofs-api?sort=semver)
![License](https://img.shields.io/github/license/nspcc-dev/neofs-api.svg?style=popout)

## Overview

NeoFS-API repository is the basis for language-specific libraries, e.g.:

- [neofs-sdk-go](https://github.com/nspcc-dev/neofs-sdk-go) (see `proto` package there for vanilla API)
- [neofs-api-csharp](https://github.com/nspcc-dev/neofs-api-csharp)

Those libraries contain compiled protocol buffers definitions, wrapped with
language-specific code. Use them to integrate applications with NeoFS.

This repository contains:

- protocol buffers packages
- [auto-generated docs](proto-docs) for protocol buffers

To perform linting and formatting buf is required, see https://buf.build/.

## Contributing

Feel free to contribute to this project after reading the [contributing
guidelines](CONTRIBUTING.md).

Before you start working on a certain topic, first create a new issue
describing the feature/topic you are going to implement.

## License

This project is licensed under the Apache 2.0 License -
see the [LICENSE](LICENSE) file for details
