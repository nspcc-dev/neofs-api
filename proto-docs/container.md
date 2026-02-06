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
    - [RemoveAttributeRequest](#neo.fs.v2.container.RemoveAttributeRequest)
    - [RemoveAttributeRequest.Body](#neo.fs.v2.container.RemoveAttributeRequest.Body)
    - [RemoveAttributeRequest.Body.Parameters](#neo.fs.v2.container.RemoveAttributeRequest.Body.Parameters)
    - [RemoveAttributeResponse](#neo.fs.v2.container.RemoveAttributeResponse)
    - [SetAttributeRequest](#neo.fs.v2.container.SetAttributeRequest)
    - [SetAttributeRequest.Body](#neo.fs.v2.container.SetAttributeRequest.Body)
    - [SetAttributeRequest.Body.Parameters](#neo.fs.v2.container.SetAttributeRequest.Body.Parameters)
    - [SetAttributeResponse](#neo.fs.v2.container.SetAttributeResponse)
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
in FS chain via other NeoFS nodes. All of those actions can be done
equivalently by directly issuing transactions and RPC calls to FS chain
nodes.

```
rpc Put(PutRequest) returns (PutResponse);
rpc Delete(DeleteRequest) returns (DeleteResponse);
rpc Get(GetRequest) returns (GetResponse);
rpc List(ListRequest) returns (ListResponse);
rpc SetExtendedACL(SetExtendedACLRequest) returns (SetExtendedACLResponse);
rpc GetExtendedACL(GetExtendedACLRequest) returns (GetExtendedACLResponse);
rpc AnnounceUsedSpace(AnnounceUsedSpaceRequest) returns (AnnounceUsedSpaceResponse);
rpc SetAttribute(SetAttributeRequest) returns (SetAttributeResponse);
rpc RemoveAttribute(RemoveAttributeRequest) returns (RemoveAttributeResponse);

```

#### Method Put

Sends transaction calling contract method to create container, and waits
for the transaction to be executed. Deadline is determined by the
transport protocol (e.g. `grpc-timeout` header). If the deadline is not
set, server waits 15s after submitting the transaction.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  container successfully created;
- Common failures (SECTION_FAILURE_COMMON);
- **CONTAINER_AWAIT_TIMEOUT** (3075, SECTION_CONTAINER): \
  transaction was sent but not executed within the deadline.

| Name | Input | Output |
| ---- | ----- | ------ |
| Put | [PutRequest](#neo.fs.v2.container.PutRequest) | [PutResponse](#neo.fs.v2.container.PutResponse) |
#### Method Delete

Sends transaction calling contract method to delete container, and waits
for the transaction to be executed. Deadline is determined by the
transport protocol (e.g. `grpc-timeout` header). If the deadline is not
set, server waits 15s after submitting the transaction.
NOTE: a container deletion leads to the removal of every object in that
container, regardless of any restrictions on the object removal (e.g. lock/locked
object would be also removed).

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  container successfully removed;
- Common failures (SECTION_FAILURE_COMMON);
- **CONTAINER_LOCKED** (3074, SECTION_CONTAINER): \
  deleting a locked container is prohibited;
- **CONTAINER_AWAIT_TIMEOUT** (3075, SECTION_CONTAINER): \
  transaction was sent but not executed within the deadline.

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

Sends transaction calling contract method to set container's extended ACL,
and waits for the transaction to be executed. Deadline is determined by
the transport protocol (e.g. `grpc-timeout` header). If the deadline is
not set, server waits 15s after submitting the transaction.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  container eACL successfully set;
- Common failures (SECTION_FAILURE_COMMON);
- **CONTAINER_AWAIT_TIMEOUT** (3075, SECTION_CONTAINER): \
  transaction was sent but not executed within the deadline.

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
  container not found;
- **EACL_NOT_FOUND** (3073, SECTION_CONTAINER): \
  eACL table not found.

| Name | Input | Output |
| ---- | ----- | ------ |
| GetExtendedACL | [GetExtendedACLRequest](#neo.fs.v2.container.GetExtendedACLRequest) | [GetExtendedACLResponse](#neo.fs.v2.container.GetExtendedACLResponse) |
#### Method AnnounceUsedSpace

Announces the space values used by the container for P2P synchronization.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  estimation of used space has been successfully announced;
- Common failures (SECTION_FAILURE_COMMON).

DEPRECATED: every storage node must send storage load directly to `container`
contract.

| Name | Input | Output |
| ---- | ----- | ------ |
| AnnounceUsedSpace | [AnnounceUsedSpaceRequest](#neo.fs.v2.container.AnnounceUsedSpaceRequest) | [AnnounceUsedSpaceResponse](#neo.fs.v2.container.AnnounceUsedSpaceResponse) |
#### Method SetAttribute

Sends transaction calling contract method to set container attribute, and
waits for the transaction to be executed. Deadline is determined by the
transport protocol (e.g. `grpc-timeout` header). If the deadline is not
set, server waits 15s after submitting the transaction.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  attribute successfully set;
- Common failures (SECTION_FAILURE_COMMON);
- **CONTAINER_AWAIT_TIMEOUT** (3075, SECTION_CONTAINER): \
  transaction was sent but not executed within the deadline.

| Name | Input | Output |
| ---- | ----- | ------ |
| SetAttribute | [SetAttributeRequest](#neo.fs.v2.container.SetAttributeRequest) | [SetAttributeResponse](#neo.fs.v2.container.SetAttributeResponse) |
#### Method RemoveAttribute

Sends transaction calling contract method to remove container attribute,
and waits for the transaction to be executed. Deadline is determined by
the transport protocol (e.g. `grpc-timeout` header). If the deadline is
not set, server waits 15s after submitting the transaction.

Statuses:
- **OK** (0, SECTION_SUCCESS): \
  attribute successfully removed;
- Common failures (SECTION_FAILURE_COMMON);
- **CONTAINER_AWAIT_TIMEOUT** (3075, SECTION_CONTAINER): \
  transaction was sent but not executed within the deadline.

| Name | Input | Output |
| ---- | ----- | ------ |
| RemoveAttribute | [RemoveAttributeRequest](#neo.fs.v2.container.RemoveAttributeRequest) | [RemoveAttributeResponse](#neo.fs.v2.container.RemoveAttributeResponse) |
 <!-- end services -->


<a name="neo.fs.v2.container.AnnounceUsedSpaceRequest"></a>

### Message AnnounceUsedSpaceRequest
Announce container used space

DEPRECATED: every storage node must send storage load directly to `container`
contract.


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
| announcements | [AnnounceUsedSpaceRequest.Body.Announcement](#neo.fs.v2.container.AnnounceUsedSpaceRequest.Body.Announcement) | repeated | List of announcements. If nodes share several containers, announcements are transferred in a batch. |


<a name="neo.fs.v2.container.AnnounceUsedSpaceRequest.Body.Announcement"></a>

### Message AnnounceUsedSpaceRequest.Body.Announcement
Announcement contains used space information for a single container.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| epoch | [uint64](#uint64) |  | Epoch number for which the container size estimation was produced. |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Identifier of the container. |
| used_space | [uint64](#uint64) |  | Used space is a sum of object payload sizes of a specified container, stored in the node. It must not include inhumed objects. |


<a name="neo.fs.v2.container.AnnounceUsedSpaceResponse"></a>

### Message AnnounceUsedSpaceResponse
Announce container used space

DEPRECATED: every storage node must send storage load directly to `container`
contract.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [AnnounceUsedSpaceResponse.Body](#neo.fs.v2.container.AnnounceUsedSpaceResponse.Body) |  | Body of announce used space response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. DEPRECATED: the field is no longer used for verifications. Servers MUST attach it for requests with `meta_header.version` <= 2.21. |


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
Container removal request body has signed `ContainerID` as a proof of
the container owner's intent. The signature will be verified by `Container`
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
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. DEPRECATED: the field is no longer used for verifications. Servers MUST attach it for requests with `meta_header.version` <= 2.21. |


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
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. DEPRECATED: the field is no longer used for verifications. Servers MUST attach it for requests with `meta_header.version` <= 2.21. |


<a name="neo.fs.v2.container.GetExtendedACLResponse.Body"></a>

### Message GetExtendedACLResponse.Body
Get Extended ACL Response body can be empty if the requested container does
not have Extended ACL Table attached or Extended ACL has not been allowed at
the time of container creation.


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
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. DEPRECATED: the field is no longer used for verifications. Servers MUST attach it for requests with `meta_header.version` <= 2.21. |


<a name="neo.fs.v2.container.GetResponse.Body"></a>

### Message GetResponse.Body
Get container response body does not have container structure signature. It
has been already verified upon container creation.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container | [Container](#neo.fs.v2.container.Container) |  | Requested container structure |
| signature | [neo.fs.v2.refs.SignatureRFC6979](#neo.fs.v2.refs.SignatureRFC6979) |  | Signature of a stable-marshalled container according to RFC-6979. |
| session_token | [neo.fs.v2.session.SessionToken](#neo.fs.v2.session.SessionToken) |  | Session token if the container has been created within the session |


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
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. DEPRECATED: the field is no longer used for verifications. Servers MUST attach it for requests with `meta_header.version` <= 2.21. |


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
separate field. It's not stored in FS chain, just verified on container
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
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. DEPRECATED: the field is no longer used for verifications. Servers MUST attach it for requests with `meta_header.version` <= 2.21. |


<a name="neo.fs.v2.container.PutResponse.Body"></a>

### Message PutResponse.Body
Container put response body contains information about the newly registered
container as seen by `Container` smart contract. `ContainerID` can be
calculated beforehand from the container structure and compared to the one
returned here to make sure everything has been done as expected.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Unique identifier of the newly created container |


<a name="neo.fs.v2.container.RemoveAttributeRequest"></a>

### Message RemoveAttributeRequest
Attribute removal request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [RemoveAttributeRequest.Body](#neo.fs.v2.container.RemoveAttributeRequest.Body) |  | Request payload. |
| body_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signature of stable-marshalled `body` field. |


<a name="neo.fs.v2.container.RemoveAttributeRequest.Body"></a>

### Message RemoveAttributeRequest.Body
Request payload message.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| parameters | [RemoveAttributeRequest.Body.Parameters](#neo.fs.v2.container.RemoveAttributeRequest.Body.Parameters) |  | Op parameters. |
| signature | [neo.fs.v2.refs.SignatureRFC6979](#neo.fs.v2.refs.SignatureRFC6979) |  | N3 witness of stable-marshalled `parameters` field. The signature must authenticate either container owner or one of subjects in the `session_token` field if any. Signature according to `ECDSA_RFC6979_SHA256` scheme is also supported. |
| session_token | [neo.fs.v2.session.SessionTokenV2](#neo.fs.v2.session.SessionTokenV2) |  | Optional session token. The token must be issued by the container owner. The token must have at least one subject authenticated by `signature` field. The token must have at least one context with this container and `CONTAINER_REMOVEATTRIBUTE` verb. |
| session_token_v1 | [neo.fs.v2.session.SessionToken](#neo.fs.v2.session.SessionToken) |  | Optional session token (V1). It must not be set together with `session_token` field that is highly recommended to be used instead. Requirements are the same for both. |


<a name="neo.fs.v2.container.RemoveAttributeRequest.Body.Parameters"></a>

### Message RemoveAttributeRequest.Body.Parameters
Op parameters message.

If container does not have the `attribute`, nothing is done and status
`OK` is returned.

`valid_until` is required request expiration time in Unix Timestamp
format.

`attribute` must be one of:
 - `CORS`;
 - `S3_TAGS`;
 - `S3_SETTINGS`;
 - `S3_NOTIFICATIONS`;
 - `__NEOFS__LOCK_UNTIL`.

Attribute-specific requirements:
 - `__NEOFS__LOCK_UNTIL`: current timestamp must have already passed if any


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Identifier of the container to remove attribute from. |
| attribute | [string](#string) |  | Attribute to be removed. |
| valid_until | [uint64](#uint64) |  | Request expiration time. |


<a name="neo.fs.v2.container.RemoveAttributeResponse"></a>

### Message RemoveAttributeResponse
Attribute removal response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| status | [neo.fs.v2.status.Status](#neo.fs.v2.status.Status) |  | Operation execution status. |


<a name="neo.fs.v2.container.SetAttributeRequest"></a>

### Message SetAttributeRequest
Attribute setting request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SetAttributeRequest.Body](#neo.fs.v2.container.SetAttributeRequest.Body) |  | Request payload. |
| body_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signature of stable-marshalled `body` field. |


<a name="neo.fs.v2.container.SetAttributeRequest.Body"></a>

### Message SetAttributeRequest.Body
Request payload message.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| parameters | [SetAttributeRequest.Body.Parameters](#neo.fs.v2.container.SetAttributeRequest.Body.Parameters) |  | Op parameters. |
| signature | [neo.fs.v2.refs.SignatureRFC6979](#neo.fs.v2.refs.SignatureRFC6979) |  | N3 witness of stable-marshalled `parameters` field. The signature must authenticate either container owner or one of subjects in the `session_token` field if any. Signature according to `ECDSA_RFC6979_SHA256` scheme is also supported. |
| session_token | [neo.fs.v2.session.SessionTokenV2](#neo.fs.v2.session.SessionTokenV2) |  | Optional session token. The token must be issued by the container owner. The token must have at least one subject authenticated by `signature` field. The token must have at least one context with this container and `CONTAINER_SETATTRIBUTE` verb. |
| session_token_v1 | [neo.fs.v2.session.SessionToken](#neo.fs.v2.session.SessionToken) |  | Optional session token (V1). It must not be set together with `session_token` field that is highly recommended to be used instead. Requirements are the same for both. |


<a name="neo.fs.v2.container.SetAttributeRequest.Body.Parameters"></a>

### Message SetAttributeRequest.Body.Parameters
Op parameters message.

If container does not have the `attribute`, it is added. Otherwise, its
value is swapped.

`valid_until` is required request expiration time in Unix Timestamp
format.

`attribute` must be one of:
 - `CORS`;
 - `S3_TAGS`;
 - `S3_SETTINGS`;
 - `S3_NOTIFICATIONS`;
 - `__NEOFS__LOCK_UNTIL`.

In general, requirements for `value` are the same as for container
creation. Attribute-specific requirements:
 - `__NEOFS__LOCK_UNTIL`: new timestamp must be after the current one if any
 - `S3_TAGS`: must be a valid JSON object
 - `S3_SETTINGS`: must be a valid JSON object
 - `S3_NOTIFICATIONS`: must be a valid JSON object


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Identifier of the container to set attribute for. |
| attribute | [string](#string) |  | Attribute to be set. |
| value | [string](#string) |  | New attribute value. |
| valid_until | [uint64](#uint64) |  | Request expiration time. |


<a name="neo.fs.v2.container.SetAttributeResponse"></a>

### Message SetAttributeResponse
Attribute setting response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| status | [neo.fs.v2.status.Status](#neo.fs.v2.status.Status) |  | Operation execution status. |


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
| eacl | [neo.fs.v2.acl.EACLTable](#neo.fs.v2.acl.EACLTable) |  | Extended ACL table to set for the container |
| signature | [neo.fs.v2.refs.SignatureRFC6979](#neo.fs.v2.refs.SignatureRFC6979) |  | Signature of stable-marshalled Extended ACL table according to RFC-6979. |


<a name="neo.fs.v2.container.SetExtendedACLResponse"></a>

### Message SetExtendedACLResponse
Set Extended ACL


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SetExtendedACLResponse.Body](#neo.fs.v2.container.SetExtendedACLResponse.Body) |  | Body of set extended acl response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. DEPRECATED: the field is no longer used for verifications. Servers MUST attach it for requests with `meta_header.version` <= 2.21. |


<a name="neo.fs.v2.container.SetExtendedACLResponse.Body"></a>

### Message SetExtendedACLResponse.Body
`SetExtendedACLResponse` has an empty body because the operation is
asynchronous and the update should be reflected in `Container` smart contract's
storage after next block is issued in FS chain.


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
access control information. An ID of a container is a 32 byte long SHA256 hash
of stable-marshalled container message.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Container format version. Effectively, the version of API library used to create the container. |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Identifier of the container owner |
| nonce | [bytes](#bytes) |  | Nonce is a 16 byte UUIDv4, used to avoid collisions of `ContainerID`s |
| basic_acl | [uint32](#uint32) |  | `BasicACL` contains access control rules for the owner, system and others groups, as well as permission bits for `BearerToken` and `Extended ACL` |
| attributes | [Container.Attribute](#neo.fs.v2.container.Container.Attribute) | repeated | Attributes represent immutable container's meta data |
| placement_policy | [neo.fs.v2.netmap.PlacementPolicy](#neo.fs.v2.netmap.PlacementPolicy) |  | Placement policy for the object inside the container |


<a name="neo.fs.v2.container.Container.Attribute"></a>

### Message Container.Attribute
`Attribute` is a user-defined Key-Value metadata pair attached to the
container.

Key name must be a container-unique valid UTF-8 string. Value can't be
empty. Containers with duplicated attribute names or attributes with empty
values will be considered invalid. Zero byte is also forbidden in UTF-8
strings.

There are some "well-known" attributes affecting system behaviour:

* __NEOFS__SUBNET \
  DEPRECATED. Was used for a string ID of a container's storage subnet.
  Currently doesn't affect anything.
* __NEOFS__NAME \
  String of a human-friendly container name registered as a domain in
  NNS contract.
* __NEOFS__ZONE \
  String of a zone for `__NEOFS__NAME`. Used as a TLD of a domain name in NNS
  contract. If no zone is specified, use default zone: `container`.
* __NEOFS__DISABLE_HOMOMORPHIC_HASHING \
  Disables homomorphic hashing for the container if the value equals "true" string.
  Any other values are interpreted as missing attribute. Container could be
  accepted in a NeoFS network only if the global network hashing configuration
  value corresponds with that attribute's value. After container inclusion, network
  setting is ignored.
* __NEOFS__METAINFO_CONSISTENCY \
  Policy rule that defines the condition under which an object is considered
  processed. Acceptable values and meanings:
    1. "strict": SN processes objects' meta information, it is validated,
      indexed and signed accordingly by a required minimal number of nodes
      that are included in the container, a corresponding object inclusion
      notification can be caught
    2. "optimistic": the same as "strict" but a successful PUT operation
      does not mean objects' meta information has been multi signed and
      indexed correctly, however, SNs will try to do it asynchronously;
      in general PUT operations are expected to be faster than in the
      "strict" case
    3. <other cases>: SN does not process objects' meta
      information, it is not indexed and object presence/number of copies
      is not proven after a successful object PUT operation; the behavior
      is the same as it was before this attribute introduction
* __NEOFS__LOCK_UNTIL \
  Timestamp until which the container cannot be deleted in Unix Timestamp format

And some well-known attributes used by applications only:

* Name \
  Human-friendly name
* Timestamp \
  User-defined local time of container creation in Unix Timestamp format
* CORS \
  It is used to configure your container to allow cross-origin requests (CORS). The rules are represented as a JSON
  array of objects with the following fields:
    1. "AllowedMethods": In this element, you specify allowed HTTP methods: GET, PUT, POST, DELETE, HEAD.
    2. "AllowedOrigins": In this element, you specify the origins that you want to allow cross-domain requests from,
    for example, http://www.example.com. The origin string can contain only one "*" wildcard character,
    such as http://*.example.com. You can optionally specify "*" as the origin to enable all the origins to send
    cross-origin requests. You can also specify https to enable only secure origins.
    3. "AllowedHeaders": The element specifies which headers are allowed in a preflight request through the
    "Access-Control-Request-Headers" request header. Each AllowedHeaders string in your configuration can contain
    at most one "*" wildcard character. For example, x-app-*.
    4. "ExposeHeaders": Each ExposeHeader element identifies a header in the response that you want customers
    to be able to access from their applications (for example, from a JavaScript XMLHttpRequest object).
    5. "MaxAgeSeconds": The element specifies the time in seconds that your browser can cache the response for a
    preflight request as identified by the resource, the HTTP method, and the origin.
    
    The CORS schema is based on Amazon S3 CORS (https://docs.aws.amazon.com/AmazonS3/latest/userguide/cors.html)
    configuration.
* S3_TAGS \
  It is used to store S3 gate-specific container tags. The value is controlled by the gate itself.
  Despite it, the value must be valid JSON object.
* S3_SETTINGS \
  It is used to store S3 gate-specific container settings. The value is controlled by the gate itself.
  Despite it, the value must be valid JSON object.
* S3_NOTIFICATIONS \
  It is used to store S3 gate-specific container notification settings. The value is controlled by the gate itself.
  Despite it, the value must be valid JSON object.


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

