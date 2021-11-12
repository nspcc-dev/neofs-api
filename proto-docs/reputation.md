# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [reputation/service.proto](#reputation/service.proto)
 - Services
    - [ReputationService](#neo.fs.v2.reputation.ReputationService)
    
  - Messages
    - [AnnounceIntermediateResultRequest](#neo.fs.v2.reputation.AnnounceIntermediateResultRequest)
    - [AnnounceIntermediateResultRequest.Body](#neo.fs.v2.reputation.AnnounceIntermediateResultRequest.Body)
    - [AnnounceIntermediateResultResponse](#neo.fs.v2.reputation.AnnounceIntermediateResultResponse)
    - [AnnounceIntermediateResultResponse.Body](#neo.fs.v2.reputation.AnnounceIntermediateResultResponse.Body)
    - [AnnounceLocalTrustRequest](#neo.fs.v2.reputation.AnnounceLocalTrustRequest)
    - [AnnounceLocalTrustRequest.Body](#neo.fs.v2.reputation.AnnounceLocalTrustRequest.Body)
    - [AnnounceLocalTrustResponse](#neo.fs.v2.reputation.AnnounceLocalTrustResponse)
    - [AnnounceLocalTrustResponse.Body](#neo.fs.v2.reputation.AnnounceLocalTrustResponse.Body)
    

- [reputation/types.proto](#reputation/types.proto)

  - Messages
    - [GlobalTrust](#neo.fs.v2.reputation.GlobalTrust)
    - [GlobalTrust.Body](#neo.fs.v2.reputation.GlobalTrust.Body)
    - [PeerID](#neo.fs.v2.reputation.PeerID)
    - [PeerToPeerTrust](#neo.fs.v2.reputation.PeerToPeerTrust)
    - [Trust](#neo.fs.v2.reputation.Trust)
    

- [Scalar Value Types](#scalar-value-types)



<a name="reputation/service.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## reputation/service.proto




<a name="neo.fs.v2.reputation.ReputationService"></a>

### Service "neo.fs.v2.reputation.ReputationService"
`ReputationService` provides mechanisms for exchanging trust values with
other NeoFS nodes. Nodes rate each other's reputation based on how good they
process requests and set a trust level based on that rating. The trust
information is passed to the next nodes to check and aggregate unless the
final result is recorded.

```
rpc AnnounceLocalTrust(AnnounceLocalTrustRequest) returns (AnnounceLocalTrustResponse);
rpc AnnounceIntermediateResult(AnnounceIntermediateResultRequest) returns (AnnounceIntermediateResultResponse);

```

#### Method AnnounceLocalTrust

Announce local client trust information to any node in NeoFS network.

Statuses:
- **OK** (0, SECTION_SUCCESS):
local trust has been successfully announced;
- Common failures (SECTION_FAILURE_COMMON).

| Name | Input | Output |
| ---- | ----- | ------ |
| AnnounceLocalTrust | [AnnounceLocalTrustRequest](#neo.fs.v2.reputation.AnnounceLocalTrustRequest) | [AnnounceLocalTrustResponse](#neo.fs.v2.reputation.AnnounceLocalTrustResponse) |
#### Method AnnounceIntermediateResult

Announces the intermediate result of the iterative algorithm for
calculating the global reputation of the node in NeoFS network.

Statuses:
- **OK** (0, SECTION_SUCCESS):
intermediate trust estimation has been successfully announced;
- Common failures (SECTION_FAILURE_COMMON).

| Name | Input | Output |
| ---- | ----- | ------ |
| AnnounceIntermediateResult | [AnnounceIntermediateResultRequest](#neo.fs.v2.reputation.AnnounceIntermediateResultRequest) | [AnnounceIntermediateResultResponse](#neo.fs.v2.reputation.AnnounceIntermediateResultResponse) |
 <!-- end services -->


<a name="neo.fs.v2.reputation.AnnounceIntermediateResultRequest"></a>

### Message AnnounceIntermediateResultRequest
Announce intermediate global trust information.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [AnnounceIntermediateResultRequest.Body](#neo.fs.v2.reputation.AnnounceIntermediateResultRequest.Body) |  | Body of the request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.reputation.AnnounceIntermediateResultRequest.Body"></a>

### Message AnnounceIntermediateResultRequest.Body
Announce intermediate global trust information.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| epoch | [uint64](#uint64) |  | Iteration execution Epoch number |
| iteration | [uint32](#uint32) |  | Iteration sequence number |
| trust | [PeerToPeerTrust](#neo.fs.v2.reputation.PeerToPeerTrust) |  | Current global trust value calculated at the specified iteration |


<a name="neo.fs.v2.reputation.AnnounceIntermediateResultResponse"></a>

### Message AnnounceIntermediateResultResponse
Intermediate global trust information announce response.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [AnnounceIntermediateResultResponse.Body](#neo.fs.v2.reputation.AnnounceIntermediateResultResponse.Body) |  | Body of the response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.reputation.AnnounceIntermediateResultResponse.Body"></a>

### Message AnnounceIntermediateResultResponse.Body
Response to the node's intermediate global trust information announce has
an empty body because the trust exchange operation is asynchronous. If
Trust information will not pass sanity checks it is silently ignored.



<a name="neo.fs.v2.reputation.AnnounceLocalTrustRequest"></a>

### Message AnnounceLocalTrustRequest
Announce node's local trust information.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [AnnounceLocalTrustRequest.Body](#neo.fs.v2.reputation.AnnounceLocalTrustRequest.Body) |  | Body of the request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.reputation.AnnounceLocalTrustRequest.Body"></a>

### Message AnnounceLocalTrustRequest.Body
Announce node's local trust information.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| epoch | [uint64](#uint64) |  | Trust assessment Epoch number |
| trusts | [Trust](#neo.fs.v2.reputation.Trust) | repeated | List of normalized local trust values to other NeoFS nodes. The value is calculated according to EigenTrust++ algorithm and must be a floating point number in the [0;1] range. |


<a name="neo.fs.v2.reputation.AnnounceLocalTrustResponse"></a>

### Message AnnounceLocalTrustResponse
Node's local trust information announce response.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [AnnounceLocalTrustResponse.Body](#neo.fs.v2.reputation.AnnounceLocalTrustResponse.Body) |  | Body of the response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.reputation.AnnounceLocalTrustResponse.Body"></a>

### Message AnnounceLocalTrustResponse.Body
Response to the node's local trust information announce has an empty body
because the trust exchange operation is asynchronous. If Trust information
will not pass sanity checks it is silently ignored.


 <!-- end messages -->

 <!-- end enums -->



<a name="reputation/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## reputation/types.proto


 <!-- end services -->


<a name="neo.fs.v2.reputation.GlobalTrust"></a>

### Message GlobalTrust
Global trust level to NeoFS node.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Message format version. Effectively the version of API library used to create the message. |
| body | [GlobalTrust.Body](#neo.fs.v2.reputation.GlobalTrust.Body) |  | Message body |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signature of the binary `body` field by the manager. |


<a name="neo.fs.v2.reputation.GlobalTrust.Body"></a>

### Message GlobalTrust.Body
Message body structure.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| manager | [PeerID](#neo.fs.v2.reputation.PeerID) |  | Node manager ID |
| trust | [Trust](#neo.fs.v2.reputation.Trust) |  | Global trust level |


<a name="neo.fs.v2.reputation.PeerID"></a>

### Message PeerID
NeoFS unique peer identifier is 33 byte long compressed public key of the
node, the same as the one stored in the network map.

String presentation is
[base58](https://tools.ietf.org/html/draft-msporny-base58-02) encoded string.

JSON value will be the data encoded as a string using standard base64
encoding with paddings. Either
[standard](https://tools.ietf.org/html/rfc4648#section-4) or
[URL-safe](https://tools.ietf.org/html/rfc4648#section-5) base64 encoding
with/without paddings are accepted.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| public_key | [bytes](#bytes) |  | Peer node's public key |


<a name="neo.fs.v2.reputation.PeerToPeerTrust"></a>

### Message PeerToPeerTrust
Trust level of a peer to a peer.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| trusting_peer | [PeerID](#neo.fs.v2.reputation.PeerID) |  | Identifier of the trusting peer |
| trust | [Trust](#neo.fs.v2.reputation.Trust) |  | Trust level |


<a name="neo.fs.v2.reputation.Trust"></a>

### Message Trust
Trust level to a NeoFS network peer.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| peer | [PeerID](#neo.fs.v2.reputation.PeerID) |  | Identifier of the trusted peer |
| value | [double](#double) |  | Trust level in [0:1] range |

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

