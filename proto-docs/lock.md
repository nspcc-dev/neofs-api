# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [lock/types.proto](#lock/types.proto)

  - Messages
    - [Lock](#neo.fs.v2.lock.Lock)
    

- [Scalar Value Types](#scalar-value-types)



<a name="lock/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## lock/types.proto


 <!-- end services -->


<a name="neo.fs.v2.lock.Lock"></a>

### Message Lock
Lock objects protects a list of objects from being deleted. The lifetime of a
lock object is limited similar to regular objects in
`__NEOFS__EXPIRATION_EPOCH` attribute. Lock object MUST have expiration epoch.
It is impossible to delete a lock object via ObjectService.Delete RPC call.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| members | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) | repeated | List of objects to lock. Must not be empty or carry empty IDs. All members must be of the `REGULAR` type. |

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

