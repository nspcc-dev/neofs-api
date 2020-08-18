# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [container/service.proto](#container/service.proto)
 - Services
    - [ContainerService](#neo.fs.v2.container.ContainerService)
    
  - Messages
    - [DeleteRequest](#neo.fs.v2.container.DeleteRequest)
    - [DeleteRequest.Body](#neo.fs.v2.container.DeleteRequest.Body)
    - [DeleteResponse](#neo.fs.v2.container.DeleteResponse)
    - [DeleteResponse.Body](#neo.fs.v2.container.DeleteResponse.Body)
    - [GetExtendedACLRequest](#neo.fs.v2.container.GetExtendedACLRequest)
    - [GetExtendedACLRequest.Body](#neo.fs.v2.container.GetExtendedACLRequest.Body)
    - [GetExtendedACLResponse](#neo.fs.v2.container.GetExtendedACLResponse)
    - [GetExtendedACLResponse.Body](#neo.fs.v2.container.GetExtendedACLResponse.Body)
    - [GetRequest](#neo.fs.v2.container.GetRequest)
    - [GetRequest.Body](#neo.fs.v2.container.GetRequest.Body)
    - [GetResponse](#neo.fs.v2.container.GetResponse)
    - [GetResponse.Body](#neo.fs.v2.container.GetResponse.Body)
    - [ListRequest](#neo.fs.v2.container.ListRequest)
    - [ListRequest.Body](#neo.fs.v2.container.ListRequest.Body)
    - [ListResponse](#neo.fs.v2.container.ListResponse)
    - [ListResponse.Body](#neo.fs.v2.container.ListResponse.Body)
    - [PutRequest](#neo.fs.v2.container.PutRequest)
    - [PutRequest.Body](#neo.fs.v2.container.PutRequest.Body)
    - [PutResponse](#neo.fs.v2.container.PutResponse)
    - [PutResponse.Body](#neo.fs.v2.container.PutResponse.Body)
    - [SetExtendedACLRequest](#neo.fs.v2.container.SetExtendedACLRequest)
    - [SetExtendedACLRequest.Body](#neo.fs.v2.container.SetExtendedACLRequest.Body)
    - [SetExtendedACLResponse](#neo.fs.v2.container.SetExtendedACLResponse)
    - [SetExtendedACLResponse.Body](#neo.fs.v2.container.SetExtendedACLResponse.Body)
    

- [container/types.proto](#container/types.proto)

  - Messages
    - [Container](#neo.fs.v2.container.Container)
    - [Container.Attribute](#neo.fs.v2.container.Container.Attribute)
    

- [Scalar Value Types](#scalar-value-types)



<a name="container/service.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## container/service.proto




<a name="neo.fs.v2.container.ContainerService"></a>

### Service "neo.fs.v2.container.ContainerService"
ContainerService provides API to access container smart-contract in morph chain
via NeoFS node.

```
rpc Put(PutRequest) returns (PutResponse);
rpc Delete(DeleteRequest) returns (DeleteResponse);
rpc Get(GetRequest) returns (GetResponse);
rpc List(ListRequest) returns (ListResponse);
rpc SetExtendedACL(SetExtendedACLRequest) returns (SetExtendedACLResponse);
rpc GetExtendedACL(GetExtendedACLRequest) returns (GetExtendedACLResponse);

```

#### Method Put

Put invokes 'Put' method in container smart-contract and returns
response immediately. After new block in morph chain, request is verified
by inner ring nodes. After one more block in morph chain, container
added into smart-contract storage.

| Name | Input | Output |
| ---- | ----- | ------ |
| Put | [PutRequest](#neo.fs.v2.container.PutRequest) | [PutResponse](#neo.fs.v2.container.PutResponse) |
#### Method Delete

Delete invokes 'Delete' method in container smart-contract and returns
response immediately. After new block in morph chain, request is verified
by inner ring nodes. After one more block in morph chain, container
removed from smart-contract storage.

| Name | Input | Output |
| ---- | ----- | ------ |
| Delete | [DeleteRequest](#neo.fs.v2.container.DeleteRequest) | [DeleteResponse](#neo.fs.v2.container.DeleteResponse) |
#### Method Get

Get returns container from container smart-contract storage.

| Name | Input | Output |
| ---- | ----- | ------ |
| Get | [GetRequest](#neo.fs.v2.container.GetRequest) | [GetResponse](#neo.fs.v2.container.GetResponse) |
#### Method List

List returns all owner's containers from container smart-contract
storage.

| Name | Input | Output |
| ---- | ----- | ------ |
| List | [ListRequest](#neo.fs.v2.container.ListRequest) | [ListResponse](#neo.fs.v2.container.ListResponse) |
#### Method SetExtendedACL

SetExtendedACL invokes 'SetEACL' method in container smart-contract and
returns response immediately. After new block in morph chain,
Extended ACL added into smart-contract storage.

| Name | Input | Output |
| ---- | ----- | ------ |
| SetExtendedACL | [SetExtendedACLRequest](#neo.fs.v2.container.SetExtendedACLRequest) | [SetExtendedACLResponse](#neo.fs.v2.container.SetExtendedACLResponse) |
#### Method GetExtendedACL

GetExtendedACL returns Extended ACL table and signature from container
smart-contract storage.

| Name | Input | Output |
| ---- | ----- | ------ |
| GetExtendedACL | [GetExtendedACLRequest](#neo.fs.v2.container.GetExtendedACLRequest) | [GetExtendedACLResponse](#neo.fs.v2.container.GetExtendedACLResponse) |
 <!-- end services -->


<a name="neo.fs.v2.container.DeleteRequest"></a>

### Message DeleteRequest
Container removal request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [DeleteRequest.Body](#neo.fs.v2.container.DeleteRequest.Body) |  | Body of container delete request message. |
| meta_header | [neo.fs.v2.service.RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.DeleteRequest.Body"></a>

### Message DeleteRequest.Body
Request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | container_id carries identifier of the container to delete from NeoFS. |
| signature | [neo.fs.v2.service.Signature](#neo.fs.v2.service.Signature) |  | Signature of container id according to RFC-6979. |


<a name="neo.fs.v2.container.DeleteResponse"></a>

### Message DeleteResponse
DeleteResponse is empty because delete operation is asynchronous and done
via consensus in inner ring nodes


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [DeleteResponse.Body](#neo.fs.v2.container.DeleteResponse.Body) |  | Body of container delete response message. |
| meta_header | [neo.fs.v2.service.ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.DeleteResponse.Body"></a>

### Message DeleteResponse.Body
Response body



<a name="neo.fs.v2.container.GetExtendedACLRequest"></a>

### Message GetExtendedACLRequest
Get Extended ACL


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetExtendedACLRequest.Body](#neo.fs.v2.container.GetExtendedACLRequest.Body) |  | Body of get extended acl request message. |
| meta_header | [neo.fs.v2.service.RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.GetExtendedACLRequest.Body"></a>

### Message GetExtendedACLRequest.Body
Request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | container_id carries identifier of the container that has Extended ACL. |


<a name="neo.fs.v2.container.GetExtendedACLResponse"></a>

### Message GetExtendedACLResponse
Get Extended ACL


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetExtendedACLResponse.Body](#neo.fs.v2.container.GetExtendedACLResponse.Body) |  | Body of get extended acl response message. |
| meta_header | [neo.fs.v2.service.ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.GetExtendedACLResponse.Body"></a>

### Message GetExtendedACLResponse.Body
Response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| eacl | [neo.fs.v2.acl.EACLTable](#neo.fs.v2.acl.EACLTable) |  | Extended ACL that has been requested if it was set up. |
| signature | [neo.fs.v2.service.Signature](#neo.fs.v2.service.Signature) |  | Signature of stable-marshalled Extended ACL according to RFC-6979. |


<a name="neo.fs.v2.container.GetRequest"></a>

### Message GetRequest
Get container structure


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRequest.Body](#neo.fs.v2.container.GetRequest.Body) |  | Body of container get request message. |
| meta_header | [neo.fs.v2.service.RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.GetRequest.Body"></a>

### Message GetRequest.Body
Request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | container_id carries identifier of the container to get. |


<a name="neo.fs.v2.container.GetResponse"></a>

### Message GetResponse
Get container structure


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetResponse.Body](#neo.fs.v2.container.GetResponse.Body) |  | Body of container get response message. |
| meta_header | [neo.fs.v2.service.ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.GetResponse.Body"></a>

### Message GetResponse.Body
Response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container | [Container](#neo.fs.v2.container.Container) |  | Container that has been requested. |


<a name="neo.fs.v2.container.ListRequest"></a>

### Message ListRequest
List containers


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [ListRequest.Body](#neo.fs.v2.container.ListRequest.Body) |  | Body of list containers request message. |
| meta_header | [neo.fs.v2.service.RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.ListRequest.Body"></a>

### Message ListRequest.Body
Request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | owner_id carries identifier of the container owner. |


<a name="neo.fs.v2.container.ListResponse"></a>

### Message ListResponse
List containers


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [ListResponse.Body](#neo.fs.v2.container.ListResponse.Body) |  | Body of list containers response message. |
| meta_header | [neo.fs.v2.service.ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.ListResponse.Body"></a>

### Message ListResponse.Body
Response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_ids | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) | repeated | ContainerIDs carries list of identifiers of the containers that belong to the owner. |


<a name="neo.fs.v2.container.PutRequest"></a>

### Message PutRequest
New NeoFS Container creation request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [PutRequest.Body](#neo.fs.v2.container.PutRequest.Body) |  | Body of container put request message. |
| meta_header | [neo.fs.v2.service.RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.PutRequest.Body"></a>

### Message PutRequest.Body
Request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container | [Container](#neo.fs.v2.container.Container) |  | Container to create in NeoFS. |
| signature | [neo.fs.v2.service.Signature](#neo.fs.v2.service.Signature) |  | Signature of stable-marshalled container according to RFC-6979. |


<a name="neo.fs.v2.container.PutResponse"></a>

### Message PutResponse
New NeoFS Container creation response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [PutResponse.Body](#neo.fs.v2.container.PutResponse.Body) |  | Body of container put response message. |
| meta_header | [neo.fs.v2.service.ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.PutResponse.Body"></a>

### Message PutResponse.Body
Response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | container_id carries identifier of the new container. |


<a name="neo.fs.v2.container.SetExtendedACLRequest"></a>

### Message SetExtendedACLRequest
Set Extended ACL


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SetExtendedACLRequest.Body](#neo.fs.v2.container.SetExtendedACLRequest.Body) |  | Body of set extended acl request message. |
| meta_header | [neo.fs.v2.service.RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.SetExtendedACLRequest.Body"></a>

### Message SetExtendedACLRequest.Body
Request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| eacl | [neo.fs.v2.acl.EACLTable](#neo.fs.v2.acl.EACLTable) |  | Extended ACL to set for the container. |
| signature | [neo.fs.v2.service.Signature](#neo.fs.v2.service.Signature) |  | Signature of stable-marshalled Extended ACL according to RFC-6979. |


<a name="neo.fs.v2.container.SetExtendedACLResponse"></a>

### Message SetExtendedACLResponse
Set Extended ACL


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SetExtendedACLResponse.Body](#neo.fs.v2.container.SetExtendedACLResponse.Body) |  | Body of set extended acl response message. |
| meta_header | [neo.fs.v2.service.ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.SetExtendedACLResponse.Body"></a>

### Message SetExtendedACLResponse.Body
Response body


 <!-- end messages -->

 <!-- end enums -->



<a name="container/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## container/types.proto


 <!-- end services -->


<a name="neo.fs.v2.container.Container"></a>

### Message Container
Container is a structure that defines object placement behaviour. Objects
can be stored only within containers. They define placement rule, attributes
and access control information. ID of the container is a 32 byte long
SHA256 hash of stable-marshalled container message.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.service.Version](#neo.fs.v2.service.Version) |  | Container format version. Effectively the version of API library used to create container |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | OwnerID carries identifier of the container owner. |
| nonce | [bytes](#bytes) |  | Nonce is a 16 byte UUID, used to avoid collisions of container id. |
| basic_acl | [uint32](#uint32) |  | BasicACL contains access control rules for owner, system, others groups and permission bits for bearer token and Extended ACL. |
| attributes | [Container.Attribute](#neo.fs.v2.container.Container.Attribute) | repeated | Attributes define any immutable characteristics of container. |
| placement_policy | [neo.fs.v2.netmap.PlacementPolicy](#neo.fs.v2.netmap.PlacementPolicy) |  | Placement policy for the object inside the container. |


<a name="neo.fs.v2.container.Container.Attribute"></a>

### Message Container.Attribute
Attribute is a key-value pair of strings.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | Key of immutable container attribute. |
| value | [string](#string) |  | Value of immutable container attribute. |

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

