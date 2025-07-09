# Changelog

## [Unreleased]

### Added

### Changed

### Removed

### Deprecated

## [2.18.0] - 2025-07-09

### Added
- Support for N3 signature scheme (#324)
- "Associate" attribute for objects (#337)

### Changed
- Adjusted SearchV2 description for filtered attribute-less requests (#330)
- `EpochDuration` is counted in seconds in netmap now (#331)

### Removed
- Header limit exception (4 MB instead of 16 KB) for replication RPCs (#293)

### Deprecated
- `ExternalAddr` node attribute (#327)
- `verify_header` field in `object.GetResponse` and `object.HeadResponse` messages (#334)
- `ShortHeader` (#336)
- Lock and tombstone payloads (#337)
- Audit and storage groups (#339)

## [2.17.0] - 2025-02-28

### Added
- Address-based targets in EACL rules (#301)
- Signatures to replication API (#302)
- Meta consistency attributes for containers (#309)
- SearchV2 API (#314, #320, #321)

### Changed
- Object and container IDs consisting of all zeroes are officialy invalid now (#303)
- 0:0 range requests are now valid and should return whole object payload (#315)
- Container policy REP and CBF have limits now (#307)
- Zero byte is forbidden in attributes (#323)

## [2.16.0] - 2024-04-23

### Added
- Numeric operands for object search queries (#265)
- Link object payload message (#263)
- Children sizes index to the link objects (#264)
- `LINK` split chain object type (#283)
- `BearerToken.issuer` field (#266)
- First child search filter (#295)

### Changed
- Split ID is deprecated, the first child part is used instead and is known to the other parts (#283)
- Object header is now limited to 16KB (#262)
- X-headers `__NEOFS__NETMAP_EPOCH` and `__NEOFS__NETMAP_LOOKUP_DEPTH` are ignored by servers now (#282)
- `Tombstone.expiration_epoch` field is ignored by servers now (#215)
- Signature for Replicate request (#294)

### Deprecated
- Object attributes `__NEOFS__TICK_EPOCH` and `__NEOFS__TICK_TOPIC` (#279)
- X-headers `__NEOFS__NETMAP_EPOCH` and `__NEOFS__NETMAP_LOOKUP_DEPTH` (#282)
- `Tombstone.expiration_epoch` field in favor of corresponding object attribute (#215)
- `split_id` field in tombstones (#297)

## [2.15.0] - 2024-01-30

### Added
- Well-known `Version` node attribute (#267)
- Reserved node attribute for verified domains (#277)
- Fast object replication API (#280)

### Changed
- Improved documentation (#224, #275)

### Removed
- Redundant object system attribute `__NEOFS__UPLOAD_ID` (#271)

### Deprecated
- Subnets (#261)

## [2.14.0] - 2022-09-23 - Anmado (안마도, 鞍馬島)

### Added
- `NetmapSnapsot` RPC to `netmap.NetmapService` (#228)
- Well-known object attribute `FilePath` of `object.Header.Attribute` (#238)
- `MAINTENANCE` value of `netmap.NodeInfo.State` enum (#237)
- `NODE_UNDER_MAINTENANCE` code to `status.CommonFail` status section (#237)
- Well-known node attribute `ExternalAddr` of `netmap.NodeInfo.Attribute` (#235)

### Changed
- Object session can be issued for a group of objects (#202)
- System network parameters are explicitly declared in `NetworkConfig.Parameter` (#214)

## [2.13.1] - 2022-08-01

### Added
- `EACL_NOT_FOUND` status code to the `container` section (#230)

## [2.13.0] - 2022-06-21 - Yeonpyeongdo (연평도, 延坪島)

### Added
- Extended headers usage clarification (#204)
- `OUT_OF_RANGE` status code to the `object` section (#208)
- Disabling homomorphic hashing container setting (#217)
- `LOCK` object behaviour clarification (#221)
- Storage group members uniqueness constraint (#222)
- WalletConnect signature scheme (#206)
- `SIGNATURE_VERIFICATION_FAIL` status code to the `CommonFail` section (#225)

### Deprecated
- Storage group's expiration epoch field (#205)

### Fixed
- English language typos (#216)

## [2.12.0] - 2022-02-22 - Heuksando (흑산도, 黑山島)

Network magic, main status codes, object locks and notifications.

### Added
- `magic_number` field to `RequestMetaHeader` message (#82)
- `WRONG_MAGIC_NUMBER` status code to `CommonFail` section (#82)
- Well-known object attributes related to notifications `__NEOFS__TICK_EPOCH`
  and `__NEOFS__TICK_TOPIC` (#193)
- `ACCESS_DENIED` status code to `Object` section (#189)
- `OBJECT_NOT_FOUND`, `CONTAINER_NOT_FOUND` and `OBJECT_ALREADY_REMOVED` status codes (#190)
- `TOKEN_NOT_FOUND` and `TOKEN_EXPIRED` status codes to `Session` section (#191)
- `LOCK` value of `object.Type` enum (#194)
- `Lock` message with payload content of `LOCK` objects (#194)
- `LOCKED` and `LOCK_NON_REGULAR_OBJECT` status codes to `Object` section (#194)
- `scheme` field of type `SignatureScheme` to `Signature` message which determines 
  signature scheme (#55)
- `SignatureRFC6979` message (#203)

### Changed
- Type of `signature` field in `ContainerService` requests to `SignatureRFC6979` (#203)

## [2.11.0] - 2021-12-02 - Sinjido (신지도, 薪智島)

Subnets and status responses.

### Added
- `Status` message structure (#150)
- `status` field of `Status` type to `ResponseMetaHeader` message (#150)
- `Subnet` message structure (#180)
- `subnet` field of `Subnet` type to `PlacementPolicy` message (#179)

### Changed
- Subnet attributes in `NodeInfo` (#181)

## [2.10.0] - 2021-10-14 - Udo (우도, 牛島)

NNS integration, detailed network info and ACL rules for non-native services.

### Added
- ACL header type for services (#173)
- Side chain block duration and NeoFS network config fields in `NetworkInfo`
  message (#172)
- Well-known container attributes for NNS integration (#177)

## [2.9.1] - 2021-08-26

### Changed
- String presentation of object type enum.

## [2.9.0] - 2021-08-16 - Anmyeondo (안면도, 安眠島)

Support "common prefix" attribute match operation to simplify filesystem
directory tree-like structures implementation in NeoFS protocol gateways.

### Added
- `COMMON_PREFIX` object attribute match type.
- Storage node's attribute escape symbol description.

## [2.8.0] - 2021-06-25 - Muuido (무의도, 舞衣島)

Storage nodes with a group of network endpoints.

### Changed

- `address` field of `netmap.NodeInfo` message became `repeated`.

## [2.7.0] - 2021-06-03 - Seongmodo (석모도, 席毛島)

Container service sessions.

### Added

#### Session

- `ContainerSessionContext` message.
- `ContainerSessionContext` value of `context` oneof to `SessionToken.Body` message.

#### Container

##### Get

- `session_token` field of type `session.SessionToken` to `GetResponse.Body` message.
- `signature` field of type `refs.Signature` to `GetResponse.Body` message.

##### GetExtendedACL

- `session_token` field of type `session.SessionToken` to `GetExtendedACLResponse.Body` message.

## [2.6.0] - 2021-05-07 - Daecheongdo (대청도, 大靑島)

### Added

- Reputation package with reputation service and corresponding type definitions.

## [2.5.0] - 2021-03-19 - Jebudo (제부도, 濟扶島)

This release contains changes and fixes for NEO3 testnet launch.

### Added

- Well-known object attribute `Content-Type`.

### Changed

- Namespace for C# has been changed to `Neo.FileStorage.API`.

## [2.4.0] - 2021-02-26 - Ganghwado (강화도, 江華島)

This release provides new RPC method to fetch network info from storage node.
By getting current epoch value, application might set up correct expiration
values in the objects.

### Added

- `netmap.NetworkInfo` request for getting node's network view.
- Release instructions.

### Changed

- Clarified processing of empty search query in `object.Search` RPC. 
- Specified connection of tombstone expiration value with well-known 
  `__NEOFS__EXPIRATION_EPOCH` object attribute.

## [2.3.0] - 2021-02-11 - Seonyudo (선유도, 仙遊島)

This release brings support for nodes to exchange information about disk space
used by each Container. This information will be used by Inner Ring nodes to
calculate basic rewards and payments.

Another significant change is UN/LOCODE support for node's attributes describing
geographical location. From now on, most of the geographical attributes will be
calculated automatically from a single `UN-LOCODE` attribute in a deterministic
manner.

### Added

- Added `container.AnnounceUsedSpace` request for announcing disk space consumed
  by container's objects on the node
- Added `Continent` well-known node's attribute
- Added `SubDivCode` well-known node's attribute
- Added `Location` well-known node's attribute
- Added `CounrtyCode` well-known node's attribute
- Added `STRING_NOT_EQUAL` match type
- Added `NOT_PRESENT` match type
- Added JSON names for search request filter fields

### Changed

- `Locode` well-known node's attribute renamed to `UN-LOCODE`. It will be used
  as a base for calculating most of the node's geographical attributes.
- `Region` well-known node's attribute renamed to `SubDiv`

### Removed

- Removed `City` well-known node's attribute
- Removed `Region` well-known node's attribute

## [2.2.1] - 2021-01-15

Define "well-known" X-headers

### Added

- Description of the format of "well-known" X-headers that affect system
  behavior
- X-header key to netmap epoch value
- X-header key to netmap lookup depth value

## [2.2.0] - 2020-12-30 - Yeouido (여의도, 汝矣島)

Storage Groups based Data Audit updates

### Added

- `audit.DataAuditResult` message for recording audit result is added

### Changed

- `object.ShortHeader` now has `payload_hash` and `homomorphic_hash` fields

## [2.1.1] - 2020-12-17

Minor documentation fixes

### Changed

- Clarify JSON encoding for `ObjectID`, `ContainerID` and `OwnerID`
- Clarify object field usage in some requests' eACL filters

## [2.1.0] - 2020-12-11 - Modo (모도, 茅島)

Object split and deletion improvements, documentation clarifications.

### Added

- `$Object:objectID` added to the list of available ACL and Search filters
- `split_id` field added in `object.Object.header`
- `$Object:split.splitID` search filter added
- json_name notation added to `acl.EACLTable.Version` field
- Adding `tombstone` field with newly created tombstone address field to
  `object.DeleteResponse.Body`
- `tombstone` package added
- Tombstone payload definition added as `tombstone.Tombstone` message
- `SplitInfo` message added to `object` package
- `split_info` field added to `object.GetResponse.Body`
- `split_info` field added to `object.HeadResponse.Body`
- `split_info` field added to `object.GetRangeResponse.Body`
- `raw` flag added in `object.GetRangeRequest.Body`

### Changed

- Clarified special search index descriptions
- Clarified various types encoding formats descriptions

### Removed

- `$Object:CHILDFREE` filter description removed from well-known list
- `$Object:LEAF` filter description removed from well-known list

## [2.0.2] - 2020-10-27

More "well-known" application attributes and documentation updates.

### Added

- Added "well-known" attributes list for extended ACL and object search filters
- Added `Name`, `Timestamp` "well-known" application attributes for container
- Added `Name`, `FileName`, `Timestamp` "well-known" application attributes for
  object

### Changed

- `BearerToken.owner_id` field description changed
- `Subnet` container attribute now has `__NEOFS__` prefix
- Search and ACL filters now have `key` and `value` fields

## [2.0.1] - 2020-10-19

Documentation updates and JSON field names definition

### Added

- Added "well-known" attributes list for `netmap.NodeInfo`
- Added "well-known" attributes list for objects
- Added "well-known" attributes list for containers
- JSON field names defined for most of data structures

### Changed

- Documentation updated for all packages fixing typos and minor inaccuracies
- `acl.EACLRecord.Target.key_list` field renamed to `keys` for consistency

### Removed

- Human-written documentation will now be only in [NeoFS
  Specification](https://github.com/nspcc-dev/neofs-spec)

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
- `netmap.LocalNodeInfo` request added to get actual information from connected
  peer

### Changed

- Extended ACL Table format changed
- Protobuf definitions style changed to follow Google Style Guide
- `System` and `Extended` Object headers are merged into on `object.Header` type
- `object.UserHeader` renamed to `object.Header.Attribute`
- `refs.ObjectID` is now a hash of the `object.Header` field, which contains
  hash of payload
- `StorageGroup` information moved to Object's payload
- `netmap.NodeInfo.options` renamed to `netmap.NodeInfo.attributes` and it uses
  a separate `netmap.NodeInfo.Attribute` type now.
- `netmap.NodeInfo.Attribute` type now has a list of parents to construct a tree
- Session Token renamed to `session.SessionToken` from `session.Token`
- All Requests and Responses now have a common "body-meta-verify" structure
- Meta and Verification headers now follow Matryoshka-style composition
- SessionToken and BearerToken are now part of Meta header
- Object placement policy format is simplified and defined in `netmap` package
- `object.Head()` request now returns either short header or full header with a
  signature

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

- ```acl.EACLRecord```, ```acl.EACLTable``` messages for the table of extended
  ACL rules.

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
- `Token` field from `object.PutRequest.PutHeader` and `object.DeleteRequest`
  messages.
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
[2.0.1]: https://github.com/nspcc-dev/neofs-api/compare/v2.0.0...v2.0.1
[2.0.2]: https://github.com/nspcc-dev/neofs-api/compare/v2.0.1...v2.0.2
[2.1.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.0.2...v2.1.0
[2.1.1]: https://github.com/nspcc-dev/neofs-api/compare/v2.1.0...v2.1.1
[2.2.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.1.1...v2.2.0
[2.2.1]: https://github.com/nspcc-dev/neofs-api/compare/v2.2.0...v2.2.1
[2.3.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.2.1...v2.3.0
[2.4.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.3.0...v2.4.0
[2.5.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.4.0...v2.5.0
[2.6.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.5.0...v2.6.0
[2.7.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.6.0...v2.7.0
[2.8.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.7.0...v2.8.0
[2.9.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.8.0...v2.9.0
[2.9.1]: https://github.com/nspcc-dev/neofs-api/compare/v2.9.0...v2.9.1
[2.10.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.9.1...v2.10.0
[2.11.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.10.0...v2.11.0
[2.12.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.11.0...v2.12.0
[2.13.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.12.0...v2.13.0
[2.13.1]: https://github.com/nspcc-dev/neofs-api/compare/v2.13.0...v2.13.1
[2.14.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.13.1...v2.14.0
[2.15.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.14.0...v2.15.0
[2.16.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.15.0...v2.16.0
[2.17.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.16.0...v2.17.0
[2.18.0]: https://github.com/nspcc-dev/neofs-api/compare/v2.17.0...v2.18.0
[Unreleased]: https://github.com/nspcc-dev/neofs-api/compare/v2.18.0...master
