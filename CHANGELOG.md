# Changelog

## [0.7.1] - 2020-04-20

### Added

- Method to change current node state. (`state.ChangeState`)

## [0.7.0] - 2020-04-16

### Added

- A numerical field CopiesNumber into `object.PutRequest.PutHeader` message.

## [0.6.1] - 2020-04-15

### Added

- State field into Bootstrap request.
- Request.State enum: Unknown, Online, Offline.

## [0.6.0] - 2020-04-02

### Added

- ACL package with enum of ACL targets.

### Changed

- Use `BasicACL` field in container structure and `container.Put` request.

## [0.5.0] - 2020-04-01

- Initial release

[0.5.0]: https://github.com/nspcc-dev/neofs-api/releases/tag/v0.5.0
[0.6.0]: https://github.com/nspcc-dev/neofs-api/compare/v0.5.0...v0.6.0
[0.6.1]: https://github.com/nspcc-dev/neofs-api/compare/v0.6.0...v0.6.1
[0.7.0]: https://github.com/nspcc-dev/neofs-api/compare/v0.6.1...v0.7.0
[0.7.1]: https://github.com/nspcc-dev/neofs-api/compare/v0.7.0...v0.7.1
