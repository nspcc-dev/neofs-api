# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [storagegroup/types.proto](#storagegroup/types.proto)

  - Messages
    - [StorageGroup](#storagegroup.StorageGroup)
    

- [Scalar Value Types](#scalar-value-types)



<a name="storagegroup/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## storagegroup/types.proto


 <!-- end services -->


<a name="storagegroup.StorageGroup"></a>

### Message StorageGroup
StorageGroup groups the information about the NeoFS storage group.
The storage group consists of objects from single container.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| ValidationDataSize | [uint64](#uint64) |  | ValidationDataSize carries the total size of the payloads of the storage group members. |
| ValidationHash | [bytes](#bytes) |  | ValidationHash carries homomorphic hash from the concatenation of the payloads of the storage group members. The order of concatenation is the same as the order of the members in the Members field. |
| ExpirationEpoch | [uint64](#uint64) |  | ExpirationEpoch carries last NeoFS epoch number of the storage group lifetime. |
| Members | [refs.ObjectID](#refs.ObjectID) | repeated | Members carries the list of identifiers of the object storage group members. The list is strictly ordered. |

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

