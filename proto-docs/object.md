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
    - [PutRequest.Init](#object.PutRequest.Init)
    - [PutResponse](#object.PutResponse)
    - [Range](#object.Range)
    - [SearchRequest](#object.SearchRequest)
    - [SearchRequest.Query](#object.SearchRequest.Query)
    - [SearchRequest.Query.Filter](#object.SearchRequest.Query.Filter)
    - [SearchResponse](#object.SearchResponse)
    

- [object/types.proto](#object/types.proto)

  - Messages
    - [Header](#object.Header)
    - [Header.Extended](#object.Header.Extended)
    - [Header.Extended.Attribute](#object.Header.Extended.Attribute)
    - [Header.Extended.Integrity](#object.Header.Extended.Integrity)
    - [Header.Extended.Split](#object.Header.Extended.Split)
    - [Header.Extended.StorageGroup](#object.Header.Extended.StorageGroup)
    - [Header.Extended.Tombstone](#object.Header.Extended.Tombstone)
    - [Header.Main](#object.Header.Main)
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
| address | [refs.Address](#refs.Address) |  | Carries the address of the object to be deleted. |
| owner_id | [refs.OwnerID](#refs.OwnerID) |  | Carries identifier the object owner. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.DeleteResponse"></a>

### Message DeleteResponse
DeleteResponse is empty because we cannot guarantee permanent object removal
in distributed system.



<a name="object.GetRangeHashRequest"></a>

### Message GetRangeHashRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [refs.Address](#refs.Address) |  | Carries address of the object that contains the requested payload range. |
| ranges | [Range](#object.Range) | repeated | Carries the list of object payload range to calculate homomorphic hash. |
| salt | [bytes](#bytes) |  | Carries binary salt to XOR object payload ranges before hash calculation. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.GetRangeHashResponse"></a>

### Message GetRangeHashResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| hash_list | [bytes](#bytes) | repeated | Carries list of homomorphic hashes in a binary format. |


<a name="object.GetRangeRequest"></a>

### Message GetRangeRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [refs.Address](#refs.Address) |  | Address carries address of the object that contains the requested payload range. |
| range | [Range](#object.Range) |  | Range carries the parameters of the requested payload range. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.GetRangeResponse"></a>

### Message GetRangeResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| chunk | [bytes](#bytes) |  | Carries part of the object payload. |


<a name="object.GetRequest"></a>

### Message GetRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [refs.Address](#refs.Address) |  | Carries the address of the requested object. |
| raw | [bool](#bool) |  | Carries the raw option flag of the request. Raw request is sent to receive only the objects that are physically stored on the server. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.GetResponse"></a>

### Message GetResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| header | [Header](#object.Header) |  | Carries the object header. |
| chunk | [bytes](#bytes) |  | Carries part of the object payload. |


<a name="object.HeadRequest"></a>

### Message HeadRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address | [refs.Address](#refs.Address) |  | Carries the address of the object with the requested header. |
| main_only | [bool](#bool) |  | Carries the option to crop header to main part. |
| raw | [bool](#bool) |  | Carries the raw option flag of the request. Raw request is sent to receive only the headers of the objects that are physically stored on the server. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.HeadResponse"></a>

### Message HeadResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| header | [Header](#object.Header) |  | Carries the requested object header. |


<a name="object.PutRequest"></a>

### Message PutRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| init | [PutRequest.Init](#object.PutRequest.Init) |  | Carries the initialization parameters of the object stream. |
| chunk | [bytes](#bytes) |  | Carries part of the object payload. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.PutRequest.Init"></a>

### Message PutRequest.Init
Groups initialization parameters of object placement in NeoFS.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| header | [Header](#object.Header) |  | Carries the header of the object to save in the system. |
| copies_number | [uint32](#uint32) |  | Carries the number of the object copies to store within the RPC call. Default zero value is processed according to the container placement rules. |


<a name="object.PutResponse"></a>

### Message PutResponse



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
| container_id | [refs.ContainerID](#refs.ContainerID) |  | Carries search container identifier. |
| query | [SearchRequest.Query](#object.SearchRequest.Query) |  |  |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="object.SearchRequest.Query"></a>

### Message SearchRequest.Query



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [uint32](#uint32) |  |  |
| filters | [SearchRequest.Query.Filter](#object.SearchRequest.Query.Filter) | repeated |  |


<a name="object.SearchRequest.Query.Filter"></a>

### Message SearchRequest.Query.Filter



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| match_type | [SearchRequest.Query.Filter.MatchType](#object.SearchRequest.Query.Filter.MatchType) |  |  |
| name | [string](#string) |  |  |
| value | [string](#string) |  |  |


<a name="object.SearchResponse"></a>

### Message SearchResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id_list | [refs.ObjectID](#refs.ObjectID) | repeated | Carries list of object identifiers that match the search query. |

 <!-- end messages -->


<a name="object.SearchRequest.Query.Filter.MatchType"></a>

### SearchRequest.Query.Filter.MatchType


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
Header groups the information about the NeoFS object.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| main | [Header.Main](#object.Header.Main) |  | Main carries the main part of the header. Main MUST NOT be NULL. |
| extended | [Header.Extended](#object.Header.Extended) |  | Extended carries the additional part of the header. |


<a name="object.Header.Extended"></a>

### Message Header.Extended
Extended groups additional information about the object.
It encapsulates both user and system attributes needed to regulate
the NeoFS sub-systems.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| integrity | [Header.Extended.Integrity](#object.Header.Extended.Integrity) |  | integrity carries object integrity evidence. |
| attributes | [Header.Extended.Attribute](#object.Header.Extended.Attribute) | repeated | attributes carries list of the object attributes in a string key-value format. |
| creation_epoch | [uint64](#uint64) |  | creation_epoch carries number of NeoFS epoch on which the object was created. |
| tombstone | [Header.Extended.Tombstone](#object.Header.Extended.Tombstone) |  | Tombstone marks the object to be deleted. |
| homomorphic_hash | [bytes](#bytes) |  | homomorphic_hash carries homomorphic hash of the object payload. |
| storage_group | [Header.Extended.StorageGroup](#object.Header.Extended.StorageGroup) |  | StorageGroup marks an object containing information about a storage group. |
| split | [Header.Extended.Split](#object.Header.Extended.Split) |  | Split carries the position of the object in the split hierarchy. |


<a name="object.Header.Extended.Attribute"></a>

### Message Header.Extended.Attribute
Attribute groups the parameters of the object attributes.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | key carries the string key to the object attribute. |
| value | [string](#string) |  | value carries the string value of the object attribute. |


<a name="object.Header.Extended.Integrity"></a>

### Message Header.Extended.Integrity
Integrity groups evidence of the integrity of an object's structure.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payload_checksum | [bytes](#bytes) |  | payload_checksum carries the checksum of object payload bytes. Changing any byte of the payload changes the checksum. It is calculated as a SHA-256 hash over payload bytes. |
| header_checksum | [bytes](#bytes) |  | header_checksum carries checksum of the object header structure. It covers all object attributes. Changing any field of the object except CreatorKey and ChecksumSignature changes the checksum. payload_checksum and header_checksum cannot be merged due to the need to verify the header in the absence of a payload (e.g. in object.Head rpc). It is calculated as a SHA-256 hash over marshaled object header with cut creator_key and checksum_signature. |
| session_token | [service.SessionToken](#service.SessionToken) |  | session_token carries token of the session within which the object was created. If session token is presented in object, it acts as the user's proof of the correctness of the creator_key. |
| creator_key | [bytes](#bytes) |  | creator_key carries public key of the object creator in a binary format. |
| checksum_signature | [bytes](#bytes) |  | checksum_signature carries signature of the structure checksum by the object creator. |


<a name="object.Header.Extended.Split"></a>

### Message Header.Extended.Split
Split groups information about spawning the object through a payload splitting.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| parent | [refs.ObjectID](#refs.ObjectID) |  | Parent carries identifier of the origin object. |
| previous | [refs.ObjectID](#refs.ObjectID) |  | Previous carries identifier of the left split neighbor. |
| next | [refs.ObjectID](#refs.ObjectID) |  | Next carries identifier of the right split neighbor. |
| children | [refs.ObjectID](#refs.ObjectID) | repeated | Children carries list of identifiers of the objects generated by splitting the current. |
| origin | [Header](#object.Header) |  | Origin carries the header of the origin object. |


<a name="object.Header.Extended.StorageGroup"></a>

### Message Header.Extended.StorageGroup
StorageGroup groups meta information about a storage group.



<a name="object.Header.Extended.Tombstone"></a>

### Message Header.Extended.Tombstone
Tombstone groups the options for deleting an object.



<a name="object.Header.Main"></a>

### Message Header.Main
Main groups mandatory information about the object.
Message fields are presented in all NeoFS objects.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payload_length | [uint64](#uint64) |  | payload_length carries length of the object payload. Each object has a fixed payload length since it's immutable. |
| address | [refs.Address](#refs.Address) |  | address carries object address in the NeoFS system. It encapsulates the object and the container identifiers. |
| owner_id | [refs.OwnerID](#refs.OwnerID) |  | owner_id carries identifier of the object owner. |


<a name="object.Object"></a>

### Message Object
Object groups the information about the NeoFS object.
It consists of payload data with additional service information.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| header | [Header](#object.Header) |  | Header carries the object header. |
| payload | [bytes](#bytes) |  | Payload carries the object payload bytes. |

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

