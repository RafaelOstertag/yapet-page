
GOPATH = $(abspath .)

all: bin/fragass bin/downloadfrag bin/indexfrag

bin/fragass: src/guengel.ch/fragass/fragass.go
	env GOPATH=$(GOPATH) go install guengel.ch/fragass

bin/downloadfrag: src/guengel.ch/downloadfrag/downloadfrag.go src/guengel.ch/versions/versions.go src/guengel.ch/fragment/fragment.go
	env GOPATH=$(GOPATH) go get gopkg.in/yaml.v2
	env GOPATH=$(GOPATH) go install guengel.ch/downloadfrag

bin/indexfrag: src/guengel.ch/indexfrag/indexfrag.go src/guengel.ch/versions/versions.go src/guengel.ch/fragment/fragment.go
	env GOPATH=$(GOPATH) go get gopkg.in/yaml.v2
	env GOPATH=$(GOPATH) go install guengel.ch/indexfrag

clean:
	rm -rf bin
	rm -rf pkg
	rm -rf src/gopkg.in
