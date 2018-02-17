/*
Print the latest version of a software tarball using information from
`versions.yml` to stdout. The first entry in `versions.yml` is
considered the latest release.

The application has to be started in the root of the repo.
*/

package main

import (
	"flag"
	"fmt"
	"guengel.ch/versions"
	"log"
)

func parseFlags() (string) {
	var packageName string

	flag.StringVar(&packageName, "package-name", "", "package name, use to create the latest download link. E.g. 'yapet'")
	flag.Parse()

	return packageName
}

func main() {
	packageName := parseFlags()
	if (packageName == "") {
		log.Fatal("package name not set")
	}
	vers := versions.UnmarshalVersionsFromYAML("versions.yml")

	fmt.Printf("%s-%s%s\n",
		packageName,
		vers[0].Version,
		vers[0].Dists[0])
}
