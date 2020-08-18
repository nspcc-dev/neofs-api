# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [service/types.proto](#service/types.proto)

  - Messages
    - [RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader)
    - [RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader)
    - [ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader)
    - [ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader)
    - [XHeader](#neo.fs.v2.service.XHeader)
    

- [Scalar Value Types](#scalar-value-types)



<a name="service/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## service/types.proto


 <!-- end services -->


<a name="neo.fs.v2.service.RequestMetaHeader"></a>

### Message RequestMetaHeader
Information about the request


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Client API version. |
| epoch | [uint64](#uint64) |  | Client local epoch number. Set to 0 if unknown. |
| ttl | [uint32](#uint32) |  | Maximum number of nodes in the request route. |
| x_headers | [XHeader](#neo.fs.v2.service.XHeader) | repeated | Request X-Headers. |
| session_token | [neo.fs.v2.session.SessionToken](#neo.fs.v2.session.SessionToken) |  | Token is a token of the session within which the request is sent |
| bearer_token | [neo.fs.v2.acl.BearerToken](#neo.fs.v2.acl.BearerToken) |  | Bearer is a Bearer token of the request |
| origin | [RequestMetaHeader](#neo.fs.v2.service.RequestMetaHeader) |  | RequestMetaHeader of the origin request. |


<a name="neo.fs.v2.service.RequestVerificationHeader"></a>

### Message RequestVerificationHeader
Verification info for request signed by all intermediate nodes


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Request Body signature. Should be generated once by request initiator. |
| meta_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Request Meta signature is added and signed by any intermediate node |
| origin_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Sign previous hops |
| origin | [RequestVerificationHeader](#neo.fs.v2.service.RequestVerificationHeader) |  | Chain of previous hops signatures |


<a name="neo.fs.v2.service.ResponseMetaHeader"></a>

### Message ResponseMetaHeader
Information about the response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Server API version. |
| epoch | [uint64](#uint64) |  | Server local epoch number. |
| ttl | [uint32](#uint32) |  | Maximum number of nodes in the response route. |
| x_headers | [XHeader](#neo.fs.v2.service.XHeader) | repeated | Response X-Headers. |
| origin | [ResponseMetaHeader](#neo.fs.v2.service.ResponseMetaHeader) |  | Carries response meta header of the origin response. |


<a name="neo.fs.v2.service.ResponseVerificationHeader"></a>

### Message ResponseVerificationHeader
Verification info for response signed by all intermediate nodes


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Response Body signature. Should be generated once by answering node. |
| meta_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Response Meta signature is added and signed by any intermediate node |
| origin_signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Sign previous hops |
| origin | [ResponseVerificationHeader](#neo.fs.v2.service.ResponseVerificationHeader) |  | Chain of previous hops signatures |


<a name="neo.fs.v2.service.XHeader"></a>

### Message XHeader
Extended headers for Request/Response


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | Key of the X-Header. |
| value | [string](#string) |  | Value of the X-Header. |

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

