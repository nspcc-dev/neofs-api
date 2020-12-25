# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [refs/types.proto](#refs/types.proto)

  - Messages
    - [Address](#neo.fs.v2.refs.Address)
    - [Checksum](#neo.fs.v2.refs.Checksum)
    - [ContainerID](#neo.fs.v2.refs.ContainerID)
    - [ObjectID](#neo.fs.v2.refs.ObjectID)
    - [OwnerID](#neo.fs.v2.refs.OwnerID)
    - [Signature](#neo.fs.v2.refs.Signature)
    - [Version](#neo.fs.v2.refs.Version)
    

- [Scalar Value Types](#scalar-value-types)



<a name="refs/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## refs/types.proto


 <!-- end services -->


<a name="neo.fs.v2.refs.Address"></a>

### Message Address
Objects in NeoFS are addressed by their ContainerID and ObjectID.

String presentation of `Address` is the concatenation of string encoded
`ContainerID` and `ObjectID` delimited by '/' character.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [ContainerID](#neo.fs.v2.refs.ContainerID) |  | Container identifier |
| object_id | [ObjectID](#neo.fs.v2.refs.ObjectID) |  | Object identifier |


<a name="neo.fs.v2.refs.Checksum"></a>

### Message Checksum
Checksum message.
Depending on checksum algorithm type the string presentation may vary:

* TZ \
  Hex encoded string without `0x` prefix
* SHA256 \
  Hex encoded string without `0x` prefix


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| type | [ChecksumType](#neo.fs.v2.refs.ChecksumType) |  | Checksum algorithm type |
| sum | [bytes](#bytes) |  | Checksum itself |


<a name="neo.fs.v2.refs.ContainerID"></a>

### Message ContainerID
NeoFS container identifier. Container structures are immutable and
content-addressed.

`ContainerID` is a 32 byte long
[SHA256](https://csrc.nist.gov/publications/detail/fips/180/4/final) hash of
stable-marshalled container message.

String presentation is
[base58](https://tools.ietf.org/html/draft-msporny-base58-02) encoded string.

JSON value will be the data encoded as a string using standard base64
encoding with paddings. Either
[standard](https://tools.ietf.org/html/rfc4648#section-4) or
[URL-safe](https://tools.ietf.org/html/rfc4648#section-5) base64 encoding
with/without paddings are accepted.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| value | [bytes](#bytes) |  | Container identifier in a binary format. |


<a name="neo.fs.v2.refs.ObjectID"></a>

### Message ObjectID
NeoFS Object unique identifier. Objects are immutable and content-addressed.
It means `ObjectID` will change if `header` or `payload` changes.

`ObjectID` is a 32 byte long
[SHA256](https://csrc.nist.gov/publications/detail/fips/180/4/final) hash of
object's `header` field, which, in it's turn, contains hash of object's
payload.

String presentation is
[base58](https://tools.ietf.org/html/draft-msporny-base58-02) encoded string.

JSON value will be the data encoded as a string using standard base64
encoding with paddings. Either
[standard](https://tools.ietf.org/html/rfc4648#section-4) or
[URL-safe](https://tools.ietf.org/html/rfc4648#section-5) base64 encoding
with/without paddings are accepted.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| value | [bytes](#bytes) |  | Object identifier in a binary format |


<a name="neo.fs.v2.refs.OwnerID"></a>

### Message OwnerID
`OwnerID` is a derivative of a user's main public key. The transformation
algorithm is the same as for Neo3 wallet addresses. Neo3 wallet address can
be directly used as `OwnerID`.

`OwnerID` is a 25 bytes sequence starting with Neo version prefix byte
followed by 20 bytes of ScrptHash and 4 bytes of checksum.

String presentation is [Base58
Check](https://en.bitcoin.it/wiki/Base58Check_encoding) Encoded string.

JSON value will be the data encoded as a string using standard base64
encoding with paddings. Either
[standard](https://tools.ietf.org/html/rfc4648#section-4) or
[URL-safe](https://tools.ietf.org/html/rfc4648#section-5) base64 encoding
with/without paddings are accepted.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| value | [bytes](#bytes) |  | Identifier of the container owner in a binary format |


<a name="neo.fs.v2.refs.Signature"></a>

### Message Signature
Signature of something in NeoFS.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [bytes](#bytes) |  | Public key used for signing |
| sign | [bytes](#bytes) |  | Signature |


<a name="neo.fs.v2.refs.Version"></a>

### Message Version
API version used by a node.

String presentation is a Semantic Versioning 2.0.0 compatible version string
with 'v' prefix. I.e. `vX.Y`, where `X` - major number, `Y` - minor number.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| major | [uint32](#uint32) |  | Major API version |
| minor | [uint32](#uint32) |  | Minor API version |

 <!-- end messages -->


<a name="neo.fs.v2.refs.ChecksumType"></a>

### ChecksumType
Checksum algorithm type.

| Name | Number | Description |
| ---- | ------ | ----------- |
| CHECKSUM_TYPE_UNSPECIFIED | 0 | Unknown. Not used |
| TZ | 1 | Tillich-Zemor homomorphic hash function |
| SHA256 | 2 | SHA-256 |


 <!-- end enums -->



## Scalar Value Types

| .proto Type | Notes | C++ Type | Java Type | Python Type |
| ----------- | ----- | -------- | --------- | ----------- |
| <a name="double" /> double |  | double | double | float |
| <a name="float" /> float |  | float | float | float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long |
| <a name="bool" /> bool |  | bool | boolean | boolean |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str |

