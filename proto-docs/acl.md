# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [acl/types.proto](#acl/types.proto)

  - Messages
    - [BearerToken](#neo.fs.v2.acl.BearerToken)
    - [BearerToken.Body](#neo.fs.v2.acl.BearerToken.Body)
    - [BearerToken.Body.TokenLifetime](#neo.fs.v2.acl.BearerToken.Body.TokenLifetime)
    - [EACLRecord](#neo.fs.v2.acl.EACLRecord)
    - [EACLRecord.Filter](#neo.fs.v2.acl.EACLRecord.Filter)
    - [EACLRecord.Target](#neo.fs.v2.acl.EACLRecord.Target)
    - [EACLTable](#neo.fs.v2.acl.EACLTable)
    

- [Scalar Value Types](#scalar-value-types)



<a name="acl/types.proto"></a>
<p align="right"><a href="#top">Top</a></p>

## acl/types.proto


 <!-- end services -->


<a name="neo.fs.v2.acl.BearerToken"></a>

### Message BearerToken
BearerToken allows to attach signed Extended ACL rules to the request in
`RequestMetaHeader`. If container's Basic ACL rules allow, the attached rule
set will be checked instead of one attached to the container itself. Just
like [JWT](https://jwt.io), it has a limited lifetime and scope, hence can be
used in the similar use cases, like providing authorisation to externally
authenticated party.

BearerToken can be issued only by the container's owner and must be signed using
the key associated with the container's `OwnerID`.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| body | [BearerToken.Body](#neo.fs.v2.acl.BearerToken.Body) |  | Bearer Token body |
| signature | [neo.fs.v2.refs.Signature](#neo.fs.v2.refs.Signature) |  | Signature of BearerToken body |


<a name="neo.fs.v2.acl.BearerToken.Body"></a>

### Message BearerToken.Body
Bearer Token body structure contains Extended ACL table issued by the container
owner with additional information preventing token abuse.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| eacl_table | [EACLTable](#neo.fs.v2.acl.EACLTable) |  | Table of Extended ACL rules to use instead of the ones attached to the container. If it contains `container_id` field, bearer token is only valid for this specific container. Otherwise, any container of the same owner is allowed. |
| owner_id | [neo.fs.v2.refs.OwnerID](#neo.fs.v2.refs.OwnerID) |  | `OwnerID` defines to whom the token was issued. It must match the request originator's `OwnerID`. If empty, any token bearer will be accepted. |
| lifetime | [BearerToken.Body.TokenLifetime](#neo.fs.v2.acl.BearerToken.Body.TokenLifetime) |  | Token expiration and valid time period parameters |


<a name="neo.fs.v2.acl.BearerToken.Body.TokenLifetime"></a>

### Message BearerToken.Body.TokenLifetime
Lifetime parameters of the token. Field names taken from
[rfc7519](https://tools.ietf.org/html/rfc7519).


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| exp | [uint64](#uint64) |  | Expiration Epoch |
| nbf | [uint64](#uint64) |  | Not valid before Epoch |
| iat | [uint64](#uint64) |  | Issued at Epoch |


<a name="neo.fs.v2.acl.EACLRecord"></a>

### Message EACLRecord
Describes a single eACL rule.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| operation | [Operation](#neo.fs.v2.acl.Operation) |  | NeoFS request Verb to match |
| action | [Action](#neo.fs.v2.acl.Action) |  | Rule execution result. Either allows or denies access if filters match. |
| filters | [EACLRecord.Filter](#neo.fs.v2.acl.EACLRecord.Filter) | repeated | List of filters to match and see if rule is applicable |
| targets | [EACLRecord.Target](#neo.fs.v2.acl.EACLRecord.Target) | repeated | List of target subjects to apply ACL rule to |


<a name="neo.fs.v2.acl.EACLRecord.Filter"></a>

### Message EACLRecord.Filter
Filter to check particular properties of the request or the object.

By default `key` field refers to the corresponding object's `Attribute`.
Some Object's header fields can also be accessed by adding `$Object:`
prefix to the name. Here is the list of fields available via this prefix:

* $Object:version \
  version
* $Object:objectID \
  object_id
* $Object:containerID \
  container_id
* $Object:ownerID \
  owner_id
* $Object:creationEpoch \
  creation_epoch
* $Object:payloadLength \
  payload_length
* $Object:payloadHash \
  payload_hash
* $Object:objectType \
  object_type
* $Object:homomorphicHash \
  homomorphic_hash

Please note, that if request or response does not have object's headers or
full object (Range, RangeHash, Search, Delete), it will not be possible to
filter by object header fields or user attributes. From the well-known list
only `$Object:objectID` and `$Object:containerID` will be available, as
it's possible to take that information from the requested address.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| header_type | [HeaderType](#neo.fs.v2.acl.HeaderType) |  | Define if Object or Request header will be used |
| match_type | [MatchType](#neo.fs.v2.acl.MatchType) |  | Match operation type |
| key | [string](#string) |  | Name of the Header to use |
| value | [string](#string) |  | Expected Header Value or pattern to match |


<a name="neo.fs.v2.acl.EACLRecord.Target"></a>

### Message EACLRecord.Target
Target to apply ACL rule. Can be a subject's role class or a list of public
keys to match.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| role | [Role](#neo.fs.v2.acl.Role) |  | Target subject's role class |
| keys | [bytes](#bytes) | repeated | List of public keys to identify target subject |


<a name="neo.fs.v2.acl.EACLTable"></a>

### Message EACLTable
Extended ACL rules table. A list of ACL rules defined additionally to Basic
ACL. Extended ACL rules can be attached to a container and can be updated
or may be defined in `BearerToken` structure. Please see the corresponding
NeoFS Technical Specification section for detailed description.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [neo.fs.v2.refs.Version](#neo.fs.v2.refs.Version) |  | eACL format version. Effectively, the version of API library used to create eACL Table. |
| container_id | [neo.fs.v2.refs.ContainerID](#neo.fs.v2.refs.ContainerID) |  | Identifier of the container that should use given access control rules |
| records | [EACLRecord](#neo.fs.v2.acl.EACLRecord) | repeated | List of Extended ACL rules |

 <!-- end messages -->


<a name="neo.fs.v2.acl.Action"></a>

### Action
Rule execution result action. Either allows or denies access if the rule's
filters match.

| Name | Number | Description |
| ---- | ------ | ----------- |
| ACTION_UNSPECIFIED | 0 | Unspecified action, default value |
| ALLOW | 1 | Allow action |
| DENY | 2 | Deny action |



<a name="neo.fs.v2.acl.HeaderType"></a>

### HeaderType
Enumeration of possible sources of Headers to apply filters.

| Name | Number | Description |
| ---- | ------ | ----------- |
| HEADER_UNSPECIFIED | 0 | Unspecified header, default value. |
| REQUEST | 1 | Filter request headers |
| OBJECT | 2 | Filter object headers |
| SERVICE | 3 | Filter service headers. These are not processed by NeoFS nodes and exist for service use only. |



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
Request's operation type to match if the rule is applicable to a particular
request.

| Name | Number | Description |
| ---- | ------ | ----------- |
| OPERATION_UNSPECIFIED | 0 | Unspecified operation, default value |
| GET | 1 | Get |
| HEAD | 2 | Head |
| PUT | 3 | Put |
| DELETE | 4 | Delete |
| SEARCH | 5 | Search |
| GETRANGE | 6 | GetRange |
| GETRANGEHASH | 7 | GetRangeHash |



<a name="neo.fs.v2.acl.Role"></a>

### Role
Target role of the access control rule in access control list.

| Name | Number | Description |
| ---- | ------ | ----------- |
| ROLE_UNSPECIFIED | 0 | Unspecified role, default value |
| USER | 1 | User target rule is applied if sender is the owner of the container |
| SYSTEM | 2 | System target rule is applied if sender is a storage node within the container or an inner ring node |
| OTHERS | 3 | Others target rule is applied if sender is neither a user nor a system target |


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

