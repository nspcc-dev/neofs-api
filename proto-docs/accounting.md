# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [accounting/service.proto](#accounting/service.proto)
 - Services
    - [Accounting](#accounting.Accounting)
    
  - Messages
    - [BalanceRequest](#accounting.BalanceRequest)
    - [BalanceResponse](#accounting.BalanceResponse)
    - [Decimal](#accounting.Decimal)
    

- [Scalar Value Types](#scalar-value-types)



<a name="accounting/service.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## accounting/service.proto




<a name="accounting.Accounting"></a>

### Service "accounting.Accounting"
The service provides methods for obtaining information
about the account balance in NeoFS system.

```
rpc Balance(BalanceRequest) returns (BalanceResponse);

```

#### Method Balance

Returns the amount of funds for the requested NeoFS account.

| Name | Input | Output |
| ---- | ----- | ------ |
| Balance | [BalanceRequest](#accounting.BalanceRequest) | [BalanceResponse](#accounting.BalanceResponse) |
 <!-- end services -->


<a name="accounting.BalanceRequest"></a>

### Message BalanceRequest
Message defines the request body of Balance method.

To indicate the account for which the balance is requested, it's identifier is used.

To gain access to the requested information, the request body must be formed according
to the requirements from the system specification.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| owner_id | [refs.OwnerID](#refs.OwnerID) |  | Carries user identifier in NeoFS system for which the balance is requested. |
| meta_header | [service.RequestMetaHeader](#service.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [service.RequestVerificationHeader](#service.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="accounting.BalanceResponse"></a>

### Message BalanceResponse
Message defines the response body of Balance method.

The amount of funds is calculated in decimal numbers.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| balance | [Decimal](#accounting.Decimal) |  | Carries the amount of funds on the account. |


<a name="accounting.Decimal"></a>

### Message Decimal
Decimal represents the decimal numbers.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| value | [int64](#int64) |  | value carries number value. |
| precision | [uint32](#uint32) |  | precision carries value precision. |

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

