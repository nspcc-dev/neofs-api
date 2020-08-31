# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [netmap/types.proto](#netmap/types.proto)

  - Messages
    - [NodeInfo](#neo.fs.v2.netmap.NodeInfo)
    - [NodeInfo.Attribute](#neo.fs.v2.netmap.NodeInfo.Attribute)
    - [PlacementPolicy](#neo.fs.v2.netmap.PlacementPolicy)
    - [PlacementPolicy.FilterGroup](#neo.fs.v2.netmap.PlacementPolicy.FilterGroup)
    - [PlacementPolicy.FilterGroup.Filter](#neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Filter)
    - [PlacementPolicy.FilterGroup.Filter.SimpleFilter](#neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Filter.SimpleFilter)
    - [PlacementPolicy.FilterGroup.Filter.SimpleFilter.SimpleFilters](#neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Filter.SimpleFilter.SimpleFilters)
    - [PlacementPolicy.FilterGroup.Selector](#neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Selector)
    

- [Scalar Value Types](#scalar-value-types)



<a name="netmap/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## netmap/types.proto


 <!-- end services -->


<a name="neo.fs.v2.netmap.NodeInfo"></a>

### Message NodeInfo
NeoFS node description


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| public_key | [bytes](#bytes) |  | Public key of the NeoFS node in a binary format. |
| address | [string](#string) |  | Ways to connect to a node |
| attributes | [NodeInfo.Attribute](#neo.fs.v2.netmap.NodeInfo.Attribute) | repeated | Carries list of the NeoFS node attributes in a string key-value format. |
| state | [NodeInfo.State](#neo.fs.v2.netmap.NodeInfo.State) |  | Carries state of the NeoFS node. |


<a name="neo.fs.v2.netmap.NodeInfo.Attribute"></a>

### Message NodeInfo.Attribute
Attributes of the NeoFS node.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | Key of the node attribute. |
| value | [string](#string) |  | Value of the node attribute. |


<a name="neo.fs.v2.netmap.PlacementPolicy"></a>

### Message PlacementPolicy
Set of rules to select a subset of nodes able to store container's objects


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| repl_factor | [uint32](#uint32) |  | Replication factor |
| filter_groups | [PlacementPolicy.FilterGroup](#neo.fs.v2.netmap.PlacementPolicy.FilterGroup) | repeated | List of filter groups |


<a name="neo.fs.v2.netmap.PlacementPolicy.FilterGroup"></a>

### Message PlacementPolicy.FilterGroup
Filters to apply to Network Map


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| filters | [PlacementPolicy.FilterGroup.Filter](#neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Filter) | repeated | Resulting filter list |
| selectors | [PlacementPolicy.FilterGroup.Selector](#neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Selector) | repeated | List of selectors |
| exclude | [uint32](#uint32) | repeated | Parts of graph to exclude. Internal use. |


<a name="neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Filter"></a>

### Message PlacementPolicy.FilterGroup.Filter
Filter definition


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | Filter identifier |
| f | [PlacementPolicy.FilterGroup.Filter.SimpleFilter](#neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Filter.SimpleFilter) |  | The rest of filter |


<a name="neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Filter.SimpleFilter"></a>

### Message PlacementPolicy.FilterGroup.Filter.SimpleFilter
Minimal simple filter


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| op | [PlacementPolicy.FilterGroup.Filter.SimpleFilter.Operation](#neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Filter.SimpleFilter.Operation) |  | Filtering operation |
| value | [string](#string) |  | Value |
| f_args | [PlacementPolicy.FilterGroup.Filter.SimpleFilter.SimpleFilters](#neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Filter.SimpleFilter.SimpleFilters) |  | Result of other filter application |


<a name="neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Filter.SimpleFilter.SimpleFilters"></a>

### Message PlacementPolicy.FilterGroup.Filter.SimpleFilter.SimpleFilters
List of filters


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| filters | [PlacementPolicy.FilterGroup.Filter.SimpleFilter](#neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Filter.SimpleFilter) | repeated | List of filters |


<a name="neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Selector"></a>

### Message PlacementPolicy.FilterGroup.Selector
Selector


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| count | [uint32](#uint32) |  | How many to select |
| key | [string](#string) |  | Key to select |

 <!-- end messages -->


<a name="neo.fs.v2.netmap.NodeInfo.State"></a>

### NodeInfo.State
Represents the enumeration of various states of the NeoFS node.

| Name | Number | Description |
| ---- | ------ | ----------- |
| UNSPECIFIED | 0 | Unknown state. |
| ONLINE | 1 | Active state in the network. |
| OFFLINE | 2 | Network unavailable state. |



<a name="neo.fs.v2.netmap.PlacementPolicy.FilterGroup.Filter.SimpleFilter.Operation"></a>

### PlacementPolicy.FilterGroup.Filter.SimpleFilter.Operation
Filtering operation

| Name | Number | Description |
| ---- | ------ | ----------- |
| OPERATION_UNSPECIFIED | 0 | No Operation defined |
| EQ | 1 | Equal |
| NE | 2 | Not Equal |
| GT | 3 | Greater then |
| GE | 4 | Greater or equal |
| LT | 5 | Less then |
| LE | 6 | Less or equal |
| OR | 7 | Logical OR |
| AND | 8 | Logical AND |


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

