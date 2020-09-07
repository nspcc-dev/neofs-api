# Changelog

## [2.0.0] - 2020-09-07 - Jindo (진도, 珍島)

Major API refactoring and simplification.

### Added
- `neo.fs.v2` prefix added to all package names
- `container.Attributes` field added
- `refs.ContainerID` added as a separate type
- `refs.OwnerID` added as a separate type
- Object Search query language defined in `object.SearchRequest.Body.filter`
- `netmap` package added
- `refs.Signature` defined as a separate type
- `session.SessionToken` now has context information for each service
- `refs.Version` defined as a separate type
- `refs.Version` field added to all messages stored in SmartContracts
- `refs.Checksum` defined as a separate type
- `netmap.LocalNodeInfo` request added to get actual information from connected peer

### Changed
- Extended ACL Table format changed
- Protobuf definitions style changed to follow Google Style Guide
- `System` and `Extended` Object headers are merged into on `object.Header` type
- `object.UserHeader` renamed to `object.Header.Attribute`
- `refs.ObjectID` is now a hash of the `object.Header` field, which contains hash of payload
- `StorageGroup` information moved to Object's payload
- `netmap.NodeInfo.options` renamed to `netmap.NodeInfo.attributes` and it uses a
  separate `netmap.NodeInfo.Attribute` type now.
- `netmap.NodeInfo.Attribute` type now has a list of parents to construct a tree
- Session Token renamed to `session.SessionToken` from `session.Token`
- All Requests and Responses now have a common "body-meta-verify" structure
- Meta and Verification headers now follow Matryoshka-style composition
- SessionToken and BearerToken are now part of Meta header
- Object placement policy format is simplified and defined in `netmap` package
- `object.Head()` request now returns either short header or full header with a signature

### Removed
- gogoproto is not used anymore
- `decimal` package merged into `accounting` package
- `query` package merged into `object` package
- `storagegroup` package merged into `object` package
- `bootstrap` package merged into `netmap` package
- `state` package removed
- `service` package removed. Merged with `session` package
- `state` package removed. It will be implementation specific part of neofs-node
- `SpreadMap` functionality removed from `netmap` package
- Unixtime support removed from creation timestamps, leaving only Epoch number
- `Link` type removed from Object headers
- `Redirect` type support removed from Object headers
- Withdrawal and Account Lock functionality removed from `accounting` service
- Deposit functionality removed from `accounting` service
- Settlement functionality removed from `accounting` service

## [1.2.0] - 2020-07-08

### Added

- ```acl.EACLRecord```, ```acl.EACLTable``` messages for the table of extended ACL rules.

## [1.1.0] - 2020-06-18

### Added

- Extended ACL support in container service.
- Bearer token support in the object service requests.
- Extended headers for the requests in `service.RequestMetaHeader`

## [1.0.0] - 2020-05-16

Bump major release

## [0.7.5] - 2020-05-15

### Added

- `OwnerKey` bytes field to `service.Token.TokenInfo` message.


## [0.7.4] - 2020-05-08

### Added

- `service.TokenLifetime` message.

### Changed

- `service.Token` structure.
- `session.Session.Create` RPC signature.
- `session.CreateRequest` structure.
- `session.CreateResponse` structure.

## [0.7.3] - 2020-04-28

### Changed

- `CreationPoint` disabled stringer method.

## [0.7.2] - 2020-04-28

### Added

- `Raw` boolean field to `service.RequestMetaHeader`.
- `Token` message field to `service.RequestVerificationHeader`.

### Replaced

- `Token` message from `session` to `service` package.
- `Signature` message with `Sign` one in `service` package.

### Changed

- `Token` message structure.

### Removed

- `Raw` field from `object.GetRequest` and `object.HeadRequest` messages.
- `Token` field from `object.PutRequest.PutHeader` and `object.DeleteRequest` messages.
- `VerificationHeader` message.

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
[0.7.2]: https://github.com/nspcc-dev/neofs-api/compare/v0.7.1...v0.7.2
[0.7.3]: https://github.com/nspcc-dev/neofs-api/compare/v0.7.2...v0.7.3
[0.7.4]: https://github.com/nspcc-dev/neofs-api/compare/v0.7.3...v0.7.4
[0.7.5]: https://github.com/nspcc-dev/neofs-api/compare/v0.7.4...v0.7.5
[1.0.0]: https://github.com/nspcc-dev/neofs-api/compare/v0.7.5...v1.0.0
[1.1.0]: https://github.com/nspcc-dev/neofs-api/compare/v1.0.0...v1.1.0
[1.2.0]: https://github.com/nspcc-dev/neofs-api/compare/v1.1.0...v1.2.0
[2.0.0]: https://github.com/nspcc-dev/neofs-api/compare/v1.2.0...v2.0.0
