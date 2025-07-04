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
    - [NetmapSnapshotRequest](#neo.fs.v2.netmap.NetmapSnapshotRequest)
    - [NetmapSnapshotRequest.Body](#neo.fs.v2.netmap.NetmapSnapshotRequest.Body)
    - [NetmapSnapshotResponse](#neo.fs.v2.netmap.NetmapSnapshotResponse)
    - [NetmapSnapshotResponse.Body](#neo.fs.v2.netmap.NetmapSnapshotResponse.Body)
    - [NetworkInfoRequest](#neo.fs.v2.netmap.NetworkInfoRequest)
    - [NetworkInfoRequest.Body](#neo.fs.v2.netmap.NetworkInfoRequest.Body)
    - [NetworkInfoResponse](#neo.fs.v2.netmap.NetworkInfoResponse)
    - [NetworkInfoResponse.Body](#neo.fs.v2.netmap.NetworkInfoResponse.Body)
    

- [netmap/types.proto](#netmap/types.proto)

  - Messages
    - [Filter](#neo.fs.v2.netmap.Filter)
    - [Netmap](#neo.fs.v2.netmap.Netmap)
    - [NetworkConfig](#neo.fs.v2.netmap.NetworkConfig)
    - [NetworkConfig.Parameter](#neo.fs.v2.netmap.NetworkConfig.Parameter)
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
`NetmapService` provides methods to work with `Network Map` and the information
required to build it. The resulting `Network Map` is stored in FS chain
`Netmap` smart contract, while related information can be obtained from other
NeoFS nodes.

```
rpc LocalNodeInfo(LocalNodeInfoRequest) returns (LocalNodeInfoResponse);
rpc NetworkInfo(NetworkInfoRequest) returns (NetworkInfoResponse);
rpc NetmapSnapshot(NetmapSnapshotRequest) returns (NetmapSnapshotResponse);

```

#### Method LocalNodeInfo

Get NodeInfo structure from the particular node directly.
Node information can be taken from `Netmap` smart contract. In some cases, though,
one may want to get recent information directly or to talk to the node not yet
present in the `Network Map` to find out what API version can be used for
further communication. This can be also used to check if a node is up and running.

Statuses:
- **OK** (0, SECTION_SUCCESS):
information about the server has been successfully read;
- Common failures (SECTION_FAILURE_COMMON).

| Name | Input | Output |
| ---- | ----- | ------ |
| LocalNodeInfo | [LocalNodeInfoRequest](#neo.fs.v2.netmap.LocalNodeInfoRequest) | [LocalNodeInfoResponse](#neo.fs.v2.netmap.LocalNodeInfoResponse) |
#### Method NetworkInfo

Read recent information about the NeoFS network.

Statuses:
- **OK** (0, SECTION_SUCCESS):
information about the current network state has been successfully read;
- Common failures (SECTION_FAILURE_COMMON).

| Name | Input | Output |
| ---- | ----- | ------ |
| NetworkInfo | [NetworkInfoRequest](#neo.fs.v2.netmap.NetworkInfoRequest) | [NetworkInfoResponse](#neo.fs.v2.netmap.NetworkInfoResponse) |
#### Method NetmapSnapshot

Returns network map snapshot of the current NeoFS epoch.

Statuses:
- **OK** (0, SECTION_SUCCESS):
information about the current network map has been successfully read;
- Common failures (SECTION_FAILURE_COMMON).

| Name | Input | Output |
| ---- | ----- | ------ |
| NetmapSnapshot | [NetmapSnapshotRequest](#neo.fs.v2.netmap.NetmapSnapshotRequest) | [NetmapSnapshotResponse](#neo.fs.v2.netmap.NetmapSnapshotResponse) |
 <!-- end services -->


<a name="neo.fs.v2.netmap.LocalNodeInfoRequest"></a>

### Message LocalNodeInfoRequest
Get NodeInfo structure directly from a particular node


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


<a name="neo.fs.v2.netmap.NetmapSnapshotRequest"></a>

### Message NetmapSnapshotRequest
Get netmap snapshot request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [NetmapSnapshotRequest.Body](#neo.fs.v2.netmap.NetmapSnapshotRequest.Body) |  | Body of get netmap snapshot request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.netmap.NetmapSnapshotRequest.Body"></a>

### Message NetmapSnapshotRequest.Body
Get netmap snapshot request body.



<a name="neo.fs.v2.netmap.NetmapSnapshotResponse"></a>

### Message NetmapSnapshotResponse
Response with current netmap snapshot


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [NetmapSnapshotResponse.Body](#neo.fs.v2.netmap.NetmapSnapshotResponse.Body) |  | Body of get netmap snapshot response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect response execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.netmap.NetmapSnapshotResponse.Body"></a>

### Message NetmapSnapshotResponse.Body
Get netmap snapshot response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| netmap | [Netmap](#neo.fs.v2.netmap.Netmap) |  | Structure of the requested network map. |


<a name="neo.fs.v2.netmap.NetworkInfoRequest"></a>

### Message NetworkInfoRequest
Get NetworkInfo structure with the network view from a particular node.


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
FS chain magic number.


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
This filter will return the subset of nodes from `NetworkMap` or another filter's
results that will satisfy filter's conditions.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | Name of the filter or a reference to a named filter. '*' means application to the whole unfiltered NetworkMap. At top level it's used as a filter name. At lower levels it's considered to be a reference to another named filter |
| key | [string](#string) |  | Key to filter |
| op | [Operation](#neo.fs.v2.netmap.Operation) |  | Filtering operation |
| value | [string](#string) |  | Value to match |
| filters | [Filter](#neo.fs.v2.netmap.Filter) | repeated | List of inner filters. Top level operation will be applied to the whole list. |


<a name="neo.fs.v2.netmap.Netmap"></a>

### Message Netmap
Network map structure


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| epoch | [uint64](#uint64) |  | Network map revision number. |
| nodes | [NodeInfo](#neo.fs.v2.netmap.NodeInfo) | repeated | Nodes presented in network. |


<a name="neo.fs.v2.netmap.NetworkConfig"></a>

### Message NetworkConfig
NeoFS network configuration


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| parameters | [NetworkConfig.Parameter](#neo.fs.v2.netmap.NetworkConfig.Parameter) | repeated | List of parameter values |


<a name="neo.fs.v2.netmap.NetworkConfig.Parameter"></a>

### Message NetworkConfig.Parameter
Single configuration parameter. Key MUST be network-unique.

System parameters:
- **AuditFee** \
  Fee paid by the storage group owner to the Inner Ring member.
  Value: little-endian integer. Default: 0.
- **BasicIncomeRate** \
  Cost of storing one gigabyte of data for a period of one epoch. Paid by
  container owner to container nodes.
  Value: little-endian integer. Default: 0.
- **ContainerAliasFee** \
  Fee paid for named container's creation by the container owner.
  Value: little-endian integer. Default: 0.
- **ContainerFee** \
  Fee paid for container creation by the container owner.
  Value: little-endian integer. Default: 0.
- **EigenTrustAlpha** \
  Alpha parameter of EigenTrust algorithm used in the Reputation system.
  Value: decimal floating-point number in UTF-8 string representation.
  Default: 0.
- **EigenTrustIterations** \
  Number of EigenTrust algorithm iterations to pass in the Reputation system.
  Value: little-endian integer. Default: 0.
- **EpochDuration** \
  NeoFS epoch duration measured in seconds.
  Value: little-endian integer. Default: 0.
- **HomomorphicHashingDisabled** \
  Flag of disabling the homomorphic hashing of objects' payload.
  Value: true if any byte != 0. Default: false.
- **InnerRingCandidateFee** \
  Fee for entrance to the Inner Ring paid by the candidate.
  Value: little-endian integer. Default: 0.
- **MaintenanceModeAllowed** \
  Flag allowing setting the MAINTENANCE state to storage nodes.
  Value: true if any byte != 0. Default: false.
- **MaxObjectSize** \
  Maximum size of physically stored NeoFS object measured in bytes.
  Value: little-endian integer. Default: 0.
- **WithdrawFee** \
  Fee paid for withdrawal of funds paid by the account owner.
  Value: little-endian integer. Default: 0.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [bytes](#bytes) |  | Parameter key. UTF-8 encoded string (with no zero bytes). |
| value | [bytes](#bytes) |  | Parameter value |


<a name="neo.fs.v2.netmap.NetworkInfo"></a>

### Message NetworkInfo
Information about NeoFS network


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| current_epoch | [uint64](#uint64) |  | Number of the current epoch in the NeoFS network |
| magic_number | [uint64](#uint64) |  | Magic number of FS chain of the NeoFS network |
| ms_per_block | [int64](#int64) |  | MillisecondsPerBlock network parameter of FS chain of the NeoFS network |
| network_config | [NetworkConfig](#neo.fs.v2.netmap.NetworkConfig) |  | NeoFS network configuration |


<a name="neo.fs.v2.netmap.NodeInfo"></a>

### Message NodeInfo
NeoFS node description


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| public_key | [bytes](#bytes) |  | Public key of the NeoFS node in a binary format |
| addresses | [string](#string) | repeated | Ways to connect to a node |
| attributes | [NodeInfo.Attribute](#neo.fs.v2.netmap.NodeInfo.Attribute) | repeated | Carries list of the NeoFS node attributes in a key-value form. Key name must be a node-unique valid UTF-8 string (without zero bytes). Value can't be empty. NodeInfo structures with duplicated attribute names or attributes with empty values will be considered invalid. |
| state | [NodeInfo.State](#neo.fs.v2.netmap.NodeInfo.State) |  | Carries state of the NeoFS node |


<a name="neo.fs.v2.netmap.NodeInfo.Attribute"></a>

### Message NodeInfo.Attribute
Administrator-defined Attributes of the NeoFS Storage Node.

`Attribute` is a Key-Value metadata pair. Key name must be a valid UTF-8
string (without zero bytes that are forbidden). Value can't be empty.

Attributes can be constructed into a chain of attributes: any attribute can
have a parent attribute and a child attribute (except the first and the last
one). A string representation of the chain of attributes in NeoFS Storage
Node configuration uses ":" and "/" symbols, e.g.:

       `NEOFS_NODE_ATTRIBUTE_1=key1:val1/key2:val2`

Therefore the string attribute representation in the Node configuration must
use "\:", "\/" and "\\" escaped symbols if any of them appears in an attribute's
key or value.

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
* __NEOFS__SUBNET_%s \
  DEPRECATED. Defined if the node is included in the `%s` subnetwork
  or not. Currently ignored.
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
* ExternalAddr
  Node's preferred way for communications with external clients.
  Clients SHOULD use these addresses if possible.
  Must contain a comma-separated list of multi-addresses.
  DEPRECATED. Use 'addresses' field instead.
* Version
  Node implementation's version in a free string form.
* VerifiedNodesDomain
  Confirmation of admission to a group of storage nodes.
  The value is the domain name registered in the NeoFS NNS. If attribute
  is specified, the storage node requesting entry into the NeoFS network
  map with this attribute must be included in the access list located on
  the specified domain. The access list is represented by a set of TXT
  records: Neo addresses resolved from public keys. To be admitted to the
  network, Neo address of the node's public key declared in 'public_key'
  field must be present in domain records. Otherwise, registration will be
  denied.
  Value must be a valid NeoFS NNS domain name. Note that if this attribute
  is absent, this check is not carried out.

For detailed description of each well-known attribute please see the
corresponding section in NeoFS Technical Specification.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | Key of the node attribute |
| value | [string](#string) |  | Value of the node attribute |
| parents | [string](#string) | repeated | Parent keys, if any. For example for `City` it could be `Region` and `Country`. |


<a name="neo.fs.v2.netmap.PlacementPolicy"></a>

### Message PlacementPolicy
Set of rules to select a subset of nodes from `NetworkMap` able to store
container's objects. The format is simple enough to transpile from different
storage policy definition languages.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| replicas | [Replica](#neo.fs.v2.netmap.Replica) | repeated | Rules to set number of object replicas and place each one into a named bucket. Limited to 256 items. |
| container_backup_factor | [uint32](#uint32) |  | Container backup factor (CBF) controls how deep NeoFS will search for alternative nodes to include into container's nodes subset. In total, the number of container nodes is Selector (used by Replica) count times CBF. This number is limited to 64 per-Replica and 512 overall. |
| selectors | [Selector](#neo.fs.v2.netmap.Selector) | repeated | Set of Selectors to form the container's nodes subset |
| filters | [Filter](#neo.fs.v2.netmap.Filter) | repeated | List of named filters to reference in selectors |
| subnet_id | [neo.fs.v2.refs.SubnetID](#neo.fs.v2.refs.SubnetID) |  | DEPRECATED. Was used for subnetwork ID to select nodes from, currently ignored. |


<a name="neo.fs.v2.netmap.Replica"></a>

### Message Replica
Number of object replicas in a set of nodes from the defined selector. If no
selector set, the root bucket containing all possible nodes will be used by
default.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| count | [uint32](#uint32) |  | How many object replicas to put. Limited to 8. |
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
| attribute | [string](#string) |  | Bucket attribute to select from |
| filter | [string](#string) |  | Filter reference to select from |

 <!-- end messages -->


<a name="neo.fs.v2.netmap.Clause"></a>

### Clause
Selector modifier shows how the node set will be formed. By default selector
just groups nodes into a bucket by attribute, selecting nodes only by their
hash distance.

| Name | Number | Description |
| ---- | ------ | ----------- |
| CLAUSE_UNSPECIFIED | 0 | No modifier defined. Nodes will be selected from the bucket randomly |
| SAME | 1 | SAME will select only nodes having the same value of bucket attribute |
| DISTINCT | 2 | DISTINCT will select nodes having different values of bucket attribute |



<a name="neo.fs.v2.netmap.NodeInfo.State"></a>

### NodeInfo.State
Represents the enumeration of various states of the NeoFS node.

| Name | Number | Description |
| ---- | ------ | ----------- |
| UNSPECIFIED | 0 | Unknown state |
| ONLINE | 1 | Active state in the network |
| OFFLINE | 2 | Network unavailable state |
| MAINTENANCE | 3 | Maintenance state |



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

