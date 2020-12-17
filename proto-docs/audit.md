# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [audit/types.proto](#audit/types.proto)

  - Messages
    - [DataAuditResult](#neo.fs.v2.audit.DataAuditResult)
    

- [Scalar Value Types](#scalar-value-types)



<a name="audit/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## audit/types.proto


 <!-- end services -->


<a name="neo.fs.v2.audit.DataAuditResult"></a>

### Message DataAuditResult
DataAuditResult keeps record of conducted Data Audits. The detailed report is
generated separately.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | Data Audit Result format version. Effectively the version of API library used to report DataAuditResult structure. |
| audit_epoch | [fixed64](#fixed64) |  | Epoch number when the Data Audit was conducted |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Container under audit |
| public_key | [bytes](#bytes) |  | Public key of the auditing InnerRing node in a binary format |
| complete | [bool](#bool) |  | Shows if Data Audit process was complete in time or if it was cancelled |
| requests | [uint32](#uint32) |  | Number of request done at PoR stage |
| retries | [uint32](#uint32) |  | Number of retries done at PoR stage |
| pass_sg | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) | repeated | List of Storage Groups that passed audit PoR stage |
| fail_sg | [neo.fs.v2.refs.ObjectID](#neo.fs.v2.refs.ObjectID) | repeated | List of Storage Groups that failed audit PoR stage |
| hit | [uint32](#uint32) |  | Number of sampled objects under audit placed in an optimal way according to the containers placement policy when checking PoP |
| miss | [uint32](#uint32) |  | Number of sampled objects under audit placed in suboptimal way according to the containers placement policy, but still at a satisfactory level when checking PoP |
| fail | [uint32](#uint32) |  | Number of sampled objects under audit stored in a way not confirming placement policy or not found at all when checking PoP |
| pass_nodes | [bytes](#bytes) | repeated | List of storage node public keys that passed at least one PDP |
| fail_nodes | [bytes](#bytes) | repeated | List of storage node public keys that failed at least one PDP |

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

