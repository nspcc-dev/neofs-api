# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [netmap/types.proto](#netmap/types.proto)

  - Messages
    - [Filter](#neo.fs.v2.netmap.Filter)
    - [NodeInfo](#neo.fs.v2.netmap.NodeInfo)
    - [NodeInfo.Attribute](#neo.fs.v2.netmap.NodeInfo.Attribute)
    - [PlacementPolicy](#neo.fs.v2.netmap.PlacementPolicy)
    - [Replica](#neo.fs.v2.netmap.Replica)
    - [Selector](#neo.fs.v2.netmap.Selector)
    

- [Scalar Value Types](#scalar-value-types)



<a name="netmap/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## netmap/types.proto


 <!-- end services -->


<a name="neo.fs.v2.netmap.Filter"></a>

### Message Filter
Filter


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Name of the filter or a reference to the named filter. '*' means application to the whole unfiltered NetworkMap At top level it's used as a filter name. At lower levels it's considered to be a reference to another named filter |
| key | [string](#string) |  | Key to filter |
| op | [Operation](#neo.fs.v2.netmap.Operation) |  | Filtering operation |
| value | [string](#string) |  | Value to match |
| filters | [Filter](#neo.fs.v2.netmap.Filter) | repeated | List of inner filters. Top level operation will be applied to the whole list. |


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
| parents | [string](#string) | repeated | Parent keys, if any Example: For City it can be Region or Country |


<a name="neo.fs.v2.netmap.PlacementPolicy"></a>

### Message PlacementPolicy
Set of rules to select a subset of nodes able to store container's objects


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| replicas | [Replica](#neo.fs.v2.netmap.Replica) | repeated | Rules to set number of object replicas and place each one into a particular bucket |
| container_backup_factor | [uint32](#uint32) |  | Container backup factor controls how deep NeoFS will search for nodes alternatives to include into container. |
| selectors | [Selector](#neo.fs.v2.netmap.Selector) | repeated | Set of Selectors to form the container's nodes subset |
| filters | [Filter](#neo.fs.v2.netmap.Filter) | repeated | List of named filters to reference in selectors |


<a name="neo.fs.v2.netmap.Replica"></a>

### Message Replica
Exact bucket for each replica


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| count | [uint32](#uint32) |  | How many object replicas to put |
| selector | [string](#string) |  | Named selector bucket to put in |


<a name="neo.fs.v2.netmap.Selector"></a>

### Message Selector
Selector


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Selector name to reference in object placement section |
| count | [uint32](#uint32) |  | How many nodes to select from bucket |
| attribute | [string](#string) |  | Attribute bucket to select from |
| filter | [string](#string) |  | Filter reference to select from |

 <!-- end messages -->


<a name="neo.fs.v2.netmap.NodeInfo.State"></a>

### NodeInfo.State
Represents the enumeration of various states of the NeoFS node.

| Name | Number | Description |
| ---- | ------ | ----------- |
| UNSPECIFIED | 0 | Unknown state. |
| ONLINE | 1 | Active state in the network. |
| OFFLINE | 2 | Network unavailable state. |



<a name="neo.fs.v2.netmap.Operation"></a>

### Operation
Operations on filters

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

