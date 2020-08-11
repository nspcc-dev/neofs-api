# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [session/service.proto](#session/service.proto)
 - Services
    - [Session](#session.Session)
    
  - Messages
    - [CreateRequest](#session.CreateRequest)
    - [CreateRequest.Body](#session.CreateRequest.Body)
    - [CreateResponse](#session.CreateResponse)
    - [CreateResponse.Body](#session.CreateResponse.Body)
    

- [Scalar Value Types](#scalar-value-types)



<a name="session/service.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## session/service.proto




<a name="session.Session"></a>

### Service "session.Session"


```
rpc Create(CreateRequest) returns (CreateResponse);

```

#### Method Create

Create opens new session between the client and the server.

| Name | Input | Output |
| ---- | ----- | ------ |
| Create | [CreateRequest](#session.CreateRequest) | [CreateResponse](#session.CreateResponse) |
 <!-- end services -->


<a name="session.CreateRequest"></a>

### Message CreateRequest
CreateRequest carries an information necessary for opening a session.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [CreateRequest.Body](#session.CreateRequest.Body) |  | Body of create session token request message. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="session.CreateRequest.Body"></a>

### Message CreateRequest.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| owner_id | [refs.OwnerID](#refs.OwnerID) |  | Carries an identifier of a session initiator. |
| lifetime | [service.TokenLifetime](#service.TokenLifetime) |  | Carries a lifetime of the session. |


<a name="session.CreateResponse"></a>

### Message CreateResponse
CreateResponse carries an information about the opened session.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [CreateResponse.Body](#session.CreateResponse.Body) |  | Body of create session token response message. |
| meta_header | [service.ResponseMetaHeader](#service.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.ResponseVerificationHeader](#service.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="session.CreateResponse.Body"></a>

### Message CreateResponse.Body



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [bytes](#bytes) |  | id carries an identifier of session token. |
| session_key | [bytes](#bytes) |  | session_key carries a session public key. |

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

