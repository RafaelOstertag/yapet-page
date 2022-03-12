
GOPATH = $(abspath .)

all: bin/fragass bin/downloadfrag bin/indexfrag bin/latestversion

bin/fragass: src/guengel.ch/fragass/fragass.go
	cd src/guengel.ch/fragass && env GOPATH=$(GOPATH) go install guengel.ch/fragass

bin/downloadfrag: src/guengel.ch/downloadfrag/downloadfrag.go src/guengel.ch/versions/versions.go src/guengel.ch/fragment/fragment.go
	cd src/guengel.ch/downloadfrag && env GOPATH=$(GOPATH) go install guengel.ch/downloadfrag

bin/indexfrag: src/guengel.ch/indexfrag/indexfrag.go src/guengel.ch/versions/versions.go src/guengel.ch/fragment/fragment.go
	cd src/guengel.ch/indexfrag && env GOPATH=$(GOPATH) go install guengel.ch/indexfrag

bin/latestversion: src/guengel.ch/latestversion/latestversion.go src/guengel.ch/versions/versions.go
	cd src/guengel.ch/latestversion && env GOPATH=$(GOPATH) go install guengel.ch/latestversion

clean:
	rm -rf bin
	chmod u+w -R pkg || true
	rm -rf pkg
	rm -rf src/gopkg.in
