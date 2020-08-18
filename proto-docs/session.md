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
    - [ObjectSessionContext](#neo.fs.v2.session.ObjectSessionContext)
    - [SessionToken](#neo.fs.v2.session.SessionToken)
    - [SessionToken.Body](#neo.fs.v2.session.SessionToken.Body)
    - [SessionToken.Body.TokenLifetime](#neo.fs.v2.session.SessionToken.Body.TokenLifetime)
    

- [Scalar Value Types](#scalar-value-types)



<a name="session/service.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## session/service.proto




<a name="neo.fs.v2.session.SessionService"></a>

### Service "neo.fs.v2.session.SessionService"
Create Session record on Node side

```
rpc Create(CreateRequest) returns (CreateResponse);

```

#### Method Create

Create opens new session between the client and the server.

| Name | Input | Output |
| ---- | ----- | ------ |
| Create | [CreateRequest](#neo.fs.v2.session.CreateRequest) | [CreateResponse](#neo.fs.v2.session.CreateResponse) |
 <!-- end services -->


<a name="neo.fs.v2.session.CreateRequest"></a>

### Message CreateRequest
CreateRequest carries an information necessary for opening a session.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [CreateRequest.Body](#neo.fs.v2.session.CreateRequest.Body) |  | Body of create session token request message. |
| meta_header | [neo.fs.v2.service.RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.session.CreateRequest.Body"></a>

### Message CreateRequest.Body
Request body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Carries an identifier of a session initiator. |
| expiration | [uint64](#uint64) |  | Expiration Epoch |


<a name="neo.fs.v2.session.CreateResponse"></a>

### Message CreateResponse
CreateResponse carries an information about the opened session.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [CreateResponse.Body](#neo.fs.v2.session.CreateResponse.Body) |  | Body of create session token response message. |
| meta_header | [neo.fs.v2.service.ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.service.ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.session.CreateResponse.Body"></a>

### Message CreateResponse.Body
Response body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [bytes](#bytes) |  | id carries an identifier of session token. |
| session_key | [bytes](#bytes) |  | session_key carries a session public key. |

 <!-- end messages -->

 <!-- end enums -->



<a name="session/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## session/types.proto


 <!-- end services -->


<a name="neo.fs.v2.session.ObjectSessionContext"></a>

### Message ObjectSessionContext
Context information for Session Tokens related to ObjectService requests


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| verb | [ObjectSessionContext.Verb](#neo.fs.v2.session.ObjectSessionContext.Verb) |  | Verb is a type of request for which the token is issued |
| address | [neo.fs.v2.refs.Address](#neo.fs.v2.refs.Address) |  | Related Object address |


<a name="neo.fs.v2.session.SessionToken"></a>

### Message SessionToken
NeoFS session token.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SessionToken.Body](#neo.fs.v2.session.SessionToken.Body) |  | Session Token body |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signature is a signature of session token information |


<a name="neo.fs.v2.session.SessionToken.Body"></a>

### Message SessionToken.Body
Session token body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [bytes](#bytes) |  | ID is a token identifier. valid UUIDv4 represented in bytes |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | OwnerID carries identifier of the session initiator. |
| lifetime | [SessionToken.Body.TokenLifetime](#neo.fs.v2.session.SessionToken.Body.TokenLifetime) |  | Lifetime is a lifetime of the session |
| session_key | [bytes](#bytes) |  | SessionKey is a public key of session key |
| object | [ObjectSessionContext](#neo.fs.v2.session.ObjectSessionContext) |  | ObjectService session context. |


<a name="neo.fs.v2.session.SessionToken.Body.TokenLifetime"></a>

### Message SessionToken.Body.TokenLifetime
Lifetime parameters of the token. Filed names taken from rfc7519.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| exp | [uint64](#uint64) |  | Expiration Epoch |
| nbf | [uint64](#uint64) |  | Not valid before Epoch |
| iat | [uint64](#uint64) |  | Issued at Epoch |

 <!-- end messages -->


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

