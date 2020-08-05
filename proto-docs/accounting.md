# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [accounting/service.proto](#accounting/service.proto)
 - Services
    - [Accounting](#accounting.Accounting)
    
  - Messages
    - [BalanceRequest](#accounting.BalanceRequest)
    - [BalanceResponse](#accounting.BalanceResponse)
    

- [Scalar Value Types](#scalar-value-types)



<a name="accounting/service.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## accounting/service.proto




<a name="accounting.Accounting"></a>

### Service "accounting.Accounting"
Accounting is a service that provides access for accounting balance
information

```
rpc Balance(BalanceRequest) returns (BalanceResponse);

```

#### Method Balance

Balance returns current balance status of the NeoFS user

| Name | Input | Output |
| ---- | ----- | ------ |
| Balance | [BalanceRequest](#accounting.BalanceRequest) | [BalanceResponse](#accounting.BalanceResponse) |
 <!-- end services -->


<a name="accounting.BalanceRequest"></a>

### Message BalanceRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| OwnerID | [refs.OwnerID](#refs.OwnerID) |  | OwnerID carries user identifier in NeoFS system. |
| Meta | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | RequestMetaHeader contains information about request meta headers (should be embedded into message) |
| Verify | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | RequestVerificationHeader is a set of signatures of every NeoFS Node that processed request (should be embedded into message) |


<a name="accounting.BalanceResponse"></a>

### Message BalanceResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| Balance | [decimal.Decimal](#decimal.Decimal) |  | Balance contains current account balance state |

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

