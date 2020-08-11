# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [service/meta.proto](#service/meta.proto)

  - Messages
    - [RequestMetaHeader](#service.RequestMetaHeader)
    - [RequestMetaHeader.XHeader](#service.RequestMetaHeader.XHeader)
    - [Version](#service.Version)
    

- [service/verify.proto](#service/verify.proto)

  - Messages
    - [BearerTokenMsg](#service.BearerTokenMsg)
    - [BearerTokenMsg.Info](#service.BearerTokenMsg.Info)
    - [RequestVerificationHeader](#service.RequestVerificationHeader)
    - [SessionToken](#service.SessionToken)
    - [SessionToken.Info](#service.SessionToken.Info)
    - [Signature](#service.Signature)
    - [TokenLifetime](#service.TokenLifetime)
    

- [Scalar Value Types](#scalar-value-types)



<a name="service/meta.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## service/meta.proto


 <!-- end services -->


<a name="service.RequestMetaHeader"></a>

### Message RequestMetaHeader
RequestMetaHeader contains information about request meta headers.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| ttl | [uint32](#uint32) |  | Carries maximum number of nodes in the request route. |
| x_headers | [RequestMetaHeader.XHeader](#service.RequestMetaHeader.XHeader) | repeated | Carries request X-Headers. |


<a name="service.RequestMetaHeader.XHeader"></a>

### Message RequestMetaHeader.XHeader



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | Carries key to the X-Header. |
| value | [string](#string) |  | Carries value of the X-Header. |


<a name="service.Version"></a>

### Message Version
Represents API version used by node.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| major | [uint32](#uint32) |  | Major API version. |
| minor | [uint32](#uint32) |  | Minor API version. |

 <!-- end messages -->

 <!-- end enums -->



<a name="service/verify.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## service/verify.proto


 <!-- end services -->


<a name="service.BearerTokenMsg"></a>

### Message BearerTokenMsg
BearerTokenMsg carries information about request ACL rules with limited lifetime


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| token_info | [BearerTokenMsg.Info](#service.BearerTokenMsg.Info) |  | token_info is a grouped information about token |
| owner_key | [bytes](#bytes) |  | owner_key is a public key of the token owner |
| signature | [bytes](#bytes) |  | Signature is a signature of token information |


<a name="service.BearerTokenMsg.Info"></a>

### Message BearerTokenMsg.Info



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| eacl_table | [acl.EACLTable](#acl.EACLTable) |  | EACLTable carries table of extended ACL rules. |
| owner_id | [refs.OwnerID](#refs.OwnerID) |  | OwnerID carries identifier of the token owner. |
| valid_until | [uint64](#uint64) |  | ValidUntil carries a last epoch of token lifetime |


<a name="service.RequestVerificationHeader"></a>

### Message RequestVerificationHeader
RequestVerificationHeader is a set of signatures of every NeoFS Node that
processed request.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| signatures | [Signature](#service.Signature) | repeated | Signatures is a set of signatures of every passed NeoFS Node |
| token | [SessionToken](#service.SessionToken) |  | Token is a token of the session within which the request is sent |
| bearer | [BearerTokenMsg](#service.BearerTokenMsg) |  | Bearer is a Bearer token of the request |


<a name="service.SessionToken"></a>

### Message SessionToken
Represents the NeoFS session token.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| token_info | [SessionToken.Info](#service.SessionToken.Info) |  | token_info is a grouped information about token |
| signature | [bytes](#bytes) |  | Signature is a signature of session token information |


<a name="service.SessionToken.Info"></a>

### Message SessionToken.Info



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [bytes](#bytes) |  | ID is a token identifier. valid UUIDv4 represented in bytes |
| owner_id | [refs.OwnerID](#refs.OwnerID) |  | OwnerID carries identifier of the session initiator. |
| verb | [SessionToken.Info.Verb](#service.SessionToken.Info.Verb) |  | Verb is a type of request for which the token is issued |
| lifetime | [TokenLifetime](#service.TokenLifetime) |  | Lifetime is a lifetime of the session |
| session_key | [bytes](#bytes) |  | SessionKey is a public key of session key |
| owner_key | [bytes](#bytes) |  | OwnerKey is a public key of the token owner |
| object_address | [refs.Address](#refs.Address) |  | object_address represents the object session context. |


<a name="service.Signature"></a>

### Message Signature



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [bytes](#bytes) |  | Public key used for signing. |
| sign | [bytes](#bytes) |  | Signature |


<a name="service.TokenLifetime"></a>

### Message TokenLifetime
TokenLifetime carries a group of lifetime parameters of the token


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| created | [uint64](#uint64) |  | created carries an initial epoch of token lifetime |
| valid_until | [uint64](#uint64) |  | valid_until carries a last epoch of token lifetime |

 <!-- end messages -->


<a name="service.SessionToken.Info.Verb"></a>

### SessionToken.Info.Verb
Verb is an enumeration of session request types

| Name | Number | Description |
| ---- | ------ | ----------- |
| OBJECT_PUT | 0 | Refers to object.Put RPC call |
| OBJECT_GET | 1 | Refers to object.Get RPC call |
| OBJECT_HEAD | 2 | Refers to object.Head RPC call |
| OBJECT_SEARCH | 3 | Refers to object.Search RPC call |
| OBJECT_DELETE | 4 | Refers to object.Delete RPC call |
| OBJECT_RANGE | 5 | Refers to object.GetRange RPC call |
| OBJECT_RANGEHASH | 6 | Refers to object.GetRangeHash RPC call |


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

