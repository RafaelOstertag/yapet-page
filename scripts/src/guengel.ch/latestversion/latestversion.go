/*
Print the latest version of YAPET tarball using information from
`versions.yml` to stdout. The first entry in `versions.yml` is
considered the latest release.

The application has to be started in the root of the repo.
*/

package main

import (
	"fmt"
	"guengel.ch/versions"
)

func main() {
	vers := versions.UnmarshalVersionsFromYAML("versions.yml")

	fmt.Printf("yapet-%s%s\n",
		vers[0].Version,
		vers[0].Dists[0])
}
