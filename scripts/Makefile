
GOPATH = $(abspath .)

all: bin/fragass bin/downloadfrag

bin/fragass: src/guengel.ch/fragass/fragass.go
	env GOPATH=$(GOPATH) go install guengel.ch/fragass

bin/downloadfrag: src/guengel.ch/downloadfrag/downloadfrag.go
	env GOPATH=$(GOPATH) go get gopkg.in/yaml.v2
	env GOPATH=$(GOPATH) go install guengel.ch/downloadfrag

clean:
	rm -rf bin
	rm -rf pkg
