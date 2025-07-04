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
    - [ReplicateRequest](#neo.fs.v2.object.ReplicateRequest)
    - [ReplicateResponse](#neo.fs.v2.object.ReplicateResponse)
    - [SearchRequest](#neo.fs.v2.object.SearchRequest)
    - [SearchRequest.Body](#neo.fs.v2.object.SearchRequest.Body)
    - [SearchResponse](#neo.fs.v2.object.SearchResponse)
    - [SearchResponse.Body](#neo.fs.v2.object.SearchResponse.Body)
    - [SearchV2Request](#neo.fs.v2.object.SearchV2Request)
    - [SearchV2Request.Body](#neo.fs.v2.object.SearchV2Request.Body)
    - [SearchV2Response](#neo.fs.v2.object.SearchV2Response)
    - [SearchV2Response.Body](#neo.fs.v2.object.SearchV2Response.Body)
    - [SearchV2Response.OIDWithMeta](#neo.fs.v2.object.SearchV2Response.OIDWithMeta)
    

- [object/types.proto](#object/types.proto)

  - Messages
    - [Header](#neo.fs.v2.object.Header)
    - [Header.Attribute](#neo.fs.v2.object.Header.Attribute)
    - [Header.Split](#neo.fs.v2.object.Header.Split)
    - [Object](#neo.fs.v2.object.Object)
    - [SearchFilter](#neo.fs.v2.object.SearchFilter)
    - [ShortHeader](#neo.fs.v2.object.ShortHeader)
    - [SplitInfo](#neo.fs.v2.object.SplitInfo)
    

- [Scalar Value Types](#scalar-value-types)



<a name="object/service.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## object/service.proto




<a name="neo.fs.v2.object.ObjectService"></a>

### Service "neo.fs.v2.object.ObjectService"
`ObjectService` provides API for manipulating objects. Object operations do
not affect FS chain and are only served by nodes in P2P style.

```
rpc Get(GetRequest) returns (stream GetResponse);
rpc Put(stream PutRequest) returns (PutResponse);
rpc Delete(DeleteRequest) returns (DeleteResponse);
rpc Head(HeadRequest) returns (HeadResponse);
rpc Search(SearchRequest) returns (stream SearchResponse);
rpc SearchV2(SearchV2Request) returns (SearchV2Response);
rpc GetRange(GetRangeRequest) returns (stream GetRangeResponse);
rpc GetRangeHash(GetRangeHashRequest) returns (GetRangeHashResponse);
rpc Replicate(ReplicateRequest) returns (ReplicateResponse);

```

#### Method Get

Receive full object structure, including Headers and payload. Response uses
gRPC stream. First response message carries the object with the requested address.
Chunk messages are parts of the object's payload if it is needed. All
messages, except the first one, carry payload chunks. The requested object can
be restored by concatenation of object message payload and all chunks
keeping the receiving order.

Extended headers can change `Get` behaviour:
* __NEOFS__NETMAP_EPOCH \
  Will use the requsted version of Network Map for object placement
  calculation. DEPRECATED: header ignored by servers.
* __NEOFS__NETMAP_LOOKUP_DEPTH \
  Will try older versions (starting from `__NEOFS__NETMAP_EPOCH` if specified or
  the latest one otherwise) of Network Map to find an object until the depth
  limit is reached. DEPRECATED: header ignored by servers.

Please refer to detailed `XHeader` description.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  object has been successfully read;
- Common failures (SECTION_FAILURE_COMMON);
- **ACCESS_DENIED** (2048, SECTION_OBJECT): \
  read access to the object is denied;
- **OBJECT_NOT_FOUND** (2049, SECTION_OBJECT): \
  object not found in container;
- **OBJECT_ALREADY_REMOVED** (2052, SECTION_OBJECT): \
  the requested object has been marked as deleted;
- **CONTAINER_NOT_FOUND** (3072, SECTION_CONTAINER): \
  object container not found;
- **TOKEN_EXPIRED** (4097, SECTION_SESSION): \
  provided session token has expired.

| Name | Input | Output |
| ---- | ----- | ------ |
| Get | [GetRequest](#neo.fs.v2.object.GetRequest) | [GetResponse](#neo.fs.v2.object.GetResponse) |
#### Method Put

Put the object into container. Request uses gRPC stream. First message
SHOULD be of PutHeader type. `ContainerID` and `OwnerID` of an object
SHOULD be set. Session token SHOULD be obtained before `PUT` operation (see
session package). Chunk messages are considered by server as a part of an
object payload. All messages, except first one, SHOULD be payload chunks.
Chunk messages SHOULD be sent in the direct order of fragmentation.

Extended headers can change `Put` behaviour:
* __NEOFS__NETMAP_EPOCH \
  Will use the requsted version of Network Map for object placement
  calculation. DEPRECATED: header ignored by servers.

Please refer to detailed `XHeader` description.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  object has been successfully saved in the container;
- Common failures (SECTION_FAILURE_COMMON);
- **ACCESS_DENIED** (2048, SECTION_OBJECT): \
  write access to the container is denied;
- **LOCKED** (2050, SECTION_OBJECT): \
  placement of an object of type TOMBSTONE that includes at least one locked
  object is prohibited;
- **LOCK_NON_REGULAR_OBJECT** (2051, SECTION_OBJECT): \
  placement of an object of type LOCK that includes at least one object of
  type other than REGULAR is prohibited;
- **CONTAINER_NOT_FOUND** (3072, SECTION_CONTAINER): \
  object storage container not found;
- **TOKEN_NOT_FOUND** (4096, SECTION_SESSION): \
  (for trusted object preparation) session private key does not exist or has
been deleted;
- **TOKEN_EXPIRED** (4097, SECTION_SESSION): \
  provided session token has expired.

| Name | Input | Output |
| ---- | ----- | ------ |
| Put | [PutRequest](#neo.fs.v2.object.PutRequest) | [PutResponse](#neo.fs.v2.object.PutResponse) |
#### Method Delete

Delete the object from a container. There is no immediate removal
guarantee. Object will be marked for removal and deleted eventually.
Notice that some types of objects (see ObjectType) can not be removed,
currently it's Tombstone and Lock.

Extended headers can change `Delete` behaviour:
* __NEOFS__NETMAP_EPOCH \
  Will use the requsted version of Network Map for object placement
  calculation. DEPRECATED: header ignored by servers.

Please refer to detailed `XHeader` description.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  object has been successfully marked to be removed from the container;
- Common failures (SECTION_FAILURE_COMMON);
- **ACCESS_DENIED** (2048, SECTION_OBJECT): \
  delete access to the object is denied;
- **LOCKED** (2050, SECTION_OBJECT): \
  deleting a locked object is prohibited;
- **CONTAINER_NOT_FOUND** (3072, SECTION_CONTAINER): \
  object container not found;
- **TOKEN_EXPIRED** (4097, SECTION_SESSION): \
  provided session token has expired.

| Name | Input | Output |
| ---- | ----- | ------ |
| Delete | [DeleteRequest](#neo.fs.v2.object.DeleteRequest) | [DeleteResponse](#neo.fs.v2.object.DeleteResponse) |
#### Method Head

Returns the object Headers without data payload. By default full header is
returned. If `main_only` request field is set, the short header with only
the very minimal information will be returned instead.

Extended headers can change `Head` behaviour:
* __NEOFS__NETMAP_EPOCH \
  Will use the requsted version of Network Map for object placement
  calculation.

Please refer to detailed `XHeader` description.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  object header has been successfully read;
- Common failures (SECTION_FAILURE_COMMON);
- **ACCESS_DENIED** (2048, SECTION_OBJECT): \
  access to operation HEAD of the object is denied;
- **OBJECT_NOT_FOUND** (2049, SECTION_OBJECT): \
  object not found in container;
- **OBJECT_ALREADY_REMOVED** (2052, SECTION_OBJECT): \
  the requested object has been marked as deleted;
- **CONTAINER_NOT_FOUND** (3072, SECTION_CONTAINER): \
  object container not found;
- **TOKEN_EXPIRED** (4097, SECTION_SESSION): \
  provided session token has expired.

| Name | Input | Output |
| ---- | ----- | ------ |
| Head | [HeadRequest](#neo.fs.v2.object.HeadRequest) | [HeadResponse](#neo.fs.v2.object.HeadResponse) |
#### Method Search

Search objects in container. Search query allows to match by Object
Header's filed values. Please see the corresponding NeoFS Technical
Specification section for more details.

DEPRECATED: please use SearchV2.

Extended headers can change `Search` behaviour:
* __NEOFS__NETMAP_EPOCH \
  Will use the requsted version of Network Map for object placement
  calculation.

Please refer to detailed `XHeader` description.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  objects have been successfully selected;
- Common failures (SECTION_FAILURE_COMMON);
- **ACCESS_DENIED** (2048, SECTION_OBJECT): \
  access to operation SEARCH of the object is denied;
- **CONTAINER_NOT_FOUND** (3072, SECTION_CONTAINER): \
  search container not found;
- **TOKEN_EXPIRED** (4097, SECTION_SESSION): \
  provided session token has expired.

| Name | Input | Output |
| ---- | ----- | ------ |
| Search | [SearchRequest](#neo.fs.v2.object.SearchRequest) | [SearchResponse](#neo.fs.v2.object.SearchResponse) |
#### Method SearchV2

Search for objects in a container. Similar to Search, but:
* sorted
* limited in amount of returned data
* single message
* allows for additional header fields to be returned

Result is ordered by the 1st requested attribute (if any) and object ID.

| Name | Input | Output |
| ---- | ----- | ------ |
| SearchV2 | [SearchV2Request](#neo.fs.v2.object.SearchV2Request) | [SearchV2Response](#neo.fs.v2.object.SearchV2Response) |
#### Method GetRange

Get byte range of data payload. Range is set as an (offset, length) tuple.
Like in `Get` method, the response uses gRPC stream. Requested range can be
restored by concatenation of all received payload chunks keeping the receiving
order.

Extended headers can change `GetRange` behaviour:
* __NEOFS__NETMAP_EPOCH \
  Will use the requsted version of Network Map for object placement
  calculation. DEPRECATED: header ignored by servers.
* __NEOFS__NETMAP_LOOKUP_DEPTH \
  Will try older versions of Network Map to find an object until the depth
  limit is reached. DEPRECATED: header ignored by servers.

Please refer to detailed `XHeader` description.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  data range of the object payload has been successfully read;
- Common failures (SECTION_FAILURE_COMMON);
- **ACCESS_DENIED** (2048, SECTION_OBJECT): \
  access to operation RANGE of the object is denied;
- **OBJECT_NOT_FOUND** (2049, SECTION_OBJECT): \
  object not found in container;
- **OBJECT_ALREADY_REMOVED** (2052, SECTION_OBJECT): \
  the requested object has been marked as deleted.
- **OUT_OF_RANGE** (2053, SECTION_OBJECT): \
  the requested range is out of bounds;
- **CONTAINER_NOT_FOUND** (3072, SECTION_CONTAINER): \
  object container not found;
- **TOKEN_EXPIRED** (4097, SECTION_SESSION): \
  provided session token has expired.

| Name | Input | Output |
| ---- | ----- | ------ |
| GetRange | [GetRangeRequest](#neo.fs.v2.object.GetRangeRequest) | [GetRangeResponse](#neo.fs.v2.object.GetRangeResponse) |
#### Method GetRangeHash

Returns homomorphic or regular hash of object's payload range after
applying XOR operation with the provided `salt`. Ranges are set of (offset,
length) tuples. Hashes order in response corresponds to the ranges order in
the request. Note that hash is calculated for XORed data.

Extended headers can change `GetRangeHash` behaviour:
* __NEOFS__NETMAP_EPOCH \
  Will use the requsted version of Network Map for object placement
  calculation. DEPRECATED: header ignored by servers.
* __NEOFS__NETMAP_LOOKUP_DEPTH \
  Will try older versions of Network Map to find an object until the depth
  limit is reached. DEPRECATED: header ignored by servers.

Please refer to detailed `XHeader` description.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  data range of the object payload has been successfully hashed;
- Common failures (SECTION_FAILURE_COMMON);
- **ACCESS_DENIED** (2048, SECTION_OBJECT): \
  access to operation RANGEHASH of the object is denied;
- **OBJECT_NOT_FOUND** (2049, SECTION_OBJECT): \
  object not found in container;
- **OUT_OF_RANGE** (2053, SECTION_OBJECT): \
  the requested range is out of bounds;
- **CONTAINER_NOT_FOUND** (3072, SECTION_CONTAINER): \
  object container not found;
- **TOKEN_EXPIRED** (4097, SECTION_SESSION): \
  provided session token has expired.

| Name | Input | Output |
| ---- | ----- | ------ |
| GetRangeHash | [GetRangeHashRequest](#neo.fs.v2.object.GetRangeHashRequest) | [GetRangeHashResponse](#neo.fs.v2.object.GetRangeHashResponse) |
#### Method Replicate

Save replica of the object on the NeoFS storage node. Both client and
server must authenticate NeoFS storage nodes matching storage policy of
the container referenced by the replicated object. Thus, this operation is
purely system: regular users should not pay attention to it but use Put.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  the object has been successfully replicated;
- **INTERNAL_SERVER_ERROR** (1024, SECTION_FAILURE_COMMON): \
  internal server error described in the text message;
- **ACCESS_DENIED** (2048, SECTION_OBJECT): \
  the client does not authenticate any NeoFS storage node matching storage
  policy of the container referenced by the replicated object
- **CONTAINER_NOT_FOUND** (3072, SECTION_CONTAINER): \
  the container to which the replicated object is associated was not found.

| Name | Input | Output |
| ---- | ----- | ------ |
| Replicate | [ReplicateRequest](#neo.fs.v2.object.ReplicateRequest) | [ReplicateResponse](#neo.fs.v2.object.ReplicateResponse) |
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
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. DEPRECATED: Verify header and payload checksums instead. Servers MUST attach it for requests with `meta_header.version` <= 2.17. |


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
| main_only | [bool](#bool) |  | Return only minimal header subset.

DEPRECATED. This field is ignored. |
| raw | [bool](#bool) |  | If `raw` flag is set, request will work only with objects that are physically stored on the peer node |


<a name="neo.fs.v2.object.HeadResponse"></a>

### Message HeadResponse
Object HEAD response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [HeadResponse.Body](#neo.fs.v2.object.HeadResponse.Body) |  | Body of head object response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. DEPRECATED: Verify header and payload checksums instead. Servers MUST attach it for requests with `meta_header.version` <= 2.17. |


<a name="neo.fs.v2.object.HeadResponse.Body"></a>

### Message HeadResponse.Body
Object HEAD response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| header | [HeaderWithSignature](#neo.fs.v2.object.HeaderWithSignature) |  | Full object's `Header` with `ObjectID` signature |
| short_header | [ShortHeader](#neo.fs.v2.object.ShortHeader) |  | Short object header.

DEPRECATED. Use HeaderWithSignature instead. |
| split_info | [SplitInfo](#neo.fs.v2.object.SplitInfo) |  | Meta information of split hierarchy. |


<a name="neo.fs.v2.object.HeaderWithSignature"></a>

### Message HeaderWithSignature
Tuple of a full object header and signature of an `ObjectID`. \
Signed `ObjectID` is present to verify full header's authenticity through the
following steps:

1. Calculate `SHA-256` of the marshalled `Header` structure
2. Check if the resulting hash matches `ObjectID`
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
| header | [Header](#neo.fs.v2.object.Header) |  | Object's Header. The maximum length is 16KB. |
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
Object payload range. Ranges of zero length SHOULD be considered as invalid
except for the special 0:0 request which is interpreted as "get whole
payload" and allows to receive payload only when its size is not known.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| offset | [uint64](#uint64) |  | Offset of the range from the object payload start |
| length | [uint64](#uint64) |  | Length in bytes of the object payload range |


<a name="neo.fs.v2.object.ReplicateRequest"></a>

### Message ReplicateRequest
Replicate RPC request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object | [Object](#neo.fs.v2.object.Object) |  | Object to be replicated. |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signature of `object.object_id.value` field. |
| sign_object | [bool](#bool) |  | Optional flag that requires server side to attach signature of just replicated object to ensure it has been received correctly. Signature must be calculated with a key that corresponds to an exposed to the network map public key of the object receiver. |


<a name="neo.fs.v2.object.ReplicateResponse"></a>

### Message ReplicateResponse
Replicate RPC response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| status | [neo.fs.v2.status.Status](#neo.fs.v2.status.Status) |  | Operation execution status with one of the enumerated codes. |
| object_signature | [bytes](#bytes) |  | Deterministic ECDSA with SHA-256 hashing (RFC 6979) signature of replicated object. Must be attached if request was made with `sign_object` flag set. |


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
| filters | [SearchFilter](#neo.fs.v2.object.SearchFilter) | repeated | List of search expressions |


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


<a name="neo.fs.v2.object.SearchV2Request"></a>

### Message SearchV2Request
Object SearchV2 request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SearchV2Request.Body](#neo.fs.v2.object.SearchV2Request.Body) |  | Body of search object request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.SearchV2Request.Body"></a>

### Message SearchV2Request.Body
Object Search request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Container where the search is being performed. |
| version | [uint32](#uint32) |  | Version of the Query Language used. |
| filters | [SearchFilter](#neo.fs.v2.object.SearchFilter) | repeated | List of search expressions. Limited to 8. If additional attributes are requested (see attributes below) then the first filter's key MUST be the first requested attribute. '$Object:containerID' and '$Object:objectID' filters are prohibited. Numeric filters' values MUST be in range [-MaxUint256, MaxUint256]. |
| cursor | [string](#string) |  | Cursor to continue search. Can be omitted or empty for the new search. |
| count | [uint32](#uint32) |  | Limits the number of responses to the specified number. Can't be more than 1000. |
| attributes | [string](#string) | repeated | List of attribute names (including special ones as defined by SearchFilter key) to include into the reply. Limited to 8, these attributes also affect result ordering (result is ordered by the 1st one and then by OID). If additional attributes are requested, then the first filter's key (see filters above) MUST be the first requested attribute. '$Object:containerID' and '$Object:objectID' attributes are prohibited. If meta_header.ttl = 1 and the first filter is not STRING_EQUAL, values of the first filtered attribute are requested automatically. |


<a name="neo.fs.v2.object.SearchV2Response"></a>

### Message SearchV2Response
SearchV2 response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SearchV2Response.Body](#neo.fs.v2.object.SearchV2Response.Body) |  | Body of search object response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.SearchV2Response.Body"></a>

### Message SearchV2Response.Body
Main result structure.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| result | [SearchV2Response.OIDWithMeta](#neo.fs.v2.object.SearchV2Response.OIDWithMeta) | repeated | List of object IDs with additional requested attributes. |
| cursor | [string](#string) |  | Cursor that can be used for subsequent requests. For users it's an opaque string that is omitted or empty when there are no more results to list. For nodes to interoperate this is defined as the latest OID for queries without filters and primary (first) attribute value plus OID. Values are encoded in base64. |


<a name="neo.fs.v2.object.SearchV2Response.OIDWithMeta"></a>

### Message SearchV2Response.OIDWithMeta
OID with additional requested metadata.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Object ID that matches search criteria. |
| attributes | [string](#string) | repeated | List of attribute data from the respective object, fields strictly follow requested ones. The only exception are attribute-less requests with TTL = 1 and the first non-STRING_EQUAL filter: this field carry value of the first filtered attribute. |

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
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Object format version. Effectively, the version of API library used to create particular object |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Object's container |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Object's owner |
| creation_epoch | [uint64](#uint64) |  | Object creation Epoch |
| payload_length | [uint64](#uint64) |  | Size of payload in bytes. `0xFFFFFFFFFFFFFFFF` means `payload_length` is unknown. |
| payload_hash | [neo.fs.v2.refs.Checksum](#neo.fs.v2.refs.Checksum) |  | SHA256 hash of payload bytes |
| object_type | [ObjectType](#neo.fs.v2.object.ObjectType) |  | Type of the object payload content |
| homomorphic_hash | [neo.fs.v2.refs.Checksum](#neo.fs.v2.refs.Checksum) |  | Homomorphic hash of the object payload (Tillich-Zemor). |
| session_token | [neo.fs.v2.session.SessionToken](#neo.fs.v2.session.SessionToken) |  | Session token, if it was used during Object creation. Need it to verify integrity and authenticity out of Request scope. |
| attributes | [Header.Attribute](#neo.fs.v2.object.Header.Attribute) | repeated | User-defined object attributes. Attributes vary in length from object to object, so keep an eye on the entire Header limit depending on the context. |
| split | [Header.Split](#neo.fs.v2.object.Header.Split) |  | Position of the object in the split hierarchy |


<a name="neo.fs.v2.object.Header.Attribute"></a>

### Message Header.Attribute
`Attribute` is a user-defined Key-Value metadata pair attached to an
object.

Key name must be an object-unique valid UTF-8 string. Value can't be empty.
Objects with duplicated attribute names or attributes with empty values
will be considered invalid. Keys and values can't contain zero bytes as
well.

There are some "well-known" attributes starting with `__NEOFS__` prefix
that affect system behaviour:

* __NEOFS__EXPIRATION_EPOCH \
  Tells GC to delete object after that epoch (but object is available
  throughout the epoch specified in this attribute).
* __NEOFS__TICK_EPOCH \
  Decimal number that defines what epoch must produce
  object notification with UTF-8 object address in a
  body (`0` value produces notification right after
  object put).
  DEPRECATED: attribute ignored by servers.
* __NEOFS__TICK_TOPIC \
  UTF-8 string topic ID that is used for object notification.
  DEPRECATED: attribute ignored by servers.

And some well-known attributes used by applications only:

* Name \
  Human-friendly name
* FileName \
  File name to be associated with the object on saving
* FilePath \
  Full path to be associated with the object on saving. Should start with a
  '/' and use '/' as a delimiting symbol. Trailing '/' should be
  interpreted as a virtual directory marker. If an object has conflicting
  FilePath and FileName, FilePath should have higher priority, because it
  is used to construct the directory tree. FilePath with trailing '/' and
  non-empty FileName attribute should not be used together.
* Timestamp \
  User-defined local time of object creation in Unix Timestamp format
* Content-Type \
  MIME Content Type of object's payload

For detailed description of each well-known attribute please see the
corresponding section in NeoFS Technical Specification.


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
| children | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) | repeated | DEPRECATED. Was used before creating the separate LINK object type. Keep child objects list in the LINK object's payload. List of identifiers of the objects generated by splitting current one. |
| split_id | [bytes](#bytes) |  | DEPRECATED. Was used as an identifier of a split chain. Use the first part ID instead. 16 byte UUIDv4 used to identify the split object hierarchy parts. Must be unique inside container. All objects participating in the split must have the same `split_id` value. |
| first | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Identifier of the first part of the origin object. Known to all the split parts except the first one. Identifies the split and allows to differ them. |


<a name="neo.fs.v2.object.Object"></a>

### Message Object
Object structure. Object is immutable and content-addressed. It means
`ObjectID` will change if the header or the payload changes. It's calculated as a
hash of header field which contains hash of the object's payload.

For non-regular object types payload format depends on object type specified
in the header.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object_id | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Object's unique identifier. |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signed object_id |
| header | [Header](#neo.fs.v2.object.Header) |  | Object metadata headers |
| payload | [bytes](#bytes) |  | Payload bytes |


<a name="neo.fs.v2.object.SearchFilter"></a>

### Message SearchFilter
Filter structure checks if the object header field or the attribute content
matches a value.

If no filters are set, search request will return all objects of the
container, including Regular object, Tombstones and Storage Group
objects. Most human users expect to get only object they can directly
work with. In that case, `$Object:ROOT` filter should be used.

If `match_type` field is numerical, both `value` field and object
attribute MUST be base-10 integers.

By default `key` field refers to the corresponding object's `Attribute`.
Some Object's header fields can also be accessed by adding `$Object:`
prefix to the name. Here is the list of fields available via this prefix:

* $Object:version \
  version
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
* $Object:split.first \
  object_id of the first part in split chain; non-acceptable for deprecated V1 split scheme

There are some well-known filter aliases to match objects by certain
properties:

* $Object:ROOT \
  Returns only `REGULAR` type objects that are not split or that are the top
  level root objects in a split hierarchy. This includes objects not
  present physically, like large objects split into smaller objects
  without a separate top-level root object. Objects of other types like
  StorageGroups and Tombstones will not be shown. This filter may be
  useful for listing objects like `ls` command of some virtual file
  system. This filter is activated if the `key` exists, disregarding the
  value and matcher type.
* $Object:PHY \
  Returns only objects physically stored in the system. This filter is
  activated if the `key` exists, disregarding the value and matcher type.

Following filters are deprecated:

* $Object:objectID \
  object_id
* $Object:containerID \
  container_id

Note: using filters with a key with prefix `$Object:` and match type
`NOT_PRESENT `is not recommended since this is not a cross-version approach.
Behavior when processing this kind of filters is undefined.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| match_type | [MatchType](#neo.fs.v2.object.MatchType) |  | Match type to use |
| key | [string](#string) |  | Attribute or Header fields to match |
| value | [string](#string) |  | Value to match |


<a name="neo.fs.v2.object.ShortHeader"></a>

### Message ShortHeader
Short header fields

DEPRECATED. It is not supported in practice and should not be used. Use full
Header instead.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Object format version. Effectively, the version of API library used to create particular object. |
| creation_epoch | [uint64](#uint64) |  | Epoch when the object was created |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Object's owner |
| object_type | [ObjectType](#neo.fs.v2.object.ObjectType) |  | Type of the object payload content |
| payload_length | [uint64](#uint64) |  | Size of payload in bytes. `0xFFFFFFFFFFFFFFFF` means `payload_length` is unknown |
| payload_hash | [neo.fs.v2.refs.Checksum](#neo.fs.v2.refs.Checksum) |  | SHA256 hash of payload bytes. |
| homomorphic_hash | [neo.fs.v2.refs.Checksum](#neo.fs.v2.refs.Checksum) |  | Homomorphic hash of the object payload (Tillich-Zemor). |


<a name="neo.fs.v2.object.SplitInfo"></a>

### Message SplitInfo
Meta information of split hierarchy for object assembly. With the last part
one can traverse linked list of split hierarchy back to the first part and
assemble the original object. With a linking object one can assemble an object
right from the object parts.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| split_id | [bytes](#bytes) |  | DEPRECATED. Was used as an identifier of a split chain. Use the first part ID instead. 16 byte UUID used to identify the split object hierarchy parts. |
| last_part | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | The identifier of the last object in split hierarchy parts. It contains split header with the original object header. |
| link | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | The identifier of a linking object for split hierarchy parts. It contains split header with the original object header and a sorted list of object parts. |
| first_part | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Identifier of the first part of the origin object. Known to all the split parts except the first one. Identifies the split and allows to differ them. |

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
| COMMON_PREFIX | 4 | String prefix match |
| NUM_GT | 5 | Numerical 'greater than' |
| NUM_GE | 6 | Numerical 'greater or equal than' |
| NUM_LT | 7 | Numerical 'less than' |
| NUM_LE | 8 | Numerical 'less or equal than' |



<a name="neo.fs.v2.object.ObjectType"></a>

### ObjectType
Type of the object payload content. Only `REGULAR` type objects can be split,
hence `TOMBSTONE`, `STORAGE_GROUP` and `LOCK` payload is limited by the maximum
object size.

String presentation of object type is the same as definition:
* REGULAR
* TOMBSTONE
* STORAGE_GROUP
* LOCK
* LINK

| Name | Number | Description |
| ---- | ------ | ----------- |
| REGULAR | 0 | Just a normal object |
| TOMBSTONE | 1 | Used internally to identify deleted objects |
| STORAGE_GROUP | 2 | StorageGroup information |
| LOCK | 3 | Object lock |
| LINK | 4 | Object that stores child object IDs for the split objects. |


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

