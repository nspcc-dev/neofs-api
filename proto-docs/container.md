# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [container/service.proto](#container/service.proto)
 - Services
    - [Service](#container.Service)
    
  - Messages
    - [DeleteRequest](#container.DeleteRequest)
    - [DeleteResponse](#container.DeleteResponse)
    - [GetExtendedACLRequest](#container.GetExtendedACLRequest)
    - [GetExtendedACLResponse](#container.GetExtendedACLResponse)
    - [GetRequest](#container.GetRequest)
    - [GetResponse](#container.GetResponse)
    - [ListRequest](#container.ListRequest)
    - [ListResponse](#container.ListResponse)
    - [PutRequest](#container.PutRequest)
    - [PutResponse](#container.PutResponse)
    - [SetExtendedACLRequest](#container.SetExtendedACLRequest)
    - [SetExtendedACLResponse](#container.SetExtendedACLResponse)
    

- [container/types.proto](#container/types.proto)

  - Messages
    - [Container](#container.Container)
    - [Container.Attribute](#container.Container.Attribute)
    

- [Scalar Value Types](#scalar-value-types)



<a name="container/service.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## container/service.proto




<a name="container.Service"></a>

### Service "container.Service"
Service provides API to access container smart-contract in morph chain
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
| Put | [PutRequest](#container.PutRequest) | [PutResponse](#container.PutResponse) |
#### Method Delete

Delete invokes 'Delete' method in container smart-contract and returns
response immediately. After new block in morph chain, request is verified
by inner ring nodes. After one more block in morph chain, container
removed from smart-contract storage.

| Name | Input | Output |
| ---- | ----- | ------ |
| Delete | [DeleteRequest](#container.DeleteRequest) | [DeleteResponse](#container.DeleteResponse) |
#### Method Get

Get returns container from container smart-contract storage.

| Name | Input | Output |
| ---- | ----- | ------ |
| Get | [GetRequest](#container.GetRequest) | [GetResponse](#container.GetResponse) |
#### Method List

List returns all owner's containers from container smart-contract
storage.

| Name | Input | Output |
| ---- | ----- | ------ |
| List | [ListRequest](#container.ListRequest) | [ListResponse](#container.ListResponse) |
#### Method SetExtendedACL

SetExtendedACL invokes 'SetEACL' method in container smart-contract and
returns response immediately. After new block in morph chain,
Extended ACL added into smart-contract storage.

| Name | Input | Output |
| ---- | ----- | ------ |
| SetExtendedACL | [SetExtendedACLRequest](#container.SetExtendedACLRequest) | [SetExtendedACLResponse](#container.SetExtendedACLResponse) |
#### Method GetExtendedACL

GetExtendedACL returns Extended ACL table and signature from container
smart-contract storage.

| Name | Input | Output |
| ---- | ----- | ------ |
| GetExtendedACL | [GetExtendedACLRequest](#container.GetExtendedACLRequest) | [GetExtendedACLResponse](#container.GetExtendedACLResponse) |
 <!-- end services -->


<a name="container.DeleteRequest"></a>

### Message DeleteRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [refs.ContainerID](#refs.ContainerID) |  | container_id carries identifier of the container to delete from NeoFS. |
| signature | [bytes](#bytes) |  | Signature of container id according to RFC-6979. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="container.DeleteResponse"></a>

### Message DeleteResponse
DeleteResponse is empty because delete operation is asynchronous and done
via consensus in inner ring nodes


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| meta_header | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | Carries response meta information attached by server. |


<a name="container.GetExtendedACLRequest"></a>

### Message GetExtendedACLRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [refs.ContainerID](#refs.ContainerID) |  | container_id carries identifier of the container that has Extended ACL. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="container.GetExtendedACLResponse"></a>

### Message GetExtendedACLResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| eacl | [acl.EACLTable](#acl.EACLTable) |  | Extended ACL that has been requested if it was set up. |
| signature | [bytes](#bytes) |  | Signature of stable-marshalled Extended ACL according to RFC-6979. |
| meta_header | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | Carries response meta information attached by server. |


<a name="container.GetRequest"></a>

### Message GetRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [refs.ContainerID](#refs.ContainerID) |  | container_id carries identifier of the container to get. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="container.GetResponse"></a>

### Message GetResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container | [Container](#container.Container) |  | Container that has been requested. |
| meta_header | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | Carries response meta information attached by server. |


<a name="container.ListRequest"></a>

### Message ListRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| owner_id | [refs.OwnerID](#refs.OwnerID) |  | owner_id carries identifier of the container owner. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="container.ListResponse"></a>

### Message ListResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_ids | [refs.ContainerID](#refs.ContainerID) | repeated | ContainerIDs carries list of identifiers of the containers that belong to the owner. |
| meta_header | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | Carries response meta information attached by server. |


<a name="container.PutRequest"></a>

### Message PutRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container | [Container](#container.Container) |  | Container to create in NeoFS. |
| public_key | [bytes](#bytes) |  | Public Key of container owner. It can be public key of the owner or it can be public key that bound in neofs.id smart-contract. |
| signature | [bytes](#bytes) |  | Signature of stable-marshalled container according to RFC-6979. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="container.PutResponse"></a>

### Message PutResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [refs.ContainerID](#refs.ContainerID) |  | container_id carries identifier of the new container. |
| meta_header | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | Carries response meta information attached by server. |


<a name="container.SetExtendedACLRequest"></a>

### Message SetExtendedACLRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| eacl | [acl.EACLTable](#acl.EACLTable) |  | Extended ACL to set for the container. |
| signature | [bytes](#bytes) |  | Signature of stable-marshalled Extended ACL according to RFC-6979. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="container.SetExtendedACLResponse"></a>

### Message SetExtendedACLResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| meta_header | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | Carries response meta information attached by server. |

 <!-- end messages -->

 <!-- end enums -->



<a name="container/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## container/types.proto


 <!-- end services -->


<a name="container.Container"></a>

### Message Container
Container is a structure that defines object placement behaviour. Objects
can be stored only within containers. They define placement rule, attributes
and access control information. ID of the container is a 32 byte long
SHA256 hash of stable-marshalled container message.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| owner_id | [refs.OwnerID](#refs.OwnerID) |  | OwnerID carries identifier of the container owner. |
| nonce | [bytes](#bytes) |  | Nonce is a 16 byte UUID, used to avoid collisions of container id. |
| basic_acl | [uint32](#uint32) |  | BasicACL contains access control rules for owner, system, others groups and permission bits for bearer token and Extended ACL. |
| attributes | [Container.Attribute](#container.Container.Attribute) | repeated | Attributes define any immutable characteristics of container. |
| rules | [netmap.PlacementRule](#netmap.PlacementRule) |  | Rules define storage policy for the object inside the container. |


<a name="container.Container.Attribute"></a>

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

