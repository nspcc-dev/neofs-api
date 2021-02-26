# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [netmap/service.proto](#netmap/service.proto)
 - Services
    - [NetmapService](#neo.fs.v2.netmap.NetmapService)
    
  - Messages
    - [LocalNodeInfoRequest](#neo.fs.v2.netmap.LocalNodeInfoRequest)
    - [LocalNodeInfoRequest.Body](#neo.fs.v2.netmap.LocalNodeInfoRequest.Body)
    - [LocalNodeInfoResponse](#neo.fs.v2.netmap.LocalNodeInfoResponse)
    - [LocalNodeInfoResponse.Body](#neo.fs.v2.netmap.LocalNodeInfoResponse.Body)
    - [NetworkInfoRequest](#neo.fs.v2.netmap.NetworkInfoRequest)
    - [NetworkInfoRequest.Body](#neo.fs.v2.netmap.NetworkInfoRequest.Body)
    - [NetworkInfoResponse](#neo.fs.v2.netmap.NetworkInfoResponse)
    - [NetworkInfoResponse.Body](#neo.fs.v2.netmap.NetworkInfoResponse.Body)
    

- [netmap/types.proto](#netmap/types.proto)

  - Messages
    - [Filter](#neo.fs.v2.netmap.Filter)
    - [NetworkInfo](#neo.fs.v2.netmap.NetworkInfo)
    - [NodeInfo](#neo.fs.v2.netmap.NodeInfo)
    - [NodeInfo.Attribute](#neo.fs.v2.netmap.NodeInfo.Attribute)
    - [PlacementPolicy](#neo.fs.v2.netmap.PlacementPolicy)
    - [Replica](#neo.fs.v2.netmap.Replica)
    - [Selector](#neo.fs.v2.netmap.Selector)
    

- [Scalar Value Types](#scalar-value-types)



<a name="netmap/service.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## netmap/service.proto




<a name="neo.fs.v2.netmap.NetmapService"></a>

### Service "neo.fs.v2.netmap.NetmapService"
`NetmapService` provides methods to work with `Network Map` and information
required to build it. The resulting `Network Map` is stored in sidechain
`Netmap` smart contract, while related information can be obtained from other
NeoFS nodes.

```
rpc LocalNodeInfo(LocalNodeInfoRequest) returns (LocalNodeInfoResponse);
rpc NetworkInfo(NetworkInfoRequest) returns (NetworkInfoResponse);

```

#### Method LocalNodeInfo

Get NodeInfo structure from the particular node directly. Node information
can be taken from `Netmap` smart contract, but in some cases the one may
want to get recent information directly, or to talk to the node not yet
present in `Network Map` to find out what API version can be used for
further communication. Can also be used to check if node is up and running.

| Name | Input | Output |
| ---- | ----- | ------ |
| LocalNodeInfo | [LocalNodeInfoRequest](#neo.fs.v2.netmap.LocalNodeInfoRequest) | [LocalNodeInfoResponse](#neo.fs.v2.netmap.LocalNodeInfoResponse) |
#### Method NetworkInfo

Read recent information about the NeoFS network.

| Name | Input | Output |
| ---- | ----- | ------ |
| NetworkInfo | [NetworkInfoRequest](#neo.fs.v2.netmap.NetworkInfoRequest) | [NetworkInfoResponse](#neo.fs.v2.netmap.NetworkInfoResponse) |
 <!-- end services -->


<a name="neo.fs.v2.netmap.LocalNodeInfoRequest"></a>

### Message LocalNodeInfoRequest
Get NodeInfo structure from the particular node directly


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [LocalNodeInfoRequest.Body](#neo.fs.v2.netmap.LocalNodeInfoRequest.Body) |  | Body of the LocalNodeInfo request message |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.netmap.LocalNodeInfoRequest.Body"></a>

### Message LocalNodeInfoRequest.Body
LocalNodeInfo request body is empty.



<a name="neo.fs.v2.netmap.LocalNodeInfoResponse"></a>

### Message LocalNodeInfoResponse
Local Node Info, including API Version in use


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [LocalNodeInfoResponse.Body](#neo.fs.v2.netmap.LocalNodeInfoResponse.Body) |  | Body of the balance response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect response execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.netmap.LocalNodeInfoResponse.Body"></a>

### Message LocalNodeInfoResponse.Body
Local Node Info, including API Version in use.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Latest NeoFS API version in use |
| node_info | [NodeInfo](#neo.fs.v2.netmap.NodeInfo) |  | NodeInfo structure with recent information from node itself |


<a name="neo.fs.v2.netmap.NetworkInfoRequest"></a>

### Message NetworkInfoRequest
Get NetworkInfo structure with the network view from particular node.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [NetworkInfoRequest.Body](#neo.fs.v2.netmap.NetworkInfoRequest.Body) |  | Body of the NetworkInfo request message |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.netmap.NetworkInfoRequest.Body"></a>

### Message NetworkInfoRequest.Body
NetworkInfo request body is empty.



<a name="neo.fs.v2.netmap.NetworkInfoResponse"></a>

### Message NetworkInfoResponse
Response with NetworkInfo structure including current epoch and
sidechain magic number.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [NetworkInfoResponse.Body](#neo.fs.v2.netmap.NetworkInfoResponse.Body) |  | Body of the NetworkInfo response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect response execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.netmap.NetworkInfoResponse.Body"></a>

### Message NetworkInfoResponse.Body
Information about the network.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| network_info | [NetworkInfo](#neo.fs.v2.netmap.NetworkInfo) |  | NetworkInfo structure with recent information. |

 <!-- end messages -->

 <!-- end enums -->



<a name="netmap/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## netmap/types.proto


 <!-- end services -->


<a name="neo.fs.v2.netmap.Filter"></a>

### Message Filter
Filter will return the subset of nodes from `NetworkMap` or another filter's
results, that will satisfy filter's conditions.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Name of the filter or a reference to the named filter. '*' means application to the whole unfiltered NetworkMap. At top level it's used as a filter name. At lower levels it's considered to be a reference to another named filter |
| key | [string](#string) |  | Key to filter |
| op | [Operation](#neo.fs.v2.netmap.Operation) |  | Filtering operation |
| value | [string](#string) |  | Value to match |
| filters | [Filter](#neo.fs.v2.netmap.Filter) | repeated | List of inner filters. Top level operation will be applied to the whole list. |


<a name="neo.fs.v2.netmap.NetworkInfo"></a>

### Message NetworkInfo
Information about NeoFS network


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| current_epoch | [uint64](#uint64) |  | Number of the current epoch in the NeoFS network. |
| magic_number | [uint64](#uint64) |  | Magic number of the sidechain of the NeoFS network. |


<a name="neo.fs.v2.netmap.NodeInfo"></a>

### Message NodeInfo
NeoFS node description


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| public_key | [bytes](#bytes) |  | Public key of the NeoFS node in a binary format. |
| address | [string](#string) |  | Ways to connect to a node |
| attributes | [NodeInfo.Attribute](#neo.fs.v2.netmap.NodeInfo.Attribute) | repeated | Carries list of the NeoFS node attributes in a key-value form. Key name must be a node-unique valid UTF-8 string. Value can't be empty. NodeInfo structures with duplicated attribute names or attributes with empty values will be considered invalid. |
| state | [NodeInfo.State](#neo.fs.v2.netmap.NodeInfo.State) |  | Carries state of the NeoFS node. |


<a name="neo.fs.v2.netmap.NodeInfo.Attribute"></a>

### Message NodeInfo.Attribute
Administrator-defined Attributes of the NeoFS Storage Node.

`Attribute` is a Key-Value metadata pair. Key name must be a valid UTF-8
string. Value can't be empty.

Node's attributes are mostly used during Storage Policy evaluation to
calculate object's placement and find a set of nodes satisfying policy
requirements. There are some "well-known" node attributes common to all the
Storage Nodes in the network and used implicitly with default values if not
explicitly set:

* Capacity \
  Total available disk space in Gigabytes.
* Price \
  Price in GAS tokens for storing one GB of data during one Epoch. In node
  attributes it's a string presenting floating point number with comma or
  point delimiter for decimal part. In the Network Map it will be saved as
  64-bit unsigned integer representing number of minimal token fractions.
* Subnet \
  String ID of Node's storage subnet. There can be only one subnet served
  by the Storage Node.
* UN-LOCODE \
  Node's geographic location in
  [UN/LOCODE](https://www.unece.org/cefact/codesfortrade/codes_index.html)
  format approximated to the nearest point defined in the standard.
* CountryCode \
  Country code in
  [ISO 3166-1_alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)
  format. Calculated automatically from `UN-LOCODE` attribute.
* Country \
  Country short name in English, as defined in
  [ISO-3166](https://www.iso.org/obp/ui/#search). Calculated automatically
  from `UN-LOCODE` attribute.
* Location \
  Place names are given, whenever possible, in their national language
  versions as expressed in the Roman alphabet using the 26 characters of
  the character set adopted for international trade data interchange,
  written without diacritics . Calculated automatically from `UN-LOCODE`
  attribute.
* SubDivCode \
  Country's administrative subdivision where node is located. Calculated
  automatically from `UN-LOCODE` attribute based on `SubDiv` field.
  Presented in [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)
  format.
* SubDiv \
  Country's administrative subdivision name, as defined in
  [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2). Calculated
  automatically from `UN-LOCODE` attribute.
* Continent \
  Node's continent name according to the [Seven-Continent model]
  (https://en.wikipedia.org/wiki/Continent#Number). Calculated
  automatically from `UN-LOCODE` attribute.

For detailed description of each well-known attribute please see the
corresponding section in NeoFS Technical specification.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | Key of the node attribute. |
| value | [string](#string) |  | Value of the node attribute. |
| parents | [string](#string) | repeated | Parent keys, if any. For example for `City` it could be `Region` and `Country`. |


<a name="neo.fs.v2.netmap.PlacementPolicy"></a>

### Message PlacementPolicy
Set of rules to select a subset of nodes from `NetworkMap` able to store
container's objects. The format is simple enough to transpile from different
storage policy definition languages.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| replicas | [Replica](#neo.fs.v2.netmap.Replica) | repeated | Rules to set number of object replicas and place each one into a named bucket |
| container_backup_factor | [uint32](#uint32) |  | Container backup factor controls how deep NeoFS will search for nodes alternatives to include into container's nodes subset |
| selectors | [Selector](#neo.fs.v2.netmap.Selector) | repeated | Set of Selectors to form the container's nodes subset |
| filters | [Filter](#neo.fs.v2.netmap.Filter) | repeated | List of named filters to reference in selectors |


<a name="neo.fs.v2.netmap.Replica"></a>

### Message Replica
Number of object replicas in a set of nodes from the defined selector. If no
selector set the root bucket containing all possible nodes will be used by
default.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| count | [uint32](#uint32) |  | How many object replicas to put |
| selector | [string](#string) |  | Named selector bucket to put replicas |


<a name="neo.fs.v2.netmap.Selector"></a>

### Message Selector
Selector chooses a number of nodes from the bucket taking the nearest nodes
to the provided `ContainerID` by hash distance.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Selector name to reference in object placement section |
| count | [uint32](#uint32) |  | How many nodes to select from the bucket |
| clause | [Clause](#neo.fs.v2.netmap.Clause) |  | Selector modifier showing how to form a bucket |
| attribute | [string](#string) |  | Attribute bucket to select from |
| filter | [string](#string) |  | Filter reference to select from |

 <!-- end messages -->


<a name="neo.fs.v2.netmap.Clause"></a>

### Clause
Selector modifier shows how the node set will be formed. By default selector
just groups nodes into a bucket by attribute, selecting nodes only by their
hash distance.

| Name | Number | Description |
| ---- | ------ | ----------- |
| CLAUSE_UNSPECIFIED | 0 | No modifier defined. Will select nodes from bucket randomly. |
| SAME | 1 | SAME will select only nodes having the same value of bucket attribute |
| DISTINCT | 2 | DISTINCT will select nodes having different values of bucket attribute |



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

