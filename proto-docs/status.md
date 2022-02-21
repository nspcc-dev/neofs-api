# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [status/types.proto](#status/types.proto)

  - Messages
    - [Status](#neo.fs.v2.status.Status)
    - [Status.Detail](#neo.fs.v2.status.Status.Detail)
    

- [Scalar Value Types](#scalar-value-types)



<a name="status/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## status/types.proto


 <!-- end services -->


<a name="neo.fs.v2.status.Status"></a>

### Message Status
Declares the general format of the status returns of the NeoFS RPC protocol.
Status is present in all response messages. Each RPC of NeoFS protocol
describes the possible outcomes and details of the operation.

Each status is assigned a one-to-one numeric code. Any unique result of an
operation in NeoFS is unambiguously associated with the code value.

Numerical set of codes is split into 1024-element sections. An enumeration
is defined for each section. Values can be referred to in the following ways:

* numerical value ranging from 0 to 4,294,967,295 (global code);

* values from enumeration (local code). The formula for the ratio of the
  local code (`L`) of a defined section (`S`) to the global one (`G`):
  `G = 1024 * S + L`.

All outcomes are divided into successful and failed, which corresponds
to the success or failure of the operation. The definition of success
follows from the semantics of RPC and the description of its purpose.
The server must not attach code that is the opposite of outcome type.

See the set of return codes in the description for calls.

Each status can carry developer-facing error message. It should be human
readable text in English. The server should not transmit (and the client
should not expect) useful information in the message. Field `details`
should make the return more detailed.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| code | [uint32](#uint32) |  | The status code |
| message | [string](#string) |  | Developer-facing error message |
| details | [Status.Detail](#neo.fs.v2.status.Status.Detail) | repeated | Data detailing the outcome of the operation. Must be unique by ID. |


<a name="neo.fs.v2.status.Status.Detail"></a>

### Message Status.Detail
Return detail. It contains additional information that can be used to
analyze the response. Each code defines a set of details that can be
attached to a status. Client should not handle details that are not
covered by the code.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [uint32](#uint32) |  | Detail ID. The identifier is required to determine the binary format of the detail and how to decode it. |
| value | [bytes](#bytes) |  | Binary status detail. Must follow the format associated with ID. The possibility of missing a value must be explicitly allowed. |

 <!-- end messages -->


<a name="neo.fs.v2.status.CommonFail"></a>

### CommonFail
Section of failed statuses independent of the operation.

| Name | Number | Description |
| ---- | ------ | ----------- |
| INTERNAL | 0 | [**1024**] Internal server error, default failure. Not detailed. If the server cannot match failed outcome to the code, it should use this code. |
| WRONG_MAGIC_NUMBER | 1 | [**1025**] Wrong magic of the NeoFS network. Details: - [**0**] Magic number of the served NeoFS network (big-endian 64-bit unsigned integer). |



<a name="neo.fs.v2.status.Container"></a>

### Container
Section of statuses for container-related operations.

| Name | Number | Description |
| ---- | ------ | ----------- |
| CONTAINER_NOT_FOUND | 0 | [**3072**] Container not found. |



<a name="neo.fs.v2.status.Object"></a>

### Object
Section of statuses for object-related operations.

| Name | Number | Description |
| ---- | ------ | ----------- |
| ACCESS_DENIED | 0 | [**2048**] Access denied by ACL. Details: - [**0**] Human-readable description (UTF-8 encoded string). |
| OBJECT_NOT_FOUND | 1 | [**2049**] Object not found. |
| LOCKED | 2 | [**2050**] Operation rejected by the object lock. |
| LOCK_NON_REGULAR_OBJECT | 3 | [**2051**] Locking an object with a non-REGULAR type rejected. |
| OBJECT_ALREADY_REMOVED | 4 | [**2052**] Object has been marked deleted. |



<a name="neo.fs.v2.status.Section"></a>

### Section
Section identifiers.

| Name | Number | Description |
| ---- | ------ | ----------- |
| SECTION_SUCCESS | 0 | Successful return codes. |
| SECTION_FAILURE_COMMON | 1 | Failure codes regardless of the operation. |
| SECTION_OBJECT | 2 | Object service-specific errors. |
| SECTION_CONTAINER | 3 | Container service-specific errors. |
| SECTION_SESSION | 4 | Session service-specific errors. |



<a name="neo.fs.v2.status.Session"></a>

### Session
Section of statuses for session-related operations.

| Name | Number | Description |
| ---- | ------ | ----------- |
| TOKEN_NOT_FOUND | 0 | [**4096**] Token not found. |
| TOKEN_EXPIRED | 1 | [**4097**] Token has expired. |



<a name="neo.fs.v2.status.Success"></a>

### Success
Section of NeoFS successful return codes.

| Name | Number | Description |
| ---- | ------ | ----------- |
| OK | 0 | [**0**] Default success. Not detailed. If the server cannot match successful outcome to the code, it should use this code. |


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

