
GOPATH = $(abspath .)

all: bin/fragass

bin/fragass: src/guengel.ch/fragass/fragass.go
	env GOPATH=$(GOPATH) go install guengel.ch/fragass

clean:
	rm -rf bin
