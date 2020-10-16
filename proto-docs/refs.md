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
Object in NeoFS can be addressed by it's ContainerID and ObjectID. In string
format there MUST be a '/' delimeter between them.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [ContainerID](#neo.fs.v2.refs.ContainerID) |  | Container identifier |
| object_id | [ObjectID](#neo.fs.v2.refs.ObjectID) |  | Object identifier |


<a name="neo.fs.v2.refs.Checksum"></a>

### Message Checksum
Checksum message.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| type | [ChecksumType](#neo.fs.v2.refs.ChecksumType) |  | Checksum algorithm type |
| sum | [bytes](#bytes) |  | Checksum itself |


<a name="neo.fs.v2.refs.ContainerID"></a>

### Message ContainerID
NeoFS container identifier. Container structures are immutable and
content-addressed. `ContainerID` is a 32 byte long SHA256 hash of
stable-marshalled container message.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| value | [bytes](#bytes) |  | Container identifier in a binary format. |


<a name="neo.fs.v2.refs.ObjectID"></a>

### Message ObjectID
NeoFS Object unique identifier. Objects are immutable and content-addressed.
It means `ObjectID` will change if `header` or `payload` changes. `ObjectID`
is calculated as a hash of `header` field, which contains hash of object's
payload.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| value | [bytes](#bytes) |  | Object identifier in a binary format |


<a name="neo.fs.v2.refs.OwnerID"></a>

### Message OwnerID
OwnerID is a derivative of a user's main public key. The transformation
algorithm is the same as for Neo3 wallet addresses. Neo3 wallet address can
be directly used as `OwnerID`.


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

