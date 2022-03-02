# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [container/service.proto](#container/service.proto)
 - Services
    - [ContainerService](#neo.fs.v2.container.ContainerService)
    
  - Messages
    - [AnnounceUsedSpaceRequest](#neo.fs.v2.container.AnnounceUsedSpaceRequest)
    - [AnnounceUsedSpaceRequest.Body](#neo.fs.v2.container.AnnounceUsedSpaceRequest.Body)
    - [AnnounceUsedSpaceRequest.Body.Announcement](#neo.fs.v2.container.AnnounceUsedSpaceRequest.Body.Announcement)
    - [AnnounceUsedSpaceResponse](#neo.fs.v2.container.AnnounceUsedSpaceResponse)
    - [AnnounceUsedSpaceResponse.Body](#neo.fs.v2.container.AnnounceUsedSpaceResponse.Body)
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
`ContainerService` provides API to interact with `Container` smart contract
in NeoFS sidechain via other NeoFS nodes. All of those actions can be done
equivalently by directly issuing transactions and RPC calls to sidechain
nodes.

```
rpc Put(PutRequest) returns (PutResponse);
rpc Delete(DeleteRequest) returns (DeleteResponse);
rpc Get(GetRequest) returns (GetResponse);
rpc List(ListRequest) returns (ListResponse);
rpc SetExtendedACL(SetExtendedACLRequest) returns (SetExtendedACLResponse);
rpc GetExtendedACL(GetExtendedACLRequest) returns (GetExtendedACLResponse);
rpc AnnounceUsedSpace(AnnounceUsedSpaceRequest) returns (AnnounceUsedSpaceResponse);

```

#### Method Put

`Put` invokes `Container` smart contract's `Put` method and returns
response immediately. After a new block is issued in sidechain, request is
verified by Inner Ring nodes. After one more block in sidechain, container
is added into smart contract storage.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  request to save the container has been sent to the sidechain;
- Common failures (SECTION_FAILURE_COMMON).

| Name | Input | Output |
| ---- | ----- | ------ |
| Put | [PutRequest](#neo.fs.v2.container.PutRequest) | [PutResponse](#neo.fs.v2.container.PutResponse) |
#### Method Delete

`Delete` invokes `Container` smart contract's `Delete` method and returns
response immediately. After a new block is issued in sidechain, request is
verified by Inner Ring nodes. After one more block in sidechain, container
is added into smart contract storage.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  request to remove the container has been sent to the sidechain;
- Common failures (SECTION_FAILURE_COMMON).

| Name | Input | Output |
| ---- | ----- | ------ |
| Delete | [DeleteRequest](#neo.fs.v2.container.DeleteRequest) | [DeleteResponse](#neo.fs.v2.container.DeleteResponse) |
#### Method Get

Returns container structure from `Container` smart contract storage.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  container has been successfully read;
- Common failures (SECTION_FAILURE_COMMON);
- **CONTAINER_NOT_FOUND** (3072, SECTION_CONTAINER): \
  requested container not found.

| Name | Input | Output |
| ---- | ----- | ------ |
| Get | [GetRequest](#neo.fs.v2.container.GetRequest) | [GetResponse](#neo.fs.v2.container.GetResponse) |
#### Method List

Returns all owner's containers from 'Container` smart contract' storage.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  container list has been successfully read;
- Common failures (SECTION_FAILURE_COMMON).

| Name | Input | Output |
| ---- | ----- | ------ |
| List | [ListRequest](#neo.fs.v2.container.ListRequest) | [ListResponse](#neo.fs.v2.container.ListResponse) |
#### Method SetExtendedACL

Invokes 'SetEACL' method of 'Container` smart contract and returns response
immediately. After one more block in sidechain, Extended ACL changes are
added into smart contract storage.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  request to save container eACL has been sent to the sidechain;
- Common failures (SECTION_FAILURE_COMMON).

| Name | Input | Output |
| ---- | ----- | ------ |
| SetExtendedACL | [SetExtendedACLRequest](#neo.fs.v2.container.SetExtendedACLRequest) | [SetExtendedACLResponse](#neo.fs.v2.container.SetExtendedACLResponse) |
#### Method GetExtendedACL

Returns Extended ACL table and signature from `Container` smart contract
storage.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  container eACL has been successfully read;
- Common failures (SECTION_FAILURE_COMMON);
- **CONTAINER_NOT_FOUND** (3072, SECTION_CONTAINER): \
  container not found.

| Name | Input | Output |
| ---- | ----- | ------ |
| GetExtendedACL | [GetExtendedACLRequest](#neo.fs.v2.container.GetExtendedACLRequest) | [GetExtendedACLResponse](#neo.fs.v2.container.GetExtendedACLResponse) |
#### Method AnnounceUsedSpace

Announce container used space values for P2P synchronization.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  estimation of used space has been successfully announced;
- Common failures (SECTION_FAILURE_COMMON).

| Name | Input | Output |
| ---- | ----- | ------ |
| AnnounceUsedSpace | [AnnounceUsedSpaceRequest](#neo.fs.v2.container.AnnounceUsedSpaceRequest) | [AnnounceUsedSpaceResponse](#neo.fs.v2.container.AnnounceUsedSpaceResponse) |
 <!-- end services -->


<a name="neo.fs.v2.container.AnnounceUsedSpaceRequest"></a>

### Message AnnounceUsedSpaceRequest
Announce container used space


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [AnnounceUsedSpaceRequest.Body](#neo.fs.v2.container.AnnounceUsedSpaceRequest.Body) |  | Body of announce used space request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.AnnounceUsedSpaceRequest.Body"></a>

### Message AnnounceUsedSpaceRequest.Body
Container used space announcement body.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| announcements | [AnnounceUsedSpaceRequest.Body.Announcement](#neo.fs.v2.container.AnnounceUsedSpaceRequest.Body.Announcement) | repeated | List of announcements. If nodes share several containers, then announcements transferred in a batch. |


<a name="neo.fs.v2.container.AnnounceUsedSpaceRequest.Body.Announcement"></a>

### Message AnnounceUsedSpaceRequest.Body.Announcement
Announcement contains used space information about single container.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| epoch | [uint64](#uint64) |  | Epoch number for which container size estimation was produced. |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Identifier of the container. |
| used_space | [uint64](#uint64) |  | Used space is a sum of object payload sizes of specified container, stored in the node. It must not include inhumed objects. |


<a name="neo.fs.v2.container.AnnounceUsedSpaceResponse"></a>

### Message AnnounceUsedSpaceResponse
Announce container used space


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [AnnounceUsedSpaceResponse.Body](#neo.fs.v2.container.AnnounceUsedSpaceResponse.Body) |  | Body of announce used space response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.AnnounceUsedSpaceResponse.Body"></a>

### Message AnnounceUsedSpaceResponse.Body
`AnnounceUsedSpaceResponse` has an empty body because announcements are
one way communication.



<a name="neo.fs.v2.container.DeleteRequest"></a>

### Message DeleteRequest
Container removal request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [DeleteRequest.Body](#neo.fs.v2.container.DeleteRequest.Body) |  | Body of container delete request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.DeleteRequest.Body"></a>

### Message DeleteRequest.Body
Container removal request body has a signed `ContainerID` as a proof of
container owner's intent. The signature will be verified by `Container`
smart contract, so signing algorithm must be supported by NeoVM.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Identifier of the container to delete from NeoFS |
| signature | [neo.fs.v2.refs.SignatureRFC6979](#neo.fs.v2.refs.SignatureRFC6979) |  | `ContainerID` signed with the container owner's key according to RFC-6979. |


<a name="neo.fs.v2.container.DeleteResponse"></a>

### Message DeleteResponse
`DeleteResponse` has an empty body because delete operation is asynchronous
and done via consensus in Inner Ring nodes.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [DeleteResponse.Body](#neo.fs.v2.container.DeleteResponse.Body) |  | Body of container delete response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.DeleteResponse.Body"></a>

### Message DeleteResponse.Body
`DeleteResponse` has an empty body because delete operation is asynchronous
and done via consensus in Inner Ring nodes.



<a name="neo.fs.v2.container.GetExtendedACLRequest"></a>

### Message GetExtendedACLRequest
Get Extended ACL


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetExtendedACLRequest.Body](#neo.fs.v2.container.GetExtendedACLRequest.Body) |  | Body of get extended acl request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.GetExtendedACLRequest.Body"></a>

### Message GetExtendedACLRequest.Body
Get Extended ACL request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Identifier of the container having Extended ACL |


<a name="neo.fs.v2.container.GetExtendedACLResponse"></a>

### Message GetExtendedACLResponse
Get Extended ACL


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetExtendedACLResponse.Body](#neo.fs.v2.container.GetExtendedACLResponse.Body) |  | Body of get extended acl response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.GetExtendedACLResponse.Body"></a>

### Message GetExtendedACLResponse.Body
Get Extended ACL Response body can be empty if the requested container did
not have Extended ACL Table attached or Extended ACL was not allowed at
container creation.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| eacl | [neo.fs.v2.acl.EACLTable](#neo.fs.v2.acl.EACLTable) |  | Extended ACL requested, if available |
| signature | [neo.fs.v2.refs.SignatureRFC6979](#neo.fs.v2.refs.SignatureRFC6979) |  | Signature of stable-marshalled Extended ACL according to RFC-6979. |
| session_token | [neo.fs.v2.session.SessionToken](#neo.fs.v2.session.SessionToken) |  | Session token if Extended ACL was set within a session |


<a name="neo.fs.v2.container.GetRequest"></a>

### Message GetRequest
Get container structure


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetRequest.Body](#neo.fs.v2.container.GetRequest.Body) |  | Body of container get request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.GetRequest.Body"></a>

### Message GetRequest.Body
Get container structure request body.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Identifier of the container to get |


<a name="neo.fs.v2.container.GetResponse"></a>

### Message GetResponse
Get container structure


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [GetResponse.Body](#neo.fs.v2.container.GetResponse.Body) |  | Body of container get response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.GetResponse.Body"></a>

### Message GetResponse.Body
Get container response body does not have container structure signature. It
was already verified on container creation.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container | [Container](#neo.fs.v2.container.Container) |  | Requested container structure |
| signature | [neo.fs.v2.refs.SignatureRFC6979](#neo.fs.v2.refs.SignatureRFC6979) |  | Signature of a stable-marshalled container according to RFC-6979. |
| session_token | [neo.fs.v2.session.SessionToken](#neo.fs.v2.session.SessionToken) |  | Session token if the container was created within a session |


<a name="neo.fs.v2.container.ListRequest"></a>

### Message ListRequest
List containers


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [ListRequest.Body](#neo.fs.v2.container.ListRequest.Body) |  | Body of list containers request message |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.ListRequest.Body"></a>

### Message ListRequest.Body
List containers request body.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Identifier of the container owner |


<a name="neo.fs.v2.container.ListResponse"></a>

### Message ListResponse
List containers


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [ListResponse.Body](#neo.fs.v2.container.ListResponse.Body) |  | Body of list containers response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.ListResponse.Body"></a>

### Message ListResponse.Body
List containers response body.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_ids | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) | repeated | List of `ContainerID`s belonging to the requested `OwnerID` |


<a name="neo.fs.v2.container.PutRequest"></a>

### Message PutRequest
New NeoFS Container creation request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [PutRequest.Body](#neo.fs.v2.container.PutRequest.Body) |  | Body of container put request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.PutRequest.Body"></a>

### Message PutRequest.Body
Container creation request has container structure's signature as a
separate field. It's not stored in sidechain, just verified on container
creation by `Container` smart contract. `ContainerID` is a SHA256 hash of
the stable-marshalled container strucutre, hence there is no need for
additional signature checks.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container | [Container](#neo.fs.v2.container.Container) |  | Container structure to register in NeoFS |
| signature | [neo.fs.v2.refs.SignatureRFC6979](#neo.fs.v2.refs.SignatureRFC6979) |  | Signature of a stable-marshalled container according to RFC-6979. |


<a name="neo.fs.v2.container.PutResponse"></a>

### Message PutResponse
New NeoFS Container creation response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [PutResponse.Body](#neo.fs.v2.container.PutResponse.Body) |  | Body of container put response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.PutResponse.Body"></a>

### Message PutResponse.Body
Container put response body contains information about the newly registered
container as seen by `Container` smart contract. `ContainerID` can be
calculated beforehand from the container structure and compared to the one
returned here to make sure everything was done as expected.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Unique identifier of the newly created container |


<a name="neo.fs.v2.container.SetExtendedACLRequest"></a>

### Message SetExtendedACLRequest
Set Extended ACL


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SetExtendedACLRequest.Body](#neo.fs.v2.container.SetExtendedACLRequest.Body) |  | Body of set extended acl request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.SetExtendedACLRequest.Body"></a>

### Message SetExtendedACLRequest.Body
Set Extended ACL request body does not have separate `ContainerID`
reference. It will be taken from `EACLTable.container_id` field.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| eacl | [neo.fs.v2.acl.EACLTable](#neo.fs.v2.acl.EACLTable) |  | Extended ACL table to set for container |
| signature | [neo.fs.v2.refs.SignatureRFC6979](#neo.fs.v2.refs.SignatureRFC6979) |  | Signature of stable-marshalled Extended ACL table according to RFC-6979. |


<a name="neo.fs.v2.container.SetExtendedACLResponse"></a>

### Message SetExtendedACLResponse
Set Extended ACL


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SetExtendedACLResponse.Body](#neo.fs.v2.container.SetExtendedACLResponse.Body) |  | Body of set extended acl response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.container.SetExtendedACLResponse.Body"></a>

### Message SetExtendedACLResponse.Body
`SetExtendedACLResponse` has an empty body because the operation is
asynchronous and update should be reflected in `Container` smart contract's
storage after next block is issued in sidechain.


 <!-- end messages -->

 <!-- end enums -->



<a name="container/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## container/types.proto


 <!-- end services -->


<a name="neo.fs.v2.container.Container"></a>

### Message Container
Container is a structure that defines object placement behaviour. Objects can
be stored only within containers. They define placement rule, attributes and
access control information. ID of the container is a 32 byte long SHA256 hash
of stable-marshalled container message.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Container format version. Effectively the version of API library used to create container. |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Identifier of the container owner |
| nonce | [bytes](#bytes) |  | Nonce is a 16 byte UUIDv4, used to avoid collisions of `ContainerID`s |
| basic_acl | [uint32](#uint32) |  | `BasicACL` contains access control rules for owner, system, others groups and permission bits for `BearerToken` and `Extended ACL` |
| attributes | [Container.Attribute](#neo.fs.v2.container.Container.Attribute) | repeated | Attributes represent immutable container's meta data |
| placement_policy | [neo.fs.v2.netmap.PlacementPolicy](#neo.fs.v2.netmap.PlacementPolicy) |  | Placement policy for the object inside the container |


<a name="neo.fs.v2.container.Container.Attribute"></a>

### Message Container.Attribute
`Attribute` is a user-defined Key-Value metadata pair attached to the
container. Container attributes are immutable. They are set at container
creation and can never be added or updated.

Key name must be a container-unique valid UTF-8 string. Value can't be
empty. Containers with duplicated attribute names or attributes with empty
values will be considered invalid.

There are some "well-known" attributes affecting system behaviour:

* __NEOFS__SUBNET \
  String ID of container's storage subnet. Container can be attached to
  only one subnet.
* __NEOFS__NAME \
  String of human-friendly container name registered as the domain in
  NNS contract.
* __NEOFS__ZONE \
  String of zone for `__NEOFS__NAME`. Used as TLD of domain name in NNS
  contract. If zone is not specified, use default zone: `container`.

And some well-known attributes used by applications only:

* Name \
  Human-friendly name
* Timestamp \
  User-defined local time of container creation in Unix Timestamp format


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | Attribute name key |
| value | [string](#string) |  | Attribute value |

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

