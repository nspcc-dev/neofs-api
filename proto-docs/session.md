# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [session/service.proto](#session/service.proto)
 - Services
    - [SessionService](#neo.fs.v2.session.SessionService)
    
  - Messages
    - [CreateRequest](#neo.fs.v2.session.CreateRequest)
    - [CreateRequest.Body](#neo.fs.v2.session.CreateRequest.Body)
    - [CreateResponse](#neo.fs.v2.session.CreateResponse)
    - [CreateResponse.Body](#neo.fs.v2.session.CreateResponse.Body)
    

- [session/types.proto](#session/types.proto)

  - Messages
    - [ContainerSessionContext](#neo.fs.v2.session.ContainerSessionContext)
    - [ObjectSessionContext](#neo.fs.v2.session.ObjectSessionContext)
    - [ObjectSessionContext.Target](#neo.fs.v2.session.ObjectSessionContext.Target)
    - [RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader)
    - [RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader)
    - [ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader)
    - [ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader)
    - [SessionContextV2](#neo.fs.v2.session.SessionContextV2)
    - [SessionToken](#neo.fs.v2.session.SessionToken)
    - [SessionToken.Body](#neo.fs.v2.session.SessionToken.Body)
    - [SessionToken.Body.TokenLifetime](#neo.fs.v2.session.SessionToken.Body.TokenLifetime)
    - [SessionTokenV2](#neo.fs.v2.session.SessionTokenV2)
    - [SessionTokenV2.Body](#neo.fs.v2.session.SessionTokenV2.Body)
    - [Target](#neo.fs.v2.session.Target)
    - [TokenLifetime](#neo.fs.v2.session.TokenLifetime)
    - [XHeader](#neo.fs.v2.session.XHeader)
    

- [Scalar Value Types](#scalar-value-types)



<a name="session/service.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## session/service.proto




<a name="neo.fs.v2.session.SessionService"></a>

### Service "neo.fs.v2.session.SessionService"
`SessionService` allows to establish a temporary trust relationship between
two peer nodes and generate a `SessionToken` as the proof of trust to be
attached in requests for further verification. Please see corresponding
section of NeoFS Technical Specification for details.

```
rpc Create(CreateRequest) returns (CreateResponse);

```

#### Method Create

Open a new session between two peers.

Statuses:
- **OK** (0, SECTION_SUCCESS):
session has been successfully opened;
- Common failures (SECTION_FAILURE_COMMON).

| Name | Input | Output |
| ---- | ----- | ------ |
| Create | [CreateRequest](#neo.fs.v2.session.CreateRequest) | [CreateResponse](#neo.fs.v2.session.CreateResponse) |
 <!-- end services -->


<a name="neo.fs.v2.session.CreateRequest"></a>

### Message CreateRequest
Information necessary for opening a session.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [CreateRequest.Body](#neo.fs.v2.session.CreateRequest.Body) |  | Body of a create session token request message. |
| meta_header | [RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.session.CreateRequest.Body"></a>

### Message CreateRequest.Body
Session creation request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Session initiating user's or node's key derived `OwnerID` |
| expiration | [uint64](#uint64) |  | Session expiration epoch, the last epoch when session is valid. |


<a name="neo.fs.v2.session.CreateResponse"></a>

### Message CreateResponse
Information about the opened session.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [CreateResponse.Body](#neo.fs.v2.session.CreateResponse.Body) |  | Body of create session token response message. |
| meta_header | [ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.session.CreateResponse.Body"></a>

### Message CreateResponse.Body
Session creation response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [bytes](#bytes) |  | Identifier of a newly created session |
| session_key | [bytes](#bytes) |  | Public key used for session |

 <!-- end messages -->

 <!-- end enums -->



<a name="session/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## session/types.proto


 <!-- end services -->


<a name="neo.fs.v2.session.ContainerSessionContext"></a>

### Message ContainerSessionContext
Context information for Session Tokens related to ContainerService requests.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| verb | [ContainerSessionContext.Verb](#neo.fs.v2.session.ContainerSessionContext.Verb) |  | Type of request for which the token is issued |
| wildcard | [bool](#bool) |  | Spreads the action to all owner containers. If set, container_id field is ignored. |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Particular container to which the action applies. Ignored if wildcard flag is set. |


<a name="neo.fs.v2.session.ObjectSessionContext"></a>

### Message ObjectSessionContext
Context information for Session Tokens related to ObjectService requests


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| verb | [ObjectSessionContext.Verb](#neo.fs.v2.session.ObjectSessionContext.Verb) |  | Type of request for which the token is issued |
| target | [ObjectSessionContext.Target](#neo.fs.v2.session.ObjectSessionContext.Target) |  | Object session target. MUST be correctly formed and set. If `objects` field is not empty, then the session applies only to these elements, otherwise, to all objects from the specified container. |


<a name="neo.fs.v2.session.ObjectSessionContext.Target"></a>

### Message ObjectSessionContext.Target
Carries objects involved in the object session.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Indicates which container the session is spread to. Field MUST be set and correct. |
| objects | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) | repeated | Indicates which objects the session is spread to. Objects are expected to be stored in the NeoFS container referenced by `container` field. Each element MUST have correct format. |


<a name="neo.fs.v2.session.RequestMetaHeader"></a>

### Message RequestMetaHeader
Meta information attached to the request. When forwarded between peers,
request meta headers are folded in matryoshka style.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Peer's API version used |
| epoch | [uint64](#uint64) |  | Peer's local epoch number. Set to 0 if unknown. |
| ttl | [uint32](#uint32) |  | Maximum number of intermediate nodes in the request route |
| x_headers | [XHeader](#neo.fs.v2.session.XHeader) | repeated | Request X-Headers |
| session_token | [SessionToken](#neo.fs.v2.session.SessionToken) |  | Session token within which the request is sent |
| session_token_v2 | [SessionTokenV2](#neo.fs.v2.session.SessionTokenV2) |  | Session token v2 with delegation chain support. Requests are invalid if both session_token and session_token_v2 are set. |
| bearer_token | [neo.fs.v2.acl.BearerToken](#neo.fs.v2.acl.BearerToken) |  | `BearerToken` with eACL overrides for the request |
| origin | [RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | `RequestMetaHeader` of the origin request |
| magic_number | [uint64](#uint64) |  | NeoFS network magic. Must match the value for the network that the server belongs to. |


<a name="neo.fs.v2.session.RequestVerificationHeader"></a>

### Message RequestVerificationHeader
Verification info for the request signed by all intermediate nodes.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Request Body signature. Should be generated once by the request initiator. |
| meta_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Request Meta signature is added and signed by each intermediate node |
| origin_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signature of previous hops |
| origin | [RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Chain of previous hops signatures |


<a name="neo.fs.v2.session.ResponseMetaHeader"></a>

### Message ResponseMetaHeader
Information about the response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Peer's API version used |
| epoch | [uint64](#uint64) |  | Peer's local epoch number |
| ttl | [uint32](#uint32) |  | Maximum number of intermediate nodes in the request route |
| x_headers | [XHeader](#neo.fs.v2.session.XHeader) | repeated | Response X-Headers |
| origin | [ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | `ResponseMetaHeader` of the origin request |
| status | [neo.fs.v2.status.Status](#neo.fs.v2.status.Status) |  | Status return |


<a name="neo.fs.v2.session.ResponseVerificationHeader"></a>

### Message ResponseVerificationHeader
Verification info for the response signed by all intermediate nodes


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Response Body signature. Should be generated once by an answering node. |
| meta_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Response Meta signature is added and signed by each intermediate node |
| origin_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signature of previous hops |
| origin | [ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Chain of previous hops signatures |


<a name="neo.fs.v2.session.SessionContextV2"></a>

### Message SessionContextV2
SessionContextV2 carries unified context for both ObjectService and ContainerService requests.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Container where operation is allowed. For container operations, this is the container being operated on. For object operations, this is the container holding the objects. |
| objects | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) | repeated | Specific objects where operation is allowed. Only relevant for object operations. Empty list means all objects in the container. Maximum number of objects: 1000. |
| verbs | [Verb](#neo.fs.v2.session.Verb) | repeated | Operations authorized for this context. Maximum number of verbs: 12. |


<a name="neo.fs.v2.session.SessionToken"></a>

### Message SessionToken
NeoFS Session Token.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SessionToken.Body](#neo.fs.v2.session.SessionToken.Body) |  | Session Token contains the proof of trust between peers to be attached in requests for further verification. Please see corresponding section of NeoFS Technical Specification for details. |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signature of `SessionToken` information |


<a name="neo.fs.v2.session.SessionToken.Body"></a>

### Message SessionToken.Body
Session Token body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [bytes](#bytes) |  | Token identifier is a valid UUIDv4 in binary form |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Identifier of the session initiator |
| lifetime | [SessionToken.Body.TokenLifetime](#neo.fs.v2.session.SessionToken.Body.TokenLifetime) |  | Lifetime of the session |
| session_key | [bytes](#bytes) |  | Public key used in session |
| object | [ObjectSessionContext](#neo.fs.v2.session.ObjectSessionContext) |  | ObjectService session context |
| container | [ContainerSessionContext](#neo.fs.v2.session.ContainerSessionContext) |  | ContainerService session context |


<a name="neo.fs.v2.session.SessionToken.Body.TokenLifetime"></a>

### Message SessionToken.Body.TokenLifetime
Lifetime parameters of the token. Field names taken from rfc7519.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| exp | [uint64](#uint64) |  | Expiration epoch, the last epoch when token is valid. |
| nbf | [uint64](#uint64) |  | Not valid before epoch, the first epoch when token is valid. |
| iat | [uint64](#uint64) |  | Issued at Epoch |


<a name="neo.fs.v2.session.SessionTokenV2"></a>

### Message SessionTokenV2
SessionTokenV2 represents NeoFS Session Token with delegation support.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SessionTokenV2.Body](#neo.fs.v2.session.SessionTokenV2.Body) |  | Session token body. |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signature of the body by the issuer. |
| origin | [SessionTokenV2](#neo.fs.v2.session.SessionTokenV2) |  | Origin token that was delegated to create this token. This creates a chain of trust through token embedding. When B receives a token from A and wants to delegate to C, B creates a new SessionTokenV2 and embeds A's token here. Delegation cannot be wider than the previous token's lifetime and contexts. Maximum chain depth: 4. |


<a name="neo.fs.v2.session.SessionTokenV2.Body"></a>

### Message SessionTokenV2.Body
Session Token body.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [uint32](#uint32) |  | Token version. |
| nonce | [uint32](#uint32) |  | Random nonce to prevent collisions. |
| issuer | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Account that issued this token (who signed it). |
| subjects | [Target](#neo.fs.v2.session.Target) | repeated | Accounts authorized by this token (who can use it). Maximum number of subjects: 8. |
| lifetime | [TokenLifetime](#neo.fs.v2.session.TokenLifetime) |  | Lifetime of this token. |
| contexts | [SessionContextV2](#neo.fs.v2.session.SessionContextV2) | repeated | Unified session contexts for both object and container operations. Multiple contexts allow authorization for different combinations. Maximum number of contexts: 16. |
| final | [bool](#bool) |  | final is a flag indicating whether further delegation is allowed. If set to true, subjects of this token cannot delegate their rights further. |


<a name="neo.fs.v2.session.Target"></a>

### Message Target
Target account for SessionTokenV2.
It can be either direct (OwnerID) or indirect (NNS domain).


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Direct account reference via OwnerID (hash of verification script). |
| nns_name | [string](#string) |  | Indirect account reference via NeoFS Name Service. NNS name is a domain name that resolves to an OwnerID through the NeoFS Name Service. The name must be a valid DNS-like domain name (e.g., "example.neofs") that is registered in the NNS contract on the Neo blockchain. The NNS record should contain a string record with the corresponding OwnerID value in NEP-18 address format. |


<a name="neo.fs.v2.session.TokenLifetime"></a>

### Message TokenLifetime
Lifetime parameters of the token v2. Field names taken from rfc7519.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| exp | [uint64](#uint64) |  | Expiration, the last valid Unix timestamp. |
| nbf | [uint64](#uint64) |  | Not valid before, the first valid Unix timestamp. |
| iat | [uint64](#uint64) |  | Issued at, the Unix timestamp when the token was issued. |


<a name="neo.fs.v2.session.XHeader"></a>

### Message XHeader
Extended headers for Request/Response. They may contain any user-defined headers
to be interpreted on application level.

Key name must be a unique valid UTF-8 string. Value can't be empty. Requests or
Responses with duplicated header names or headers with empty values will be
considered invalid.

There are some "well-known" headers starting with `__NEOFS__` prefix that
affect system behaviour:

* __NEOFS__NETMAP_EPOCH \
  Netmap epoch to use for object placement calculation. The `value` is string
  encoded `uint64` in decimal presentation. If set to '0' or not set, the
  current epoch only will be used. DEPRECATED: header ignored by servers.
* __NEOFS__NETMAP_LOOKUP_DEPTH \
  If object can't be found using current epoch's netmap, this header limits
  how many past epochs the node can look up through. The `value` is string
  encoded `uint64` in decimal presentation. If set to '0' or not set, only the
  current epoch will be used. DEPRECATED: header ignored by servers.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | Key of the X-Header |
| value | [string](#string) |  | Value of the X-Header |

 <!-- end messages -->


<a name="neo.fs.v2.session.ContainerSessionContext.Verb"></a>

### ContainerSessionContext.Verb
Container request verbs

| Name | Number | Description |
| ---- | ------ | ----------- |
| VERB_UNSPECIFIED | 0 | Unknown verb |
| PUT | 1 | Refers to container.Put RPC call |
| DELETE | 2 | Refers to container.Delete RPC call |
| SETEACL | 3 | Refers to container.SetExtendedACL RPC call |
| SETATTRIBUTE | 4 | Refers to container.SetAttribute RPC call |
| REMOVEATTRIBUTE | 5 | Refers to container.RemoveAttribute RPC call |



<a name="neo.fs.v2.session.ObjectSessionContext.Verb"></a>

### ObjectSessionContext.Verb
Object request verbs

| Name | Number | Description |
| ---- | ------ | ----------- |
| VERB_UNSPECIFIED | 0 | Unknown verb |
| PUT | 1 | Refers to object.Put RPC call |
| GET | 2 | Refers to object.Get RPC call |
| HEAD | 3 | Refers to object.Head RPC call |
| SEARCH | 4 | Refers to object.Search RPC call |
| DELETE | 5 | Refers to object.Delete RPC call |
| RANGE | 6 | Refers to object.GetRange RPC call |
| RANGEHASH | 7 | Refers to object.GetRangeHash RPC call |



<a name="neo.fs.v2.session.Verb"></a>

### Verb
Verb represents all possible operations in NeoFS that can be authorized
via session tokens or delegation chains. This enum covers both object and
container service operations.

| Name | Number | Description |
| ---- | ------ | ----------- |
| VERB_UNSPECIFIED | 0 | Unknown verb |
| OBJECT_PUT | 1 | Refers to object.Put RPC call |
| OBJECT_GET | 2 | Refers to object.Get RPC call |
| OBJECT_HEAD | 3 | Refers to object.Head RPC call |
| OBJECT_SEARCH | 4 | Refers to object.Search RPC call |
| OBJECT_DELETE | 5 | Refers to object.Delete RPC call |
| OBJECT_RANGE | 6 | Refers to object.GetRange RPC call |
| OBJECT_RANGEHASH | 7 | Refers to object.GetRangeHash RPC call |
| CONTAINER_PUT | 8 | Refers to container.Put RPC call |
| CONTAINER_DELETE | 9 | Refers to container.Delete RPC call |
| CONTAINER_SETEACL | 10 | Refers to container.SetExtendedACL RPC call |
| CONTAINER_SETATTRIBUTE | 11 | Refers to container.SetAttribute RPC call |
| CONTAINER_REMOVEATTRIBUTE | 12 | Refers to container.RemoveAttribute RPC call |


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

