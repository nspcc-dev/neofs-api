# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [object/service.proto](#object/service.proto)
 - Services
    - [Service](#object.Service)
    
  - Messages
    - [DeleteRequest](#object.DeleteRequest)
    - [DeleteRequest.Body](#object.DeleteRequest.Body)
    - [DeleteResponse](#object.DeleteResponse)
    - [DeleteResponse.Body](#object.DeleteResponse.Body)
    - [GetRangeHashRequest](#object.GetRangeHashRequest)
    - [GetRangeHashRequest.Body](#object.GetRangeHashRequest.Body)
    - [GetRangeHashResponse](#object.GetRangeHashResponse)
    - [GetRangeHashResponse.Body](#object.GetRangeHashResponse.Body)
    - [GetRangeRequest](#object.GetRangeRequest)
    - [GetRangeRequest.Body](#object.GetRangeRequest.Body)
    - [GetRangeResponse](#object.GetRangeResponse)
    - [GetRangeResponse.Body](#object.GetRangeResponse.Body)
    - [GetRequest](#object.GetRequest)
    - [GetRequest.Body](#object.GetRequest.Body)
    - [GetResponse](#object.GetResponse)
    - [GetResponse.Body](#object.GetResponse.Body)
    - [GetResponse.Body.Init](#object.GetResponse.Body.Init)
    - [HeadRequest](#object.HeadRequest)
    - [HeadRequest.Body](#object.HeadRequest.Body)
    - [HeadResponse](#object.HeadResponse)
    - [HeadResponse.Body](#object.HeadResponse.Body)
    - [HeadResponse.Body.ShortHeader](#object.HeadResponse.Body.ShortHeader)
    - [PutRequest](#object.PutRequest)
    - [PutRequest.Body](#object.PutRequest.Body)
    - [PutRequest.Body.Init](#object.PutRequest.Body.Init)
    - [PutResponse](#object.PutResponse)
    - [PutResponse.Body](#object.PutResponse.Body)
    - [Range](#object.Range)
    - [SearchRequest](#object.SearchRequest)
    - [SearchRequest.Body](#object.SearchRequest.Body)
    - [SearchRequest.Body.Query](#object.SearchRequest.Body.Query)
    - [SearchRequest.Body.Query.Filter](#object.SearchRequest.Body.Query.Filter)
    - [SearchResponse](#object.SearchResponse)
    - [SearchResponse.Body](#object.SearchResponse.Body)
    

- [object/types.proto](#object/types.proto)

  - Messages
    - [Header](#object.Header)
    - [Header.Attribute](#object.Header.Attribute)
    - [Header.Split](#object.Header.Split)
    - [Object](#object.Object)
    

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
| body | [DeleteRequest.Body](#object.DeleteRequest.Body) |  | Body of delete object request message. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.DeleteRequest.Body"></a>

### Message DeleteRequest.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [refs.Address](#refs.Address) |  | Carries the address of the object to be deleted. |
| owner_id | [refs.OwnerID](#refs.OwnerID) |  | Carries identifier the object owner. |


<a name="object.DeleteResponse"></a>

### Message DeleteResponse
DeleteResponse is empty because we cannot guarantee permanent object removal
in distributed system.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [DeleteResponse.Body](#object.DeleteResponse.Body) |  | Body of delete object response message. |
| meta_header | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.ResponseVerificationHeader](#service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.DeleteResponse.Body"></a>

### Message DeleteResponse.Body




<a name="object.GetRangeHashRequest"></a>

### Message GetRangeHashRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRangeHashRequest.Body](#object.GetRangeHashRequest.Body) |  | Body of get range hash object request message. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.GetRangeHashRequest.Body"></a>

### Message GetRangeHashRequest.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [refs.Address](#refs.Address) |  | Carries address of the object that contains the requested payload range. |
| ranges | [Range](#object.Range) | repeated | Carries the list of object payload range to calculate homomorphic hash. |
| salt | [bytes](#bytes) |  | Carries binary salt to XOR object payload ranges before hash calculation. |


<a name="object.GetRangeHashResponse"></a>

### Message GetRangeHashResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRangeHashResponse.Body](#object.GetRangeHashResponse.Body) |  | Body of get range hash object response message. |
| meta_header | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.ResponseVerificationHeader](#service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.GetRangeHashResponse.Body"></a>

### Message GetRangeHashResponse.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| hash_list | [bytes](#bytes) | repeated | Carries list of homomorphic hashes in a binary format. |


<a name="object.GetRangeRequest"></a>

### Message GetRangeRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRangeRequest.Body](#object.GetRangeRequest.Body) |  | Body of get range object request message. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.GetRangeRequest.Body"></a>

### Message GetRangeRequest.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [refs.Address](#refs.Address) |  | Address carries address of the object that contains the requested payload range. |
| range | [Range](#object.Range) |  | Range carries the parameters of the requested payload range. |


<a name="object.GetRangeResponse"></a>

### Message GetRangeResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRangeResponse.Body](#object.GetRangeResponse.Body) |  | Body of get range object response message. |
| meta_header | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.ResponseVerificationHeader](#service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.GetRangeResponse.Body"></a>

### Message GetRangeResponse.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| chunk | [bytes](#bytes) |  | Carries part of the object payload. |


<a name="object.GetRequest"></a>

### Message GetRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRequest.Body](#object.GetRequest.Body) |  | Body of get object request message. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.GetRequest.Body"></a>

### Message GetRequest.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [refs.Address](#refs.Address) |  | Address of the requested object. |
| raw | [bool](#bool) |  | Carries the raw option flag of the request. Raw request is sent to receive only the objects that are physically stored on the server. |


<a name="object.GetResponse"></a>

### Message GetResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetResponse.Body](#object.GetResponse.Body) |  | Body of get object response message. |
| meta_header | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.ResponseVerificationHeader](#service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.GetResponse.Body"></a>

### Message GetResponse.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| init | [GetResponse.Body.Init](#object.GetResponse.Body.Init) |  | Initialization parameters of the object stream. |
| chunk | [bytes](#bytes) |  | Part of the object payload. |


<a name="object.GetResponse.Body.Init"></a>

### Message GetResponse.Body.Init
Initialization parameters of the object got from NeoFS.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object_id | [refs.ObjectID](#refs.ObjectID) |  | Object ID |
| signature | [service.Signature](#service.Signature) |  | Object signature |
| header | [Header](#object.Header) |  | Object header. |


<a name="object.HeadRequest"></a>

### Message HeadRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [HeadRequest.Body](#object.HeadRequest.Body) |  | Body of head object request message. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.HeadRequest.Body"></a>

### Message HeadRequest.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [refs.Address](#refs.Address) |  | Address of the object with the requested header. |
| main_only | [bool](#bool) |  | Return only minimal header subset |
| raw | [bool](#bool) |  | Carries the raw option flag of the request. Raw request is sent to receive only the headers of the objects that are physically stored on the server. |


<a name="object.HeadResponse"></a>

### Message HeadResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [HeadResponse.Body](#object.HeadResponse.Body) |  | Body of head object response message. |
| meta_header | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.ResponseVerificationHeader](#service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.HeadResponse.Body"></a>

### Message HeadResponse.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| header | [Header](#object.Header) |  |  |
| short_header | [HeadResponse.Body.ShortHeader](#object.HeadResponse.Body.ShortHeader) |  |  |


<a name="object.HeadResponse.Body.ShortHeader"></a>

### Message HeadResponse.Body.ShortHeader



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [service.Version](#service.Version) |  | Object format version. |
| creation_epoch | [uint64](#uint64) |  | Epoch when the object was created |
| owner_id | [refs.OwnerID](#refs.OwnerID) |  | Object's owner |
| object_type | [ObjectType](#object.ObjectType) |  | Type of the object payload content |
| payload_length | [uint64](#uint64) |  | Size of payload in bytes. 0xFFFFFFFFFFFFFFFF means `payload_length` is unknown |


<a name="object.PutRequest"></a>

### Message PutRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [PutRequest.Body](#object.PutRequest.Body) |  | Body of put object request message. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.PutRequest.Body"></a>

### Message PutRequest.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| init | [PutRequest.Body.Init](#object.PutRequest.Body.Init) |  | Carries the initialization parameters of the object stream. |
| chunk | [bytes](#bytes) |  | Carries part of the object payload. |


<a name="object.PutRequest.Body.Init"></a>

### Message PutRequest.Body.Init
Groups initialization parameters of object placement in NeoFS.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object_id | [refs.ObjectID](#refs.ObjectID) |  | Object ID, where available |
| signature | [service.Signature](#service.Signature) |  | Object signature, were available |
| header | [Header](#object.Header) |  | Header of the object to save in the system. |
| copies_number | [uint32](#uint32) |  | Number of the object copies to store within the RPC call. Default zero value is processed according to the container placement rules. |


<a name="object.PutResponse"></a>

### Message PutResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [PutResponse.Body](#object.PutResponse.Body) |  | Body of put object response message. |
| meta_header | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.ResponseVerificationHeader](#service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.PutResponse.Body"></a>

### Message PutResponse.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object_id | [refs.ObjectID](#refs.ObjectID) |  | Carries identifier of the saved object. It is used to access an object in the container. |


<a name="object.Range"></a>

### Message Range
Range groups the parameters of object payload range.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| offset | [uint64](#uint64) |  | Carries the offset of the range from the object payload start. |
| length | [uint64](#uint64) |  | Carries the length of the object payload range. |


<a name="object.SearchRequest"></a>

### Message SearchRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SearchRequest.Body](#object.SearchRequest.Body) |  | Body of search object request message. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.SearchRequest.Body"></a>

### Message SearchRequest.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [refs.ContainerID](#refs.ContainerID) |  | Carries search container identifier. |
| query | [SearchRequest.Body.Query](#object.SearchRequest.Body.Query) |  |  |


<a name="object.SearchRequest.Body.Query"></a>

### Message SearchRequest.Body.Query



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [uint32](#uint32) |  |  |
| filters | [SearchRequest.Body.Query.Filter](#object.SearchRequest.Body.Query.Filter) | repeated |  |


<a name="object.SearchRequest.Body.Query.Filter"></a>

### Message SearchRequest.Body.Query.Filter



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| match_type | [SearchRequest.Body.Query.Filter.MatchType](#object.SearchRequest.Body.Query.Filter.MatchType) |  |  |
| name | [string](#string) |  |  |
| value | [string](#string) |  |  |


<a name="object.SearchResponse"></a>

### Message SearchResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SearchResponse.Body](#object.SearchResponse.Body) |  | Body of search object response message. |
| meta_header | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.ResponseVerificationHeader](#service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.SearchResponse.Body"></a>

### Message SearchResponse.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id_list | [refs.ObjectID](#refs.ObjectID) | repeated | Carries list of object identifiers that match the search query. |

 <!-- end messages -->


<a name="object.SearchRequest.Body.Query.Filter.MatchType"></a>

### SearchRequest.Body.Query.Filter.MatchType


| Name | Number | Description |
| ---- | ------ | ----------- |
| MATCH_UNKNOWN | 0 |  |
| STRING_EQUAL | 1 |  |


 <!-- end enums -->



<a name="object/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## object/types.proto


 <!-- end services -->


<a name="object.Header"></a>

### Message Header



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [refs.ContainerID](#refs.ContainerID) |  | Object's container |
| owner_id | [refs.OwnerID](#refs.OwnerID) |  | Object's owner |
| creation_epoch | [uint64](#uint64) |  | Epoch when the object was created |
| version | [service.Version](#service.Version) |  | Object format version. Effectively the version of API library used to create particular object |
| payload_length | [uint64](#uint64) |  | Size of payload in bytes. 0xFFFFFFFFFFFFFFFF means `payload_length` is unknown |
| payload_hash | [bytes](#bytes) |  | Hash of payload bytes |
| object_type | [ObjectType](#object.ObjectType) |  |  |
| homomorphic_hash | [bytes](#bytes) |  | Homomorphic hash of the object payload. |
| session_token | [service.SessionToken](#service.SessionToken) |  | Session token, if it was used during Object creation. Need it to verify integrity and authenticity out of Request scope. |
| attributes | [Header.Attribute](#object.Header.Attribute) | repeated |  |
| split | [Header.Split](#object.Header.Split) |  | Position of the object in the split hierarchy. |


<a name="object.Header.Attribute"></a>

### Message Header.Attribute
Attribute groups the user-defined Key-Value pairs attached to the object


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | string key to the object attribute |
| value | [string](#string) |  | string value of the object attribute |


<a name="object.Header.Split"></a>

### Message Header.Split
Information about spawning the objects through a payload splitting.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| parent | [refs.ObjectID](#refs.ObjectID) |  | Identifier of the origin object. Parent and children objects must be within the same container. Parent object_id is known only to the minor child. |
| previous | [refs.ObjectID](#refs.ObjectID) |  | Previous carries identifier of the left split neighbor. |
| parent_signature | [service.Signature](#service.Signature) |  | `signature` field of the parent object. Used to reconstruct parent. |
| parent_header | [Header](#object.Header) |  | `header` field of the parent object. Used to reconstruct parent. |
| children | [refs.ObjectID](#refs.ObjectID) | repeated | Children carries list of identifiers of the objects generated by splitting the current. |


<a name="object.Object"></a>

### Message Object
Object structure.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| object_id | [refs.ObjectID](#refs.ObjectID) |  | Object's unique identifier. Object is content-addressed. It means id will change if header or payload changes. It's calculated as a hash of header field, which contains hash of object's payload |
| signature | [service.Signature](#service.Signature) |  | Signed object_id |
| header | [Header](#object.Header) |  | Object metadata headers |
| payload | [bytes](#bytes) |  | Payload bytes. |

 <!-- end messages -->


<a name="object.ObjectType"></a>

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

