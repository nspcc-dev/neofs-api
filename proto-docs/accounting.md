# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [accounting/service.proto](#accounting/service.proto)
 - Services
    - [AccountingService](#neo.fs.v2.accounting.AccountingService)
    
  - Messages
    - [BalanceRequest](#neo.fs.v2.accounting.BalanceRequest)
    - [BalanceRequest.Body](#neo.fs.v2.accounting.BalanceRequest.Body)
    - [BalanceResponse](#neo.fs.v2.accounting.BalanceResponse)
    - [BalanceResponse.Body](#neo.fs.v2.accounting.BalanceResponse.Body)
    

- [accounting/types.proto](#accounting/types.proto)

  - Messages
    - [Decimal](#neo.fs.v2.accounting.Decimal)
    

- [Scalar Value Types](#scalar-value-types)



<a name="accounting/service.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## accounting/service.proto




<a name="neo.fs.v2.accounting.AccountingService"></a>

### Service "neo.fs.v2.accounting.AccountingService"
Accounting service provides methods for interaction with NeoFS sidechain via
other NeoFS nodes to get information about the account balance. Deposit and
Withdraw operations can't be implemented here, as they require Mainnet NeoFS
smart contract invocation. Transfer operations between internal NeoFS
accounts are possible, if both use the same token type.

```
rpc Balance(BalanceRequest) returns (BalanceResponse);

```

#### Method Balance

Returns the amount of funds in GAS token for the requested NeoFS account.

| Name | Input | Output |
| ---- | ----- | ------ |
| Balance | [BalanceRequest](#neo.fs.v2.accounting.BalanceRequest) | [BalanceResponse](#neo.fs.v2.accounting.BalanceResponse) |
 <!-- end services -->


<a name="neo.fs.v2.accounting.BalanceRequest"></a>

### Message BalanceRequest
BalanceRequest message


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [BalanceRequest.Body](#neo.fs.v2.accounting.BalanceRequest.Body) |  | Body of the balance request message. |
| meta_header | [neo.fs.v2.session.RequestMetaHeader](#neo.fs.v2.session.RequestMetaHeader) |  | Carries request meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.RequestVerificationHeader](#neo.fs.v2.session.RequestVerificationHeader) |  | Carries request verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.accounting.BalanceRequest.Body"></a>

### Message BalanceRequest.Body
To indicate the account for which the balance is requested, it's identifier
is used. It can be any existing account in NeoFS sidechain `Balance` smart
contract. If omitted, client implementation MUST set it to the request's
signer `OwnerID`.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | Valid user identifier in `OwnerID` format for which the balance is requested. Required field. |


<a name="neo.fs.v2.accounting.BalanceResponse"></a>

### Message BalanceResponse
BalanceResponse message


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [BalanceResponse.Body](#neo.fs.v2.accounting.BalanceResponse.Body) |  | Body of the balance response message. |
| meta_header | [neo.fs.v2.session.ResponseMetaHeader](#neo.fs.v2.session.ResponseMetaHeader) |  | Carries response meta information. Header data is used only to regulate message transport and does not affect request execution. |
| verify_header | [neo.fs.v2.session.ResponseVerificationHeader](#neo.fs.v2.session.ResponseVerificationHeader) |  | Carries response verification information. This header is used to authenticate the nodes of the message route and check the correctness of transmission. |


<a name="neo.fs.v2.accounting.BalanceResponse.Body"></a>

### Message BalanceResponse.Body
The amount of funds in GAS token for the `OwnerID`'s account requested.
Balance is `Decimal` format to avoid precision issues with rounding.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| balance | [Decimal](#neo.fs.v2.accounting.Decimal) |  | Amount of funds in GAS token for the requested account. |

 <!-- end messages -->

 <!-- end enums -->



<a name="accounting/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## accounting/types.proto


 <!-- end services -->


<a name="neo.fs.v2.accounting.Decimal"></a>

### Message Decimal
Standard floating point data type can't be used in NeoFS due to inexactness
of the result when doing lots of small number operations. To solve the lost
precision issue, special `Decimal` format is used for monetary computations.

Please see [The General Decimal Arithmetic
Specification](http://speleotrove.com/decimal/) for detailed problem
description.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| value | [int64](#int64) |  | Number in smallest Token fractions. |
| precision | [uint32](#uint32) |  | Precision value indicating how many smallest fractions can be in one integer. |

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

