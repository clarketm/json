# [json](https://godoc.org/github.com/clarketm/json)
> Mirrors [golang/go](https://github.com/golang/go) [![Golang version](https://img.shields.io/badge/go-1.15-green)](https://github.com/golang/go/releases/tag/go1.15)

Drop-in replacement for Golang [`encoding/json`](https://golang.org/pkg/encoding/json/) with additional features.

## Installation
```shell
$ go get -u github.com/clarketm/json
```

## Usage
```diff
- import "encoding/json"
+ import "github.com/clarketm/json"
```
Same usage as Golang [`encoding/json`](https://golang.org/pkg/encoding/json/).

## Features
- Support zero values of structs with `omitempty`: [golang/go#11939](https://github.com/golang/go/issues/11939).
> If `omitempty` is applied to a struct and all the children of the struct are *empty*, then on marshalling it will be **omitted** from the encoded json.

## [Benchmarks](bench.txt)

```text
name                old time/op    new time/op    delta
EncodeMarshaler-16    45.1ns ± 9%    46.1ns ±10%   ~     (p=0.224 n=20+20)

name                old alloc/op   new alloc/op   delta
EncodeMarshaler-16     4.00B ± 0%     4.00B ± 0%   ~     (all equal)

name                old allocs/op  new allocs/op  delta
EncodeMarshaler-16      1.00 ± 0%      1.00 ± 0%   ~     (all equal)
```

## License
Refer to the [Golang](https://github.com/golang/go/blob/master/LICENSE) license. See [LICENSE](LICENSE) for more information.
