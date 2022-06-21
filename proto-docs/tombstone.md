# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [tombstone/types.proto](#tombstone/types.proto)

  - Messages
    - [Tombstone](#neo.fs.v2.tombstone.Tombstone)
    

- [Scalar Value Types](#scalar-value-types)



<a name="tombstone/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## tombstone/types.proto


 <!-- end services -->


<a name="neo.fs.v2.tombstone.Tombstone"></a>

### Message Tombstone
Tombstone keeps record of deleted objects for a few epochs until they are
purged from the NeoFS network.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| expiration_epoch | [uint64](#uint64) |  | Last NeoFS epoch number of the tombstone lifetime. It's set by the tombstone creator depending on the current NeoFS network settings. A tombstone object must have the same expiration epoch value in `__NEOFS__EXPIRATION_EPOCH` attribute. Otherwise, the tombstone will be rejected by a storage node. |
| split_id | [bytes](#bytes) |  | 16 byte UUID used to identify the split object hierarchy parts. Must be unique inside a container. All objects participating in the split must have the same `split_id` value. |
| members | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) | repeated | List of objects to be deleted. |

 <!-- end messages -->

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

