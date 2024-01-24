# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [link/types.proto](#link/types.proto)

  - Messages
    - [Link](#neo.fs.v2.link.Link)
    - [Link.MeasuredObject](#neo.fs.v2.link.Link.MeasuredObject)
    

- [Scalar Value Types](#scalar-value-types)



<a name="link/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## link/types.proto


 <!-- end services -->


<a name="neo.fs.v2.link.Link"></a>

### Message Link
Link is a payload of helper objects that contain the full list of the split
chain objects' IDs. It is created only after the whole split chain is known
and signed. This object is the only object that refers to every "child object"
ID. It is NOT required for the original object assembling. It MUST have ALL
the "child objects" IDs. Child objects MUST be ordered according to the
original payload split, meaning the first payload part holder MUST be placed
at the first place in the corresponding link object. Sizes MUST NOT be omitted
and MUST be a real object payload size in bytes.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| children | [Link.MeasuredObject](#neo.fs.v2.link.Link.MeasuredObject) | repeated | Full list of the "child" object descriptors. |


<a name="neo.fs.v2.link.Link.MeasuredObject"></a>

### Message Link.MeasuredObject
Object ID with its object's payload size.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Object ID. |
| size | [uint32](#uint32) |  | Object size in bytes. |

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

