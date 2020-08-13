# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [service/meta.proto](#service/meta.proto)

  - Messages
    - [BearerToken](#neo.fs.v2.service.BearerToken)
    - [BearerToken.Body](#neo.fs.v2.service.BearerToken.Body)
    - [RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader)
    - [ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader)
    - [SessionToken](#neo.fs.v2.service.SessionToken)
    - [SessionToken.Body](#neo.fs.v2.service.SessionToken.Body)
    - [TokenLifetime](#neo.fs.v2.service.TokenLifetime)
    - [Version](#neo.fs.v2.service.Version)
    - [XHeader](#neo.fs.v2.service.XHeader)
    

- [service/verify.proto](#service/verify.proto)

  - Messages
    - [RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader)
    - [ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader)
    - [Signature](#neo.fs.v2.service.Signature)
    

- [Scalar Value Types](#scalar-value-types)



<a name="service/meta.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## service/meta.proto


 <!-- end services -->


<a name="neo.fs.v2.service.BearerToken"></a>

### Message BearerToken
BearerToken has information about request ACL rules with limited lifetime


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [BearerToken.Body](#neo.fs.v2.service.BearerToken.Body) |  | Bearer Token body |
| signature | [Signature](#neo.fs.v2.service.Signature) |  | Signature of BearerToken body |


<a name="neo.fs.v2.service.BearerToken.Body"></a>

### Message BearerToken.Body
Bearer Token body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| eacl_table | [neo.fs.v2.acl.EACLTable](#neo.fs.v2.acl.EACLTable) |  | EACLTable carries table of extended ACL rules |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | OwnerID carries identifier of the token owner |
| lifetime | [TokenLifetime](#neo.fs.v2.service.TokenLifetime) |  | Token expiration and valid time period parameters |


<a name="neo.fs.v2.service.RequestMetaHeader"></a>

### Message RequestMetaHeader
Information about the request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [Version](#neo.fs.v2.service.Version) |  | Client API version. |
| epoch | [uint64](#uint64) |  | Client local epoch number. Set to 0 if unknown. |
| ttl | [uint32](#uint32) |  | Maximum number of nodes in the request route. |
| x_headers | [XHeader](#neo.fs.v2.service.XHeader) | repeated | Request X-Headers. |
| session_token | [SessionToken](#neo.fs.v2.service.SessionToken) |  | Token is a token of the session within which the request is sent |
| bearer_token | [BearerToken](#neo.fs.v2.service.BearerToken) |  | Bearer is a Bearer token of the request |
| origin | [RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | RequestMetaHeader of the origin request. |


<a name="neo.fs.v2.service.ResponseMetaHeader"></a>

### Message ResponseMetaHeader
Information about the response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [Version](#neo.fs.v2.service.Version) |  | Server API version. |
| epoch | [uint64](#uint64) |  | Server local epoch number. |
| ttl | [uint32](#uint32) |  | Maximum number of nodes in the response route. |
| x_headers | [XHeader](#neo.fs.v2.service.XHeader) | repeated | Response X-Headers. |
| origin | [ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta header of the origin response. |


<a name="neo.fs.v2.service.SessionToken"></a>

### Message SessionToken
NeoFS session token.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [SessionToken.Body](#neo.fs.v2.service.SessionToken.Body) |  | Session Token body |
| signature | [Signature](#neo.fs.v2.service.Signature) |  | Signature is a signature of session token information |


<a name="neo.fs.v2.service.SessionToken.Body"></a>

### Message SessionToken.Body
Session token body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [bytes](#bytes) |  | ID is a token identifier. valid UUIDv4 represented in bytes |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | OwnerID carries identifier of the session initiator. |
| verb | [SessionToken.Body.Verb](#neo.fs.v2.service.SessionToken.Body.Verb) |  | Verb is a type of request for which the token is issued |
| lifetime | [TokenLifetime](#neo.fs.v2.service.TokenLifetime) |  | Lifetime is a lifetime of the session |
| session_key | [bytes](#bytes) |  | SessionKey is a public key of session key |
| object_address | [neo.fs.v2.refs.Address](#neo.fs.v2.refs.Address) |  | object_address represents the object session context. |


<a name="neo.fs.v2.service.TokenLifetime"></a>

### Message TokenLifetime
Lifetime parameters of the token. Filed names taken from rfc7519.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| exp | [uint64](#uint64) |  | Expiration Epoch |
| nbf | [uint64](#uint64) |  | Not valid before Epoch |
| iat | [uint64](#uint64) |  | Issued at Epoch |


<a name="neo.fs.v2.service.Version"></a>

### Message Version
Represents API version used by node.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| major | [uint32](#uint32) |  | Major API version. |
| minor | [uint32](#uint32) |  | Minor API version. |


<a name="neo.fs.v2.service.XHeader"></a>

### Message XHeader
Extended headers for Request/Response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | Key of the X-Header. |
| value | [string](#string) |  | Value of the X-Header. |

 <!-- end messages -->


<a name="neo.fs.v2.service.SessionToken.Body.Verb"></a>

### SessionToken.Body.Verb
Verb is an enumeration of session request types

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


 <!-- end enums -->



<a name="service/verify.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## service/verify.proto


 <!-- end services -->


<a name="neo.fs.v2.service.RequestVerificationHeader"></a>

### Message RequestVerificationHeader
Verification info for request signed by all intermediate nodes


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body_signature | [Signature](#neo.fs.v2.service.Signature) |  | Request Body signature. Should be generated once by request initiator. |
| meta_signature | [Signature](#neo.fs.v2.service.Signature) |  | Request Meta signature is added and signed by any intermediate node |
| origin_signature | [Signature](#neo.fs.v2.service.Signature) |  | Sign previous hops |
| origin | [RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Chain of previous hops signatures |


<a name="neo.fs.v2.service.ResponseVerificationHeader"></a>

### Message ResponseVerificationHeader
Verification info for response signed by all intermediate nodes


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body_signature | [Signature](#neo.fs.v2.service.Signature) |  | Response Body signature. Should be generated once by answering node. |
| meta_signature | [Signature](#neo.fs.v2.service.Signature) |  | Response Meta signature is added and signed by any intermediate node |
| origin_signature | [Signature](#neo.fs.v2.service.Signature) |  | Sign previous hops |
| origin | [ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Chain of previous hops signatures |


<a name="neo.fs.v2.service.Signature"></a>

### Message Signature
Signature of something in NeoFS


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [bytes](#bytes) |  | Public key used for signing. |
| sign | [bytes](#bytes) |  | Signature |

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

