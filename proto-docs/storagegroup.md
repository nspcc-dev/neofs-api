# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [storagegroup/types.proto](#storagegroup/types.proto)

  - Messages
    - [StorageGroup](#storagegroup.StorageGroup)
    - [StorageGroup.Lifetime](#storagegroup.StorageGroup.Lifetime)
    

- [Scalar Value Types](#scalar-value-types)



<a name="storagegroup/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## storagegroup/types.proto


 <!-- end services -->


<a name="storagegroup.StorageGroup"></a>

### Message StorageGroup



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| ValidationDataSize | [uint64](#uint64) |  | ValidationDataSize is size of the all object's payloads included into storage group |
| ValidationHash | [bytes](#bytes) |  | ValidationHash is homomorphic hash of all object's payloads included into storage group |
| lifetime | [StorageGroup.Lifetime](#storagegroup.StorageGroup.Lifetime) |  | Lifetime is time until storage group is valid |
| Members | [refs.ObjectID](#refs.ObjectID) | repeated | Members carries the list of identifiers of the object storage group members. The list is strictly ordered. |


<a name="storagegroup.StorageGroup.Lifetime"></a>

### Message StorageGroup.Lifetime



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| unit | [StorageGroup.Lifetime.Unit](#storagegroup.StorageGroup.Lifetime.Unit) |  | Unit is lifetime type |
| Value | [int64](#int64) |  | Value for lifetime |

 <!-- end messages -->


<a name="storagegroup.StorageGroup.Lifetime.Unit"></a>

### StorageGroup.Lifetime.Unit


| Name | Number | Description |
| ---- | ------ | ----------- |
| Unlimited | 0 | Unlimited set if storage group always valid |
| NeoFSEpoch | 1 | NeoFSEpoch set if storage group is valid until lifetime NeoFS epoch |
| UnixTime | 2 | UnixTime set if storage group is valid until lifetime unix timestamp |


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

