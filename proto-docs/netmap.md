# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [netmap/types.proto](#netmap/types.proto)

  - Messages
    - [NodeInfo](#netmap.NodeInfo)
    - [NodeInfo.Attribute](#netmap.NodeInfo.Attribute)
    - [PlacementRule](#netmap.PlacementRule)
    - [PlacementRule.SFGroup](#netmap.PlacementRule.SFGroup)
    - [PlacementRule.SFGroup.Filter](#netmap.PlacementRule.SFGroup.Filter)
    - [PlacementRule.SFGroup.Filter.SimpleFilter](#netmap.PlacementRule.SFGroup.Filter.SimpleFilter)
    - [PlacementRule.SFGroup.Filter.SimpleFilters](#netmap.PlacementRule.SFGroup.Filter.SimpleFilters)
    - [PlacementRule.SFGroup.Selector](#netmap.PlacementRule.SFGroup.Selector)
    

- [Scalar Value Types](#scalar-value-types)



<a name="netmap/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## netmap/types.proto


 <!-- end services -->


<a name="netmap.NodeInfo"></a>

### Message NodeInfo
Groups the information about the NeoFS node.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Address | [string](#string) |  | Carries network address of the NeoFS node. |
| PublicKey | [bytes](#bytes) |  | Carries public key of the NeoFS node in a binary format. |
| Attributes | [NodeInfo.Attribute](#netmap.NodeInfo.Attribute) | repeated | Carries list of the NeoFS node attributes in a string key-value format. |
| state | [NodeInfo.State](#netmap.NodeInfo.State) |  | Carries state of the NeoFS node. |


<a name="netmap.NodeInfo.Attribute"></a>

### Message NodeInfo.Attribute
Groups attributes of the NeoFS node.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Key | [string](#string) |  | Carries string key to the node attribute. |
| Value | [string](#string) |  | Carries string value of the node attribute. |


<a name="netmap.PlacementRule"></a>

### Message PlacementRule



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| ReplFactor | [uint32](#uint32) |  |  |
| SFGroups | [PlacementRule.SFGroup](#netmap.PlacementRule.SFGroup) | repeated |  |


<a name="netmap.PlacementRule.SFGroup"></a>

### Message PlacementRule.SFGroup



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Filters | [PlacementRule.SFGroup.Filter](#netmap.PlacementRule.SFGroup.Filter) | repeated |  |
| Selectors | [PlacementRule.SFGroup.Selector](#netmap.PlacementRule.SFGroup.Selector) | repeated |  |
| Exclude | [uint32](#uint32) | repeated |  |


<a name="netmap.PlacementRule.SFGroup.Filter"></a>

### Message PlacementRule.SFGroup.Filter



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Key | [string](#string) |  |  |
| F | [PlacementRule.SFGroup.Filter.SimpleFilter](#netmap.PlacementRule.SFGroup.Filter.SimpleFilter) |  |  |


<a name="netmap.PlacementRule.SFGroup.Filter.SimpleFilter"></a>

### Message PlacementRule.SFGroup.Filter.SimpleFilter



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Op | [PlacementRule.SFGroup.Filter.SimpleFilter.Operation](#netmap.PlacementRule.SFGroup.Filter.SimpleFilter.Operation) |  |  |
| Value | [string](#string) |  |  |
| FArgs | [PlacementRule.SFGroup.Filter.SimpleFilters](#netmap.PlacementRule.SFGroup.Filter.SimpleFilters) |  |  |


<a name="netmap.PlacementRule.SFGroup.Filter.SimpleFilters"></a>

### Message PlacementRule.SFGroup.Filter.SimpleFilters



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Filters | [PlacementRule.SFGroup.Filter.SimpleFilter](#netmap.PlacementRule.SFGroup.Filter.SimpleFilter) | repeated |  |


<a name="netmap.PlacementRule.SFGroup.Selector"></a>

### Message PlacementRule.SFGroup.Selector



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Count | [uint32](#uint32) |  |  |
| Key | [string](#string) |  |  |

 <!-- end messages -->


<a name="netmap.NodeInfo.State"></a>

### NodeInfo.State
Represents the enumeration of various states of the NeoFS node.

| Name | Number | Description |
| ---- | ------ | ----------- |
| Unknown | 0 | Undefined state. |
| Online | 1 | Active state on the network. |
| Offline | 2 | Network unavailable state. |



<a name="netmap.PlacementRule.SFGroup.Filter.SimpleFilter.Operation"></a>

### PlacementRule.SFGroup.Filter.SimpleFilter.Operation


| Name | Number | Description |
| ---- | ------ | ----------- |
| NP | 0 |  |
| EQ | 1 |  |
| NE | 2 |  |
| GT | 3 |  |
| GE | 4 |  |
| LT | 5 |  |
| LE | 6 |  |
| OR | 7 |  |
| AND | 8 |  |


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

