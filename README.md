# NeoFS-API

NeoFS-API repository contains language-agnostic 
[protocol buffers](https://developers.google.com/protocol-buffers) definitions
of neofs-node structures and services. 

## Description

NeoFS-API repository is the basis for language-specific libraries, e.g.:

- [neofs-api-go](https://github.com/nspcc-dev/neofs-api-go)
- [neofs-api-csharp](https://github.com/nspcc-dev/neofs-api-csharp)

These libraries contain compiled protocol buffers code, defined in this
repository. Use them to integrate applications with NeoFS.

This repository contains:

- 11 protocol buffers packages,
- [auto-generated docs](proto-docs) for protocol buffers,
- [manually written docs](docs) for developers (to be done). 


### Protocol packages

#### Accounting

Accounting package defines services and structures for balance request and 
`cheque` operations.

See:

- [Accounting service](proto-docs/accounting.md#accounting.Accounting)
- [Withdraw service](proto-docs/accounting.md#accounting.Withdraw)


#### Bootstrap

Bootstrap package defines bootstrap service that connects storage nodes
to the network. 

See:

- [Bootstrap service](proto-docs/bootstrap.md#bootstrap.Bootstrap)


#### Container

Container package defines service and structure of containers. NeoFS stores
objects within the registered container according to a specified storage policy.

See:

- [Container service](proto-docs/container.md#container.Service)

#### Object

Object is the storage unit in NeoFS. Object package defines structure of the
object and service requests.

See:

- [Object service](proto-docs/object.md#object.Service)

#### Query

Query package defines structure for object search requests. 

#### Refs

Refs package defines identity types: object id, container id, etc.

#### Service

Service package defines utility structures for all public API requests: 
TTL, request signature, etc.

#### Session

Session package defines service and structures to setup session between
the node and the client. Session token is required in some object service
requests. Node uses session private key to re-sign new objects and requests.

See:

- [Session service](proto-docs/session.md#session.Session)

#### State

State package defines service and structures for metrics gathering. 

See:

- [Status service](proto-docs/state.md#state.Status)

#### StorageGroup

Storagegroup package defines structure that contains meta data for data audit. 
This meta data stored as a header in the NeoFS object.


## License

This project is licensed under the GPLv3 License - 
see the [LICENSE.md](LICENSE.md) file for details
