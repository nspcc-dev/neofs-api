# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [acl/types.proto](#acl/types.proto)

  - Messages
    - [BearerToken](#neo.fs.v2.acl.BearerToken)
    - [BearerToken.Body](#neo.fs.v2.acl.BearerToken.Body)
    - [BearerToken.Body.TokenLifetime](#neo.fs.v2.acl.BearerToken.Body.TokenLifetime)
    - [EACLRecord](#neo.fs.v2.acl.EACLRecord)
    - [EACLRecord.FilterInfo](#neo.fs.v2.acl.EACLRecord.FilterInfo)
    - [EACLRecord.TargetInfo](#neo.fs.v2.acl.EACLRecord.TargetInfo)
    - [EACLTable](#neo.fs.v2.acl.EACLTable)
    

- [Scalar Value Types](#scalar-value-types)



<a name="acl/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## acl/types.proto


 <!-- end services -->


<a name="neo.fs.v2.acl.BearerToken"></a>

### Message BearerToken
BearerToken has information about request ACL rules with limited lifetime


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [BearerToken.Body](#neo.fs.v2.acl.BearerToken.Body) |  | Bearer Token body |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signature of BearerToken body |


<a name="neo.fs.v2.acl.BearerToken.Body"></a>

### Message BearerToken.Body
Bearer Token body


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| eacl_table | [EACLTable](#neo.fs.v2.acl.EACLTable) |  | EACLTable carries table of extended ACL rules |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | OwnerID carries identifier of the token owner |
| lifetime | [BearerToken.Body.TokenLifetime](#neo.fs.v2.acl.BearerToken.Body.TokenLifetime) |  | Token expiration and valid time period parameters |


<a name="neo.fs.v2.acl.BearerToken.Body.TokenLifetime"></a>

### Message BearerToken.Body.TokenLifetime
Lifetime parameters of the token. Filed names taken from rfc7519.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| exp | [uint64](#uint64) |  | Expiration Epoch |
| nbf | [uint64](#uint64) |  | Not valid before Epoch |
| iat | [uint64](#uint64) |  | Issued at Epoch |


<a name="neo.fs.v2.acl.EACLRecord"></a>

### Message EACLRecord
EACLRecord groups information about extended ACL rule.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| operation | [Operation](#neo.fs.v2.acl.Operation) |  | Operation carries type of operation. |
| action | [Action](#neo.fs.v2.acl.Action) |  | Action carries ACL target action. |
| filters | [EACLRecord.FilterInfo](#neo.fs.v2.acl.EACLRecord.FilterInfo) | repeated | filters carries set of filters. |
| targets | [EACLRecord.TargetInfo](#neo.fs.v2.acl.EACLRecord.TargetInfo) | repeated | targets carries information about extended ACL target list. |


<a name="neo.fs.v2.acl.EACLRecord.FilterInfo"></a>

### Message EACLRecord.FilterInfo
FilterInfo groups information about filter.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| header | [HeaderType](#neo.fs.v2.acl.HeaderType) |  | Header carries type of header. |
| match_type | [MatchType](#neo.fs.v2.acl.MatchType) |  | MatchType carries type of match. |
| header_name | [string](#string) |  | header_name carries name of filtering header. |
| header_val | [string](#string) |  | header_val carries value of filtering header. |


<a name="neo.fs.v2.acl.EACLRecord.TargetInfo"></a>

### Message EACLRecord.TargetInfo
TargetInfo groups information about extended ACL target.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| target | [Target](#neo.fs.v2.acl.Target) |  | target carries target of ACL rule. |
| key_list | [bytes](#bytes) | repeated | key_list carries public keys of ACL target. |


<a name="neo.fs.v2.acl.EACLTable"></a>

### Message EACLTable
EACLRecord carries the information about extended ACL rules.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Carries identifier of the container that should use given access control rules. |
| records | [EACLRecord](#neo.fs.v2.acl.EACLRecord) | repeated | Records carries list of extended ACL rule records. |

 <!-- end messages -->


<a name="neo.fs.v2.acl.Action"></a>

### Action
Action is an enumeration of EACL actions.

| Name | Number | Description |
| ---- | ------ | ----------- |
| ACTION_UNSPECIFIED | 0 | Unspecified action, default value. |
| ALLOW | 1 | Allow action |
| DENY | 2 | Deny action |



<a name="neo.fs.v2.acl.HeaderType"></a>

### HeaderType
Header is an enumeration of filtering header types.

| Name | Number | Description |
| ---- | ------ | ----------- |
| HEADER_UNSPECIFIED | 0 | Unspecified header, default value. |
| REQUEST | 1 | Filter request headers |
| OBJECT | 2 | Filter object headers |



<a name="neo.fs.v2.acl.MatchType"></a>

### MatchType
MatchType is an enumeration of match types.

| Name | Number | Description |
| ---- | ------ | ----------- |
| MATCH_TYPE_UNSPECIFIED | 0 | Unspecified match type, default value. |
| STRING_EQUAL | 1 | Return true if strings are equal |
| STRING_NOT_EQUAL | 2 | Return true if strings are different |



<a name="neo.fs.v2.acl.Operation"></a>

### Operation
Operation is an enumeration of operation types.

| Name | Number | Description |
| ---- | ------ | ----------- |
| OPERATION_UNSPECIFIED | 0 | Unspecified operation, default value. |
| GET | 1 | Get |
| HEAD | 2 | Head |
| PUT | 3 | Put |
| DELETE | 4 | Delete |
| SEARCH | 5 | Search |
| GETRANGE | 6 | GetRange |
| GETRANGEHASH | 7 | GetRangeHash |



<a name="neo.fs.v2.acl.Target"></a>

### Target
Target of the access control rule in access control list.

| Name | Number | Description |
| ---- | ------ | ----------- |
| TARGET_UNSPECIFIED | 0 | Unspecified target, default value. |
| USER | 1 | User target rule is applied if sender is the owner of the container. |
| SYSTEM | 2 | System target rule is applied if sender is the storage node within the container or inner ring node. |
| OTHERS | 3 | Others target rule is applied if sender is not user or system target. |


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

