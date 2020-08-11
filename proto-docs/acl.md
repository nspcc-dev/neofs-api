# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [acl/types.proto](#acl/types.proto)

  - Messages
    - [EACLRecord](#acl.EACLRecord)
    - [EACLRecord.FilterInfo](#acl.EACLRecord.FilterInfo)
    - [EACLRecord.TargetInfo](#acl.EACLRecord.TargetInfo)
    - [EACLTable](#acl.EACLTable)
    

- [Scalar Value Types](#scalar-value-types)



<a name="acl/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## acl/types.proto


 <!-- end services -->


<a name="acl.EACLRecord"></a>

### Message EACLRecord
EACLRecord groups information about extended ACL rule.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| operation | [EACLRecord.Operation](#acl.EACLRecord.Operation) |  | Operation carries type of operation. |
| action | [EACLRecord.Action](#acl.EACLRecord.Action) |  | Action carries ACL target action. |
| filters | [EACLRecord.FilterInfo](#acl.EACLRecord.FilterInfo) | repeated | filters carries set of filters. |
| targets | [EACLRecord.TargetInfo](#acl.EACLRecord.TargetInfo) | repeated | targets carries information about extended ACL target list. |


<a name="acl.EACLRecord.FilterInfo"></a>

### Message EACLRecord.FilterInfo
FilterInfo groups information about filter.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| header | [EACLRecord.FilterInfo.Header](#acl.EACLRecord.FilterInfo.Header) |  | Header carries type of header. |
| match_type | [EACLRecord.FilterInfo.MatchType](#acl.EACLRecord.FilterInfo.MatchType) |  | MatchType carries type of match. |
| header_name | [string](#string) |  | header_name carries name of filtering header. |
| header_val | [string](#string) |  | header_val carries value of filtering header. |


<a name="acl.EACLRecord.TargetInfo"></a>

### Message EACLRecord.TargetInfo
TargetInfo groups information about extended ACL target.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| target | [Target](#acl.Target) |  | target carries target of ACL rule. |
| key_list | [bytes](#bytes) | repeated | key_list carries public keys of ACL target. |


<a name="acl.EACLTable"></a>

### Message EACLTable
EACLRecord carries the information about extended ACL rules.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| container_id | [refs.ContainerID](#refs.ContainerID) |  | Carries identifier of the container that should use given access control rules. |
| records | [EACLRecord](#acl.EACLRecord) | repeated | Records carries list of extended ACL rule records. |

 <!-- end messages -->


<a name="acl.EACLRecord.Action"></a>

### EACLRecord.Action
Action is an enumeration of EACL actions.

| Name | Number | Description |
| ---- | ------ | ----------- |
| ACTION_UNKNOWN | 0 |  |
| ALLOW | 1 |  |
| DENY | 2 |  |



<a name="acl.EACLRecord.FilterInfo.Header"></a>

### EACLRecord.FilterInfo.Header
Header is an enumeration of filtering header types.

| Name | Number | Description |
| ---- | ------ | ----------- |
| HEADER_UNKNOWN | 0 |  |
| REQUEST | 1 |  |
| OBJECT | 2 |  |



<a name="acl.EACLRecord.FilterInfo.MatchType"></a>

### EACLRecord.FilterInfo.MatchType
MatchType is an enumeration of match types.

| Name | Number | Description |
| ---- | ------ | ----------- |
| MATCH_UNKNOWN | 0 |  |
| STRING_EQUAL | 1 |  |
| STRING_NOT_EQUAL | 2 |  |



<a name="acl.EACLRecord.Operation"></a>

### EACLRecord.Operation
Operation is an enumeration of operation types.

| Name | Number | Description |
| ---- | ------ | ----------- |
| OPERATION_UNKNOWN | 0 |  |
| GET | 1 |  |
| HEAD | 2 |  |
| PUT | 3 |  |
| DELETE | 4 |  |
| SEARCH | 5 |  |
| GETRANGE | 6 |  |
| GETRANGEHASH | 7 |  |



<a name="acl.Target"></a>

### Target
Target of the access control rule in access control list.

| Name | Number | Description |
| ---- | ------ | ----------- |
| UNKNOWN | 0 | Unknown target, default value. |
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

