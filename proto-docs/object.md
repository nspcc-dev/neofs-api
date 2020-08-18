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
    

- [Scalar Value Types](#scalar-value-types)



<a name="object/service.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## object/service.proto




<a name="neo.fs.v2.object.ObjectService"></a>

### Service "neo.fs.v2.object.ObjectService"
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
| Get | [GetRequest](#neo.fs.v2.object.GetRequest) | [GetResponse](#neo.fs.v2.object.GetResponse) |
#### Method Put

Put the object into container. Request uses gRPC stream. First message
SHOULD BE type of PutHeader. Container id and Owner id of object SHOULD
BE set. Session token SHOULD BE obtained before put operation (see
session package). Chunk messages considered by server as part of object
payload. All messages except first SHOULD BE chunks. Chunk messages
SHOULD BE sent in direct order of fragmentation.

| Name | Input | Output |
| ---- | ----- | ------ |
| Put | [PutRequest](#neo.fs.v2.object.PutRequest) | [PutResponse](#neo.fs.v2.object.PutResponse) |
#### Method Delete

Delete the object from a container

| Name | Input | Output |
| ---- | ----- | ------ |
| Delete | [DeleteRequest](#neo.fs.v2.object.DeleteRequest) | [DeleteResponse](#neo.fs.v2.object.DeleteResponse) |
#### Method Head

Head returns the object without data payload. Object in the
response has system header only. If full headers flag is set, extended
headers are also present.

| Name | Input | Output |
| ---- | ----- | ------ |
| Head | [HeadRequest](#neo.fs.v2.object.HeadRequest) | [HeadResponse](#neo.fs.v2.object.HeadResponse) |
#### Method Search

Search objects in container. Version of query language format SHOULD BE
set to 1. Search query represented in serialized format (see query
package).

| Name | Input | Output |
| ---- | ----- | ------ |
| Search | [SearchRequest](#neo.fs.v2.object.SearchRequest) | [SearchResponse](#neo.fs.v2.object.SearchResponse) |
#### Method GetRange

GetRange of data payload. Range is a pair (offset, length).
Requested range can be restored by concatenation of all chunks
keeping receiving order.

| Name | Input | Output |
| ---- | ----- | ------ |
| GetRange | [GetRangeRequest](#neo.fs.v2.object.GetRangeRequest) | [GetRangeResponse](#neo.fs.v2.object.GetRangeResponse) |
#### Method GetRangeHash

GetRangeHash returns homomorphic hash of object payload range after XOR
operation. Ranges are set of pairs (offset, length). Hashes order in
response corresponds to ranges order in request. Homomorphic hash is
calculated for XORed data.

| Name | Input | Output |
| ---- | ----- | ------ |
| GetRangeHash | [GetRangeHashRequest](#neo.fs.v2.object.GetRangeHashRequest) | [GetRangeHashResponse](#neo.fs.v2.object.GetRangeHashResponse) |
 <!-- end services -->


<a name="neo.fs.v2.object.DeleteRequest"></a>

### Message DeleteRequest
Object Delete request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [DeleteRequest.Body](#neo.fs.v2.object.DeleteRequest.Body) |  | Body of delete object request message. |
| meta_header | [neo.fs.v2.service.RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.DeleteRequest.Body"></a>

### Message DeleteRequest.Body
Request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [neo.fs.v2.refs.Address](#neo.fs.v2.refs.Address) |  | Carries the address of the object to be deleted. |


<a name="neo.fs.v2.object.DeleteResponse"></a>

### Message DeleteResponse
DeleteResponse is empty because we cannot guarantee permanent object removal
in distributed system.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [DeleteResponse.Body](#neo.fs.v2.object.DeleteResponse.Body) |  | Body of delete object response message. |
| meta_header | [neo.fs.v2.service.ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.DeleteResponse.Body"></a>

### Message DeleteResponse.Body
Response body



<a name="neo.fs.v2.object.GetRangeHashRequest"></a>

### Message GetRangeHashRequest
Get hash of object's payload part


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRangeHashRequest.Body](#neo.fs.v2.object.GetRangeHashRequest.Body) |  | Body of get range hash object request message. |
| meta_header | [neo.fs.v2.service.RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.GetRangeHashRequest.Body"></a>

### Message GetRangeHashRequest.Body
Request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [neo.fs.v2.refs.Address](#neo.fs.v2.refs.Address) |  | Carries address of the object that contains the requested payload range. |
| ranges | [Range](#neo.fs.v2.object.Range) | repeated | Carries the list of object payload range to calculate homomorphic hash. |
| salt | [bytes](#bytes) |  | Carries binary salt to XOR object payload ranges before hash calculation. |


<a name="neo.fs.v2.object.GetRangeHashResponse"></a>

### Message GetRangeHashResponse
Get hash of object's payload part


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRangeHashResponse.Body](#neo.fs.v2.object.GetRangeHashResponse.Body) |  | Body of get range hash object response message. |
| meta_header | [neo.fs.v2.service.ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.GetRangeHashResponse.Body"></a>

### Message GetRangeHashResponse.Body
Response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| hash_list | [bytes](#bytes) | repeated | Carries list of homomorphic hashes in a binary format. |


<a name="neo.fs.v2.object.GetRangeRequest"></a>

### Message GetRangeRequest
Request to get part of object's payload


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRangeRequest.Body](#neo.fs.v2.object.GetRangeRequest.Body) |  | Body of get range object request message. |
| meta_header | [neo.fs.v2.service.RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.GetRangeRequest.Body"></a>

### Message GetRangeRequest.Body
Request Body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [neo.fs.v2.refs.Address](#neo.fs.v2.refs.Address) |  | Address carries address of the object that contains the requested payload range. |
| range | [Range](#neo.fs.v2.object.Range) |  | Range carries the parameters of the requested payload range. |


<a name="neo.fs.v2.object.GetRangeResponse"></a>

### Message GetRangeResponse
Get part of object's payload


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRangeResponse.Body](#neo.fs.v2.object.GetRangeResponse.Body) |  | Body of get range object response message. |
| meta_header | [neo.fs.v2.service.ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.GetRangeResponse.Body"></a>

### Message GetRangeResponse.Body
Response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| chunk | [bytes](#bytes) |  | Carries part of the object payload. |


<a name="neo.fs.v2.object.GetRequest"></a>

### Message GetRequest
Get object request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRequest.Body](#neo.fs.v2.object.GetRequest.Body) |  | Body of get object request message. |
| meta_header | [neo.fs.v2.service.RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.GetRequest.Body"></a>

### Message GetRequest.Body
Request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [neo.fs.v2.refs.Address](#neo.fs.v2.refs.Address) |  | Address of the requested object. |
| raw | [bool](#bool) |  | Carries the raw option flag of the request. Raw request is sent to receive only the objects that are physically stored on the server. |


<a name="neo.fs.v2.object.GetResponse"></a>

### Message GetResponse
get object response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetResponse.Body](#neo.fs.v2.object.GetResponse.Body) |  | Body of get object response message. |
| meta_header | [neo.fs.v2.service.ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.GetResponse.Body"></a>

### Message GetResponse.Body
Response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| init | [GetResponse.Body.Init](#neo.fs.v2.object.GetResponse.Body.Init) |  | Initialization parameters of the object stream. |
| chunk | [bytes](#bytes) |  | Part of the object payload. |


<a name="neo.fs.v2.object.GetResponse.Body.Init"></a>

### Message GetResponse.Body.Init
Initialization parameters of the object got from NeoFS.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object_id | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Object ID |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Object signature |
| header | [Header](#neo.fs.v2.object.Header) |  | Object header. |


<a name="neo.fs.v2.object.HeadRequest"></a>

### Message HeadRequest
Object head request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [HeadRequest.Body](#neo.fs.v2.object.HeadRequest.Body) |  | Body of head object request message. |
| meta_header | [neo.fs.v2.service.RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.HeadRequest.Body"></a>

### Message HeadRequest.Body
Request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [neo.fs.v2.refs.Address](#neo.fs.v2.refs.Address) |  | Address of the object with the requested header. |
| main_only | [bool](#bool) |  | Return only minimal header subset |
| raw | [bool](#bool) |  | Carries the raw option flag of the request. Raw request is sent to receive only the headers of the objects that are physically stored on the server. |


<a name="neo.fs.v2.object.HeadResponse"></a>

### Message HeadResponse
Head response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [HeadResponse.Body](#neo.fs.v2.object.HeadResponse.Body) |  | Body of head object response message. |
| meta_header | [neo.fs.v2.service.ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.HeadResponse.Body"></a>

### Message HeadResponse.Body
Response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| header | [Header](#neo.fs.v2.object.Header) |  | Full object header |
| short_header | [ShortHeader](#neo.fs.v2.object.ShortHeader) |  | Short object header |


<a name="neo.fs.v2.object.PutRequest"></a>

### Message PutRequest
Put object request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [PutRequest.Body](#neo.fs.v2.object.PutRequest.Body) |  | Body of put object request message. |
| meta_header | [neo.fs.v2.service.RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.PutRequest.Body"></a>

### Message PutRequest.Body
Request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| init | [PutRequest.Body.Init](#neo.fs.v2.object.PutRequest.Body.Init) |  | Carries the initialization parameters of the object stream. |
| chunk | [bytes](#bytes) |  | Carries part of the object payload. |


<a name="neo.fs.v2.object.PutRequest.Body.Init"></a>

### Message PutRequest.Body.Init
Groups initialization parameters of object placement in NeoFS.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object_id | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Object ID, where available |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Object signature, were available |
| header | [Header](#neo.fs.v2.object.Header) |  | Header of the object to save in the system. |
| copies_number | [uint32](#uint32) |  | Number of the object copies to store within the RPC call. Default zero value is processed according to the container placement rules. |


<a name="neo.fs.v2.object.PutResponse"></a>

### Message PutResponse
Put object response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [PutResponse.Body](#neo.fs.v2.object.PutResponse.Body) |  | Body of put object response message. |
| meta_header | [neo.fs.v2.service.ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.PutResponse.Body"></a>

### Message PutResponse.Body
Response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object_id | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Carries identifier of the saved object. It is used to access an object in the container. |


<a name="neo.fs.v2.object.Range"></a>

### Message Range
Range groups the parameters of object payload range.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| offset | [uint64](#uint64) |  | Carries the offset of the range from the object payload start. |
| length | [uint64](#uint64) |  | Carries the length of the object payload range. |


<a name="neo.fs.v2.object.SearchRequest"></a>

### Message SearchRequest
Search objects request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SearchRequest.Body](#neo.fs.v2.object.SearchRequest.Body) |  | Body of search object request message. |
| meta_header | [neo.fs.v2.service.RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.SearchRequest.Body"></a>

### Message SearchRequest.Body
Request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Carries search container identifier. |
| version | [uint32](#uint32) |  | Version of the Query Language used |
| filters | [SearchRequest.Body.Filter](#neo.fs.v2.object.SearchRequest.Body.Filter) | repeated | List of search expressions |


<a name="neo.fs.v2.object.SearchRequest.Body.Filter"></a>

### Message SearchRequest.Body.Filter
Filter structure


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| match_type | [MatchType](#neo.fs.v2.object.MatchType) |  | Match type to use |
| name | [string](#string) |  | Header name to match |
| value | [string](#string) |  | Header value to match |


<a name="neo.fs.v2.object.SearchResponse"></a>

### Message SearchResponse
Search response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SearchResponse.Body](#neo.fs.v2.object.SearchResponse.Body) |  | Body of search object response message. |
| meta_header | [neo.fs.v2.service.ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.object.SearchResponse.Body"></a>

### Message SearchResponse.Body
Response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id_list | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) | repeated | Carries list of object identifiers that match the search query |

 <!-- end messages -->

 <!-- end enums -->



<a name="object/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## object/types.proto


 <!-- end services -->


<a name="neo.fs.v2.object.Header"></a>

### Message Header
Object Headers


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Object format version. Effectively the version of API library used to create particular object |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Object's container |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Object's owner |
| creation_epoch | [uint64](#uint64) |  | Object creation Epoch |
| payload_length | [uint64](#uint64) |  | Size of payload in bytes. 0xFFFFFFFFFFFFFFFF means `payload_length` is unknown |
| payload_hash | [bytes](#bytes) |  | Hash of payload bytes |
| object_type | [ObjectType](#neo.fs.v2.object.ObjectType) |  | Special object type |
| homomorphic_hash | [bytes](#bytes) |  | Homomorphic hash of the object payload. |
| session_token | [neo.fs.v2.session.SessionToken](#neo.fs.v2.session.SessionToken) |  | Session token, if it was used during Object creation. Need it to verify integrity and authenticity out of Request scope. |
| attributes | [Header.Attribute](#neo.fs.v2.object.Header.Attribute) | repeated | User-defined object attributes |
| split | [Header.Split](#neo.fs.v2.object.Header.Split) |  | Position of the object in the split hierarchy. |


<a name="neo.fs.v2.object.Header.Attribute"></a>

### Message Header.Attribute
Attribute groups the user-defined Key-Value pairs attached to the object


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | string key to the object attribute |
| value | [string](#string) |  | string value of the object attribute |


<a name="neo.fs.v2.object.Header.Split"></a>

### Message Header.Split
Information about spawning the objects through a payload splitting.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| parent | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Identifier of the origin object. Parent and children objects must be within the same container. Parent object_id is known only to the minor child. |
| previous | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Previous carries identifier of the left split neighbor. |
| parent_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | `signature` field of the parent object. Used to reconstruct parent. |
| parent_header | [Header](#neo.fs.v2.object.Header) |  | `header` field of the parent object. Used to reconstruct parent. |
| children | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) | repeated | Children carries list of identifiers of the objects generated by splitting the current. |


<a name="neo.fs.v2.object.Object"></a>

### Message Object
Object structure.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object_id | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) |  | Object's unique identifier. Object is content-addressed. It means id will change if header or payload changes. It's calculated as a hash of header field, which contains hash of object's payload |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signed object_id |
| header | [Header](#neo.fs.v2.object.Header) |  | Object metadata headers |
| payload | [bytes](#bytes) |  | Payload bytes. |


<a name="neo.fs.v2.object.ShortHeader"></a>

### Message ShortHeader
Short header fields


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Object format version. |
| creation_epoch | [uint64](#uint64) |  | Epoch when the object was created |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Object's owner |
| object_type | [ObjectType](#neo.fs.v2.object.ObjectType) |  | Type of the object payload content |
| payload_length | [uint64](#uint64) |  | Size of payload in bytes. 0xFFFFFFFFFFFFFFFF means `payload_length` is unknown |

 <!-- end messages -->


<a name="neo.fs.v2.object.MatchType"></a>

### MatchType
Type of match expression

| Name | Number | Description |
| ---- | ------ | ----------- |
| MATCH_TYPE_UNSPECIFIED | 0 | Unknown. Not used |
| STRING_EQUAL | 1 | Full string match |



<a name="neo.fs.v2.object.ObjectType"></a>

### ObjectType
Type of the object payload content

| Name | Number | Description |
| ---- | ------ | ----------- |
| REGULAR | 0 | Just a normal object |
| TOMBSTONE | 1 | Used internally to identify deleted objects |
| STORAGE_GROUP | 2 | Identifies that the object holds StorageGroup information |


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

