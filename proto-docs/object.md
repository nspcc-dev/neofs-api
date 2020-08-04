# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [object/service.proto](#object/service.proto)
 - Services
    - [Service](#object.Service)
    
  - Messages
    - [DeleteRequest](#object.DeleteRequest)
    - [DeleteResponse](#object.DeleteResponse)
    - [GetRangeHashRequest](#object.GetRangeHashRequest)
    - [GetRangeHashResponse](#object.GetRangeHashResponse)
    - [GetRangeRequest](#object.GetRangeRequest)
    - [GetRangeResponse](#object.GetRangeResponse)
    - [GetRequest](#object.GetRequest)
    - [GetResponse](#object.GetResponse)
    - [HeadRequest](#object.HeadRequest)
    - [HeadResponse](#object.HeadResponse)
    - [PutRequest](#object.PutRequest)
    - [PutRequest.PutHeader](#object.PutRequest.PutHeader)
    - [PutResponse](#object.PutResponse)
    - [Range](#object.Range)
    - [SearchRequest](#object.SearchRequest)
    - [SearchResponse](#object.SearchResponse)
    

- [object/types.proto](#object/types.proto)

  - Messages
    - [Attribute](#object.Attribute)
    - [ExtendedHeader](#object.ExtendedHeader)
    - [Header](#object.Header)
    - [IntegrityHeader](#object.IntegrityHeader)
    - [Object](#object.Object)
    - [SplitHeader](#object.SplitHeader)
    - [SystemHeader](#object.SystemHeader)
    - [Tombstone](#object.Tombstone)
    

- [Scalar Value Types](#scalar-value-types)



<a name="object/service.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## object/service.proto




<a name="object.Service"></a>

### Service "object.Service"
Object service provides API for manipulating with the object.

```
rpc Get(GetRequest) returns (stream GetResponse);
rpc Put(stream PutRequest) returns (PutResponse);
rpc Delete(DeleteRequest) returns (DeleteResponse);
rpc Head(HeadRequest) returns (HeadResponse);
rpc Search(SearchRequest) returns (stream SearchResponse);
rpc GetRange(GetRangeRequest) returns (stream GetRangeResponse);
rpc GetRangeHash(GetRangeHashRequest) returns (GetRangeHashResponse);

```

#### Method Get

Get the object from container. Response uses gRPC stream. First response
message carry object of requested address. Chunk messages are parts of
the object's payload if it is needed. All messages except first carry
chunks. Requested object can be restored by concatenation of object
message payload and all chunks keeping receiving order.

| Name | Input | Output |
| ---- | ----- | ------ |
| Get | [GetRequest](#object.GetRequest) | [GetResponse](#object.GetResponse) |
#### Method Put

Put the object into container. Request uses gRPC stream. First message
SHOULD BE type of PutHeader. Container id and Owner id of object SHOULD
BE set. Session token SHOULD BE obtained before put operation (see
session package). Chunk messages considered by server as part of object
payload. All messages except first SHOULD BE chunks. Chunk messages
SHOULD BE sent in direct order of fragmentation.

| Name | Input | Output |
| ---- | ----- | ------ |
| Put | [PutRequest](#object.PutRequest) | [PutResponse](#object.PutResponse) |
#### Method Delete

Delete the object from a container

| Name | Input | Output |
| ---- | ----- | ------ |
| Delete | [DeleteRequest](#object.DeleteRequest) | [DeleteResponse](#object.DeleteResponse) |
#### Method Head

Head returns the object without data payload. Object in the
response has system header only. If full headers flag is set, extended
headers are also present.

| Name | Input | Output |
| ---- | ----- | ------ |
| Head | [HeadRequest](#object.HeadRequest) | [HeadResponse](#object.HeadResponse) |
#### Method Search

Search objects in container. Version of query language format SHOULD BE
set to 1. Search query represented in serialized format (see query
package).

| Name | Input | Output |
| ---- | ----- | ------ |
| Search | [SearchRequest](#object.SearchRequest) | [SearchResponse](#object.SearchResponse) |
#### Method GetRange

GetRange of data payload. Range is a pair (offset, length).
Requested range can be restored by concatenation of all chunks
keeping receiving order.

| Name | Input | Output |
| ---- | ----- | ------ |
| GetRange | [GetRangeRequest](#object.GetRangeRequest) | [GetRangeResponse](#object.GetRangeResponse) |
#### Method GetRangeHash

GetRangeHash returns homomorphic hash of object payload range after XOR
operation. Ranges are set of pairs (offset, length). Hashes order in
response corresponds to ranges order in request. Homomorphic hash is
calculated for XORed data.

| Name | Input | Output |
| ---- | ----- | ------ |
| GetRangeHash | [GetRangeHashRequest](#object.GetRangeHashRequest) | [GetRangeHashResponse](#object.GetRangeHashResponse) |
 <!-- end services -->


<a name="object.DeleteRequest"></a>

### Message DeleteRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Address | [refs.Address](#refs.Address) |  | Address of object (container id + object id) |
| OwnerID | [bytes](#bytes) |  | OwnerID is a wallet address |
| Meta | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | RequestMetaHeader contains information about request meta headers (should be embedded into message) |
| Verify | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | RequestVerificationHeader is a set of signatures of every NeoFS Node that processed request (should be embedded into message) |


<a name="object.DeleteResponse"></a>

### Message DeleteResponse
DeleteResponse is empty because we cannot guarantee permanent object removal
in distributed system.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Meta | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | ResponseMetaHeader contains meta information based on request processing by server (should be embedded into message) |


<a name="object.GetRangeHashRequest"></a>

### Message GetRangeHashRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Address | [refs.Address](#refs.Address) |  | Address of object (container id + object id) |
| Ranges | [Range](#object.Range) | repeated | Ranges of object's payload to calculate homomorphic hash |
| Salt | [bytes](#bytes) |  | Salt is used to XOR object's payload ranges before hashing, it can be nil |
| Meta | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | RequestMetaHeader contains information about request meta headers (should be embedded into message) |
| Verify | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | RequestVerificationHeader is a set of signatures of every NeoFS Node that processed request (should be embedded into message) |


<a name="object.GetRangeHashResponse"></a>

### Message GetRangeHashResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Hashes | [bytes](#bytes) | repeated | Hashes is a homomorphic hashes of all ranges |
| Meta | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | ResponseMetaHeader contains meta information based on request processing by server (should be embedded into message) |


<a name="object.GetRangeRequest"></a>

### Message GetRangeRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Address | [refs.Address](#refs.Address) |  | Address of object (container id + object id) |
| Range | [Range](#object.Range) |  | Range of object's payload to return |
| Meta | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | RequestMetaHeader contains information about request meta headers (should be embedded into message) |
| Verify | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | RequestVerificationHeader is a set of signatures of every NeoFS Node that processed request (should be embedded into message) |


<a name="object.GetRangeResponse"></a>

### Message GetRangeResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Fragment | [bytes](#bytes) |  | Fragment of object's payload |
| Meta | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | ResponseMetaHeader contains meta information based on request processing by server (should be embedded into message) |


<a name="object.GetRequest"></a>

### Message GetRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Address | [refs.Address](#refs.Address) |  | Address of object (container id + object id) |
| Meta | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | RequestMetaHeader contains information about request meta headers (should be embedded into message) |
| Verify | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | RequestVerificationHeader is a set of signatures of every NeoFS Node that processed request (should be embedded into message) |


<a name="object.GetResponse"></a>

### Message GetResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object | [Object](#object.Object) |  | Object header and some payload |
| Chunk | [bytes](#bytes) |  | Chunk of remaining payload |
| Meta | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | ResponseMetaHeader contains meta information based on request processing by server (should be embedded into message) |


<a name="object.HeadRequest"></a>

### Message HeadRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Address | [refs.Address](#refs.Address) |  | Address of object (container id + object id) |
| FullHeaders | [bool](#bool) |  | FullHeaders can be set true for extended headers in the object |
| Meta | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | RequestMetaHeader contains information about request meta headers (should be embedded into message) |
| Verify | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | RequestVerificationHeader is a set of signatures of every NeoFS Node that processed request (should be embedded into message) |


<a name="object.HeadResponse"></a>

### Message HeadResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Object | [Object](#object.Object) |  | Object without payload |
| Meta | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | ResponseMetaHeader contains meta information based on request processing by server (should be embedded into message) |


<a name="object.PutRequest"></a>

### Message PutRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Header | [PutRequest.PutHeader](#object.PutRequest.PutHeader) |  | Header should be the first message in the stream |
| Chunk | [bytes](#bytes) |  | Chunk should be a remaining message in stream should be chunks |
| Meta | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | RequestMetaHeader contains information about request meta headers (should be embedded into message) |
| Verify | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | RequestVerificationHeader is a set of signatures of every NeoFS Node that processed request (should be embedded into message) |


<a name="object.PutRequest.PutHeader"></a>

### Message PutRequest.PutHeader



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Object | [Object](#object.Object) |  | Object with at least container id and owner id fields |
| CopiesNumber | [uint32](#uint32) |  | Number of the object copies to store within the RPC call (zero is processed according to the placement rules) |


<a name="object.PutResponse"></a>

### Message PutResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Address | [refs.Address](#refs.Address) |  | Address of object (container id + object id) |
| Meta | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | ResponseMetaHeader contains meta information based on request processing by server (should be embedded into message) |


<a name="object.Range"></a>

### Message Range



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Offset | [uint64](#uint64) |  | Offset of the data range |
| Length | [uint64](#uint64) |  | Length of the data range |


<a name="object.SearchRequest"></a>

### Message SearchRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| ContainerID | [bytes](#bytes) |  | ContainerID for searching the object |
| Query | [bytes](#bytes) |  | Query in the binary serialized format |
| QueryVersion | [uint32](#uint32) |  | QueryVersion is a version of search query format |
| Meta | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | RequestMetaHeader contains information about request meta headers (should be embedded into message) |
| Verify | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | RequestVerificationHeader is a set of signatures of every NeoFS Node that processed request (should be embedded into message) |


<a name="object.SearchResponse"></a>

### Message SearchResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Addresses | [refs.Address](#refs.Address) | repeated | Addresses of found objects |
| Meta | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | ResponseMetaHeader contains meta information based on request processing by server (should be embedded into message) |

 <!-- end messages -->

 <!-- end enums -->



<a name="object/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## object/types.proto


 <!-- end services -->


<a name="object.Attribute"></a>

### Message Attribute
Attribute groups the parameters of the object attributes.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Key | [string](#string) |  | Key carries the string key to the object attribute. |
| Value | [string](#string) |  | Value carries the string value of the object attribute. |


<a name="object.ExtendedHeader"></a>

### Message ExtendedHeader



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Integrity | [IntegrityHeader](#object.IntegrityHeader) |  | Integrity header with checksum of all above headers in the object |
| Attributes | [Attribute](#object.Attribute) | repeated | Attributes carries list of the object attributes in a string key-value format. |
| CreationEpoch | [uint64](#uint64) |  | CreationEpoch carries number of NeoFS epoch on which the object was created. |
| Tombstone | [Tombstone](#object.Tombstone) |  | Tombstone header that set up in deleted objects |
| HomoHash | [bytes](#bytes) |  | HomoHash is a homomorphic hash of original object payload |
| StorageGroup | [storagegroup.StorageGroup](#storagegroup.StorageGroup) |  | StorageGroup contains meta information for the data audit |
| SplitHeader | [SplitHeader](#object.SplitHeader) |  | Split carries the position of the object in the split hierarchy. |


<a name="object.Header"></a>

### Message Header
Header groups the information about the NeoFS object.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| SystemHeader | [SystemHeader](#object.SystemHeader) |  | SystemHeader describes system header |
| ExtendedHeader | [ExtendedHeader](#object.ExtendedHeader) |  | ExtendedHeader carries the additional part of the header. |


<a name="object.IntegrityHeader"></a>

### Message IntegrityHeader



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| PayloadChecksum | [bytes](#bytes) |  | PayloadChecksum carries the checksum of object payload bytes. Changing any byte of the payload changes the checksum. It is calculated as a SHA-256 hash over payload bytes. |
| HeaderChecksum | [bytes](#bytes) |  | HeaderChecksum carries checksum of the object header structure. It covers all object attributes. Changing any field of the object except CreatorKey and ChecksumSignature changes the checksum. PayloadChecksum and HeaderChecksum cannot be merged due to the need to verify the header in the absence of a payload (e.g. in object.Head rpc). It is calculated as a SHA-256 hash over marshaled object header with cut CreatorKey and ChecksumSignature. |
| SessionToken | [service.Token](#service.Token) |  | SessionToken carries token of the session within which the object was created. If session token is presented in object, it acts as the user's proof of the correctness of the CreatorKey. |
| CreatorKey | [bytes](#bytes) |  | CreatorKey carries public key of the object creator in a binary format. |
| ChecksumSignature | [bytes](#bytes) |  | ChecksumSignature is an user's signature of checksum to verify if it is correct |


<a name="object.Object"></a>

### Message Object



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Header | [Header](#object.Header) |  | Header carries the object header. |
| Payload | [bytes](#bytes) |  | Payload is an object's payload |


<a name="object.SplitHeader"></a>

### Message SplitHeader
SplitHeader groups information about spawning the object through a payload splitting.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Parent | [refs.ObjectID](#refs.ObjectID) |  | Parent carries identifier of the origin object. |
| Previous | [refs.ObjectID](#refs.ObjectID) |  | Previous carries identifier of the left split neighbor. |
| Next | [refs.ObjectID](#refs.ObjectID) |  | Previous carries identifier of the right split neighbor. |
| Children | [refs.ObjectID](#refs.ObjectID) | repeated | Children carries list of identifiers of the objects generated by splitting the current. |
| Origin | [Header](#object.Header) |  | Origin carries the header of the origin object. |


<a name="object.SystemHeader"></a>

### Message SystemHeader



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| PayloadLength | [uint64](#uint64) |  | PayloadLength is an object payload length |
| Address | [refs.Address](#refs.Address) |  | Address carries object address in the NeoFS system. It encapsulates the object and the container identifiers. |
| OwnerID | [bytes](#bytes) |  | OwnerID is a wallet address |


<a name="object.Tombstone"></a>

### Message Tombstone



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

