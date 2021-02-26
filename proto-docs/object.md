# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [object/service.proto](#object/service.proto)
 - Services
    - [ObjectService](#neo.fs.v2.object.ObjectService)
    
  - Messages
    - [DeleteRequest](#neo.fs.v2.object.DeleteRequest)
    - [DeleteRequest.Body](#neo.fs.v2.object.DeleteRequest.Body)
    - [DeleteResponse](#neo.fs.v2.object.DeleteResponse)
    - [DeleteResponse.Body](#neo.fs.v2.object.DeleteResponse.Body)
    - [GetRangeHashRequest](#neo.fs.v2.object.GetRangeHashRequest)
    - [GetRangeHashRequest.Body](#neo.fs.v2.object.GetRangeHashRequest.Body)
    - [GetRangeHashResponse](#neo.fs.v2.object.GetRangeHashResponse)
    - [GetRangeHashResponse.Body](#neo.fs.v2.object.GetRangeHashResponse.Body)
    - [GetRangeRequest](#neo.fs.v2.object.GetRangeRequest)
    - [GetRangeRequest.Body](#neo.fs.v2.object.GetRangeRequest.Body)
    - [GetRangeResponse](#neo.fs.v2.object.GetRangeResponse)
    - [GetRangeResponse.Body](#neo.fs.v2.object.GetRangeResponse.Body)
    - [GetRequest](#neo.fs.v2.object.GetRequest)
    - [GetRequest.Body](#neo.fs.v2.object.GetRequest.Body)
    - [GetResponse](#neo.fs.v2.object.GetResponse)
    - [GetResponse.Body](#neo.fs.v2.object.GetResponse.Body)
    - [GetResponse.Body.Init](#neo.fs.v2.object.GetResponse.Body.Init)
    - [HeadRequest](#neo.fs.v2.object.HeadRequest)
    - [HeadRequest.Body](#neo.fs.v2.object.HeadRequest.Body)
    - [HeadResponse](#neo.fs.v2.object.HeadResponse)
    - [HeadResponse.Body](#neo.fs.v2.object.HeadResponse.Body)
    - [HeaderWithSignature](#neo.fs.v2.object.HeaderWithSignature)
    - [PutRequest](#neo.fs.v2.object.PutRequest)
    - [PutRequest.Body](#neo.fs.v2.object.PutRequest.Body)
    - [PutRequest.Body.Init](#neo.fs.v2.object.PutRequest.Body.Init)
    - [PutResponse](#neo.fs.v2.object.PutResponse)
    - [PutResponse.Body](#neo.fs.v2.object.PutResponse.Body)
    - [Range](#neo.fs.v2.object.Range)
    - [SearchRequest](#neo.fs.v2.object.SearchRequest)
    - [SearchRequest.Body](#neo.fs.v2.object.SearchRequest.Body)
    - [SearchRequest.Body.Filter](#neo.fs.v2.object.SearchRequest.Body.Filter)
    - [SearchResponse](#neo.fs.v2.object.SearchResponse)
    - [SearchResponse.Body](#neo.fs.v2.object.SearchResponse.Body)
    

- [object/types.proto](#object/types.proto)

  - Messages
    - [Header](#neo.fs.v2.object.Header)
    - [Header.Attribute](#neo.fs.v2.object.Header.Attribute)
    - [Header.Split](#neo.fs.v2.object.Header.Split)
    - [Object](#neo.fs.v2.object.Object)
    - [ShortHeader](#neo.fs.v2.object.ShortHeader)
    - [SplitInfo](#neo.fs.v2.object.SplitInfo)
    

- [Scalar Value Types](#scalar-value-types)



<a name="object/service.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## object/service.proto




<a name="neo.fs.v2.object.ObjectService"></a>

### Service "neo.fs.v2.object.ObjectService"
`ObjectService` provides API for manipulating objects. Object operations do
not interact with sidechain and are only served by nodes in p2p style.

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

Receive full object structure, including Headers and payload. Response uses
gRPC stream. First response message carries object with requested address.
Chunk messages are parts of the object's payload if it is needed. All
messages, except the first one, carry payload chunks. Requested object can
be restored by concatenation of object message payload and all chunks
keeping receiving order.

| Name | Input | Output |
| ---- | ----- | ------ |
| Get | [GetRequest](#neo.fs.v2.object.GetRequest) | [GetResponse](#neo.fs.v2.object.GetResponse) |
#### Method Put

Put the object into container. Request uses gRPC stream. First message
SHOULD be of PutHeader type. `ContainerID` and `OwnerID` of an object
SHOULD be set. Session token SHOULD be obtained before `PUT` operation (see
session package). Chunk messages are considered by server as a part of an
object payload. All messages, except first one, SHOULD be payload chunks.
Chunk messages SHOULD be sent in direct order of fragmentation.

| Name | Input | Output |
| ---- | ----- | ------ |
| Put | [PutRequest](#neo.fs.v2.object.PutRequest) | [PutResponse](#neo.fs.v2.object.PutResponse) |
#### Method Delete

Delete the object from a container. There is no immediate removal
guarantee. Object will be marked for removal and deleted eventually.

| Name | Input | Output |
| ---- | ----- | ------ |
| Delete | [DeleteRequest](#neo.fs.v2.object.DeleteRequest) | [DeleteResponse](#neo.fs.v2.object.DeleteResponse) |
#### Method Head

Returns the object Headers without data payload. By default full header is
returned. If `main_only` request field is set, the short header with only
the very minimal information would be returned instead.

| Name | Input | Output |
| ---- | ----- | ------ |
| Head | [HeadRequest](#neo.fs.v2.object.HeadRequest) | [HeadResponse](#neo.fs.v2.object.HeadResponse) |
#### Method Search

Search objects in container. Search query allows to match by Object
Header's filed values. Please see the corresponding NeoFS Technical
Specification section for more details.

| Name | Input | Output |
| ---- | ----- | ------ |
| Search | [SearchRequest](#neo.fs.v2.object.SearchRequest) | [SearchResponse](#neo.fs.v2.object.SearchResponse) |
#### Method GetRange

Get byte range of data payload. Range is set as an (offset, length) tuple.
Like in `Get` method, the response uses gRPC stream. Requested range can be
restored by concatenation of all received payload chunks keeping receiving
order.

| Name | Input | Output |
| ---- | ----- | ------ |
| GetRange | [GetRangeRequest](#neo.fs.v2.object.GetRangeRequest) | [GetRangeResponse](#neo.fs.v2.object.GetRangeResponse) |
#### Method GetRangeHash

Returns homomorphic or regular hash of object's payload range after
applying XOR operation with the provided `salt`. Ranges are set of (offset,
length) tuples. Hashes order in response corresponds to ranges order in
request. Note that hash is calculated for XORed data.

| Name | Input | Output |
| ---- | ----- | ------ |
| GetRangeHash | [GetRangeHashRequest](#neo.fs.v2.object.GetRangeHashRequest) | [GetRangeHashResponse](#neo.fs.v2.object.GetRangeHashResponse) |
 <!-- end services -->


<a name="neo.fs.v2.object.DeleteRequest"></a>

### Message DeleteRequest
Object DELETE request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [DeleteRequest.Body](#neo.fs.v2.object.DeleteRequest.Body) |  | Body of delete object request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.DeleteRequest.Body"></a>

### Message DeleteRequest.Body
Object DELETE request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [neo.fs.v2.refs.Address](#neo.fs.v2.refs.Address) |  | Address of the object to be deleted |


<a name="neo.fs.v2.object.DeleteResponse"></a>

### Message DeleteResponse
DeleteResponse body is empty because we cannot guarantee permanent object
removal in distributed system.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [DeleteResponse.Body](#neo.fs.v2.object.DeleteResponse.Body) |  | Body of delete object response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.DeleteResponse.Body"></a>

### Message DeleteResponse.Body
Object DELETE Response has an empty body.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tombstone | [neo.fs.v2.refs.Address](#neo.fs.v2.refs.Address) |  | Address of the tombstone created for the deleted object |


<a name="neo.fs.v2.object.GetRangeHashRequest"></a>

### Message GetRangeHashRequest
Get hash of object's payload part


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRangeHashRequest.Body](#neo.fs.v2.object.GetRangeHashRequest.Body) |  | Body of get range hash object request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.GetRangeHashRequest.Body"></a>

### Message GetRangeHashRequest.Body
Get hash of object's payload part request body.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [neo.fs.v2.refs.Address](#neo.fs.v2.refs.Address) |  | Address of the object that containing the requested payload range |
| ranges | [Range](#neo.fs.v2.object.Range) | repeated | List of object's payload ranges to calculate homomorphic hash |
| salt | [bytes](#bytes) |  | Binary salt to XOR object's payload ranges before hash calculation |
| type | [neo.fs.v2.refs.ChecksumType](#neo.fs.v2.refs.ChecksumType) |  | Checksum algorithm type |


<a name="neo.fs.v2.object.GetRangeHashResponse"></a>

### Message GetRangeHashResponse
Get hash of object's payload part


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRangeHashResponse.Body](#neo.fs.v2.object.GetRangeHashResponse.Body) |  | Body of get range hash object response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.GetRangeHashResponse.Body"></a>

### Message GetRangeHashResponse.Body
Get hash of object's payload part response body.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| type | [neo.fs.v2.refs.ChecksumType](#neo.fs.v2.refs.ChecksumType) |  | Checksum algorithm type |
| hash_list | [bytes](#bytes) | repeated | List of range hashes in a binary format |


<a name="neo.fs.v2.object.GetRangeRequest"></a>

### Message GetRangeRequest
Request part of object's payload


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRangeRequest.Body](#neo.fs.v2.object.GetRangeRequest.Body) |  | Body of get range object request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.GetRangeRequest.Body"></a>

### Message GetRangeRequest.Body
Byte range of object's payload request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [neo.fs.v2.refs.Address](#neo.fs.v2.refs.Address) |  | Address of the object containing the requested payload range |
| range | [Range](#neo.fs.v2.object.Range) |  | Requested payload range |
| raw | [bool](#bool) |  | If `raw` flag is set, request will work only with objects that are physically stored on the peer node. |


<a name="neo.fs.v2.object.GetRangeResponse"></a>

### Message GetRangeResponse
Get part of object's payload


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRangeResponse.Body](#neo.fs.v2.object.GetRangeResponse.Body) |  | Body of get range object response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.GetRangeResponse.Body"></a>

### Message GetRangeResponse.Body
Get Range response body uses streams to transfer the response. Because
object payload considered a byte sequence, there is no need to have some
initial preamble message. The requested byte range is sent as a series
chunks.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| chunk | [bytes](#bytes) |  | Chunked object payload's range. |
| split_info | [SplitInfo](#neo.fs.v2.object.SplitInfo) |  | Meta information of split hierarchy. |


<a name="neo.fs.v2.object.GetRequest"></a>

### Message GetRequest
GET object request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRequest.Body](#neo.fs.v2.object.GetRequest.Body) |  | Body of get object request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.GetRequest.Body"></a>

### Message GetRequest.Body
GET Object request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [neo.fs.v2.refs.Address](#neo.fs.v2.refs.Address) |  | Address of the requested object |
| raw | [bool](#bool) |  | If `raw` flag is set, request will work only with objects that are physically stored on the peer node |


<a name="neo.fs.v2.object.GetResponse"></a>

### Message GetResponse
GET object response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetResponse.Body](#neo.fs.v2.object.GetResponse.Body) |  | Body of get object response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.GetResponse.Body"></a>

### Message GetResponse.Body
GET Object Response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| init | [GetResponse.Body.Init](#neo.fs.v2.object.GetResponse.Body.Init) |  | Initial part of the object stream |
| chunk | [bytes](#bytes) |  | Chunked object payload |
| split_info | [SplitInfo](#neo.fs.v2.object.SplitInfo) |  | Meta information of split hierarchy for object assembly. |


<a name="neo.fs.v2.object.GetResponse.Body.Init"></a>

### Message GetResponse.Body.Init
Initial part of the `Object` structure stream. Technically it's a
set of all `Object` structure's fields except `payload`.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object_id | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Object's unique identifier. |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signed `ObjectID` |
| header | [Header](#neo.fs.v2.object.Header) |  | Object metadata headers |


<a name="neo.fs.v2.object.HeadRequest"></a>

### Message HeadRequest
Object HEAD request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [HeadRequest.Body](#neo.fs.v2.object.HeadRequest.Body) |  | Body of head object request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.HeadRequest.Body"></a>

### Message HeadRequest.Body
Object HEAD request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [neo.fs.v2.refs.Address](#neo.fs.v2.refs.Address) |  | Address of the object with the requested Header |
| main_only | [bool](#bool) |  | Return only minimal header subset |
| raw | [bool](#bool) |  | If `raw` flag is set, request will work only with objects that are physically stored on the peer node |


<a name="neo.fs.v2.object.HeadResponse"></a>

### Message HeadResponse
Object HEAD response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [HeadResponse.Body](#neo.fs.v2.object.HeadResponse.Body) |  | Body of head object response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.HeadResponse.Body"></a>

### Message HeadResponse.Body
Object HEAD response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| header | [HeaderWithSignature](#neo.fs.v2.object.HeaderWithSignature) |  | Full object's `Header` with `ObjectID` signature |
| short_header | [ShortHeader](#neo.fs.v2.object.ShortHeader) |  | Short object header |
| split_info | [SplitInfo](#neo.fs.v2.object.SplitInfo) |  | Meta information of split hierarchy. |


<a name="neo.fs.v2.object.HeaderWithSignature"></a>

### Message HeaderWithSignature
Tuple of full object header and signature of `ObjectID`. \
Signed `ObjectID` is present to verify full header's authenticity through the
following steps:

1. Calculate `SHA-256` of marshalled `Header` structure
2. Check if the resulting hash matched `ObjectID`
3. Check if `ObjectID` signature in `signature` field is correct


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| header | [Header](#neo.fs.v2.object.Header) |  | Full object header |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signed `ObjectID` to verify full header's authenticity |


<a name="neo.fs.v2.object.PutRequest"></a>

### Message PutRequest
PUT object request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [PutRequest.Body](#neo.fs.v2.object.PutRequest.Body) |  | Body of put object request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.PutRequest.Body"></a>

### Message PutRequest.Body
PUT request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| init | [PutRequest.Body.Init](#neo.fs.v2.object.PutRequest.Body.Init) |  | Initial part of the object stream |
| chunk | [bytes](#bytes) |  | Chunked object payload |


<a name="neo.fs.v2.object.PutRequest.Body.Init"></a>

### Message PutRequest.Body.Init
Newly created object structure parameters. If some optional parameters
are not set, they will be calculated by a peer node.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object_id | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | ObjectID if available. |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Object signature if available |
| header | [Header](#neo.fs.v2.object.Header) |  | Object's Header |
| copies_number | [uint32](#uint32) |  | Number of the object copies to store within the RPC call. By default object is processed according to the container's placement policy. |


<a name="neo.fs.v2.object.PutResponse"></a>

### Message PutResponse
PUT Object response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [PutResponse.Body](#neo.fs.v2.object.PutResponse.Body) |  | Body of put object response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.PutResponse.Body"></a>

### Message PutResponse.Body
PUT Object response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object_id | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Identifier of the saved object |


<a name="neo.fs.v2.object.Range"></a>

### Message Range
Object payload range.Ranges of zero length SHOULD be considered as invalid.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| offset | [uint64](#uint64) |  | Offset of the range from the object payload start |
| length | [uint64](#uint64) |  | Length in bytes of the object payload range |


<a name="neo.fs.v2.object.SearchRequest"></a>

### Message SearchRequest
Object Search request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SearchRequest.Body](#neo.fs.v2.object.SearchRequest.Body) |  | Body of search object request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.SearchRequest.Body"></a>

### Message SearchRequest.Body
Object Search request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Container identifier were to search |
| version | [uint32](#uint32) |  | Version of the Query Language used |
| filters | [SearchRequest.Body.Filter](#neo.fs.v2.object.SearchRequest.Body.Filter) | repeated | List of search expressions |


<a name="neo.fs.v2.object.SearchRequest.Body.Filter"></a>

### Message SearchRequest.Body.Filter
Filter structure checks if object header field or attribute content
matches a value.

If no filters set, search request will return all objects of the
container, including Regular object, Tombstones and Storage Group
objects. Most human users expect to get only object they can directly
work with. In that case the `$Object:ROOT` filter should be used.

By default `key` field refers to the corresponding object's `Attribute`.
Some Object's header fields can also be accessed by adding `$Object:`
prefix to the name. Here is the list of fields available via this prefix:

* $Object:version \
  version
* $Object:objectID \
  object_id
* $Object:containerID \
  container_id
* $Object:ownerID \
  owner_id
* $Object:creationEpoch \
  creation_epoch
* $Object:payloadLength \
  payload_length
* $Object:payloadHash \
  payload_hash
* $Object:objectType \
  object_type
* $Object:homomorphicHash \
  homomorphic_hash
* $Object:split.parent \
  object_id of parent
* $Object:split.splitID \
  16 byte UUIDv4 used to identify the split object hierarchy parts

There are some well-known filter aliases to match objects by certain
properties:

* $Object:ROOT \
  Returns only `REGULAR` type objects that are not split or are the top
  level root objects in a split hierarchy. This includes objects not
  present physically, like large objects split into smaller objects
  without separate top-level root object. Other type objects like
  StorageGroups and Tombstones will not be shown. This filter may be
  useful for listing objects like `ls` command of some virtual file
  system. This filter is activated if the `key` exists, disregarding the
  value and matcher type.
* $Object:PHY \
  Returns only objects physically stored in the system. This filter is
  activated if the `key` exists, disregarding the value and matcher type.

Note: using filters with a key with prefix `$Object:` and match type
`NOT_PRESENT `is not recommended since this is not a cross-version approach.
Behavior when processing this kind of filters is undefined.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| match_type | [MatchType](#neo.fs.v2.object.MatchType) |  | Match type to use |
| key | [string](#string) |  | Attribute or Header fields to match |
| value | [string](#string) |  | Value to match |


<a name="neo.fs.v2.object.SearchResponse"></a>

### Message SearchResponse
Search response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SearchResponse.Body](#neo.fs.v2.object.SearchResponse.Body) |  | Body of search object response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.SearchResponse.Body"></a>

### Message SearchResponse.Body
Object Search response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id_list | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) | repeated | List of `ObjectID`s that match the search query |

 <!-- end messages -->

 <!-- end enums -->



<a name="object/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## object/types.proto


 <!-- end services -->


<a name="neo.fs.v2.object.Header"></a>

### Message Header
Object Header


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Object format version. Effectively the version of API library used to create particular object |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Object's container |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Object's owner |
| creation_epoch | [uint64](#uint64) |  | Object creation Epoch |
| payload_length | [uint64](#uint64) |  | Size of payload in bytes. `0xFFFFFFFFFFFFFFFF` means `payload_length` is unknown. |
| payload_hash | [neo.fs.v2.refs.Checksum](#neo.fs.v2.refs.Checksum) |  | Hash of payload bytes |
| object_type | [ObjectType](#neo.fs.v2.object.ObjectType) |  | Type of the object payload content |
| homomorphic_hash | [neo.fs.v2.refs.Checksum](#neo.fs.v2.refs.Checksum) |  | Homomorphic hash of the object payload |
| session_token | [neo.fs.v2.session.SessionToken](#neo.fs.v2.session.SessionToken) |  | Session token, if it was used during Object creation. Need it to verify integrity and authenticity out of Request scope. |
| attributes | [Header.Attribute](#neo.fs.v2.object.Header.Attribute) | repeated | User-defined object attributes |
| split | [Header.Split](#neo.fs.v2.object.Header.Split) |  | Position of the object in the split hierarchy |


<a name="neo.fs.v2.object.Header.Attribute"></a>

### Message Header.Attribute
`Attribute` is a user-defined Key-Value metadata pair attached to the
object.

Key name must be a object-unique valid UTF-8 string. Value can't be empty.
Objects with duplicated attribute names or attributes with empty values
will be considered invalid.

There are some "well-known" attributes starting with `__NEOFS__` prefix
that affect system behaviour:

* __NEOFS__UPLOAD_ID \
  Marks smaller parts of a split bigger object
* __NEOFS__EXPIRATION_EPOCH \
  Tells GC to delete object after that epoch

And some well-known attributes used by applications only:

* Name \
  Human-friendly name
* FileName \
  File name to be associated with the object on saving
* Timestamp \
  User-defined local time of object creation in Unix Timestamp format

For detailed description of each well-known attribute please see the
corresponding section in NeoFS Technical specification.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | string key to the object attribute |
| value | [string](#string) |  | string value of the object attribute |


<a name="neo.fs.v2.object.Header.Split"></a>

### Message Header.Split
Bigger objects can be split into a chain of smaller objects. Information
about inter-dependencies between spawned objects and how to re-construct
the original one is in the `Split` headers. Parent and children objects
must be within the same container.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| parent | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Identifier of the origin object. Known only to the minor child. |
| previous | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Identifier of the left split neighbor |
| parent_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | `signature` field of the parent object. Used to reconstruct parent. |
| parent_header | [Header](#neo.fs.v2.object.Header) |  | `header` field of the parent object. Used to reconstruct parent. |
| children | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) | repeated | List of identifiers of the objects generated by splitting current one. |
| split_id | [bytes](#bytes) |  | 16 byte UUIDv4 used to identify the split object hierarchy parts. Must be unique inside container. All objects participating in the split must have the same `split_id` value. |


<a name="neo.fs.v2.object.Object"></a>

### Message Object
Object structure. Object is immutable and content-addressed. It means
`ObjectID` will change if header or payload changes. It's calculated as a
hash of header field, which contains hash of object's payload.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object_id | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Object's unique identifier. |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signed object_id |
| header | [Header](#neo.fs.v2.object.Header) |  | Object metadata headers |
| payload | [bytes](#bytes) |  | Payload bytes |


<a name="neo.fs.v2.object.ShortHeader"></a>

### Message ShortHeader
Short header fields


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Object format version. Effectively the version of API library used to create particular object. |
| creation_epoch | [uint64](#uint64) |  | Epoch when the object was created |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Object's owner |
| object_type | [ObjectType](#neo.fs.v2.object.ObjectType) |  | Type of the object payload content |
| payload_length | [uint64](#uint64) |  | Size of payload in bytes. `0xFFFFFFFFFFFFFFFF` means `payload_length` is unknown |
| payload_hash | [neo.fs.v2.refs.Checksum](#neo.fs.v2.refs.Checksum) |  | Hash of payload bytes |
| homomorphic_hash | [neo.fs.v2.refs.Checksum](#neo.fs.v2.refs.Checksum) |  | Homomorphic hash of the object payload |


<a name="neo.fs.v2.object.SplitInfo"></a>

### Message SplitInfo
Meta information of split hierarchy for object assembly. With last part
one can traverse linked list of split hierarchy back to first part and
assemble original object. With linking object one can assembly object
straight away from the object parts.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| split_id | [bytes](#bytes) |  | 16 byte UUID used to identify the split object hierarchy parts. |
| last_part | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Identifier of the last object in split hierarchy parts. It contains split header with original object header. |
| link | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Identifier of linking object for split hierarchy parts. It contains split header with original object header and sorted list of object parts. |

 <!-- end messages -->


<a name="neo.fs.v2.object.MatchType"></a>

### MatchType
Type of match expression

| Name | Number | Description |
| ---- | ------ | ----------- |
| MATCH_TYPE_UNSPECIFIED | 0 | Unknown. Not used |
| STRING_EQUAL | 1 | Full string match |
| STRING_NOT_EQUAL | 2 | Full string mismatch |
| NOT_PRESENT | 3 | Lack of key |



<a name="neo.fs.v2.object.ObjectType"></a>

### ObjectType
Type of the object payload content. Only `REGULAR` type objects can be split,
hence `TOMBSTONE` and `STORAGEGROUP` payload is limited by maximal object
size.

String presentation of object type is PascalCased `ObjectType` enumeration
item name:
* Regular
* Tombstone
* StorageGroup

| Name | Number | Description |
| ---- | ------ | ----------- |
| REGULAR | 0 | Just a normal object |
| TOMBSTONE | 1 | Used internally to identify deleted objects |
| STORAGE_GROUP | 2 | StorageGroup information |


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

