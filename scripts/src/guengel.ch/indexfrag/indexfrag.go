/*
Create a XML fragment for a software index.html to be consumed by
fragass. It reads versions.yml and index.tmpl from templates
directory from the repository root.


*/
package main

import (
	"bytes"
	"flag"
	"guengel.ch/fragment"
	"guengel.ch/versions"
	"log"
	"text/template"
)

type latestRelease struct {
	Tarball string
	Title string
}

func processIndexTemplate(filename string, latestRel latestRelease) string {
	tmpl, err := template.ParseFiles(filename)
	if  err != nil {
		log.Fatal(err)
	}

	buffer := new(bytes.Buffer)

	if err = tmpl.Execute(buffer, latestRel); err != nil {
		log.Fatal(err)
	}

	return buffer.String()
}

func parseFlags() (string,string) {
	var packageName string
	var pageTitle string

	flag.StringVar(&packageName, "package-name", "", "package name, use to create the latest download link. E.g. 'yapet'")
	flag.StringVar(&pageTitle, "page-title", "", "page title")
	flag.Parse()

	return packageName, pageTitle
}

func main() {
	packageName, pageTitle := parseFlags()
	if (packageName == "") {
		log.Fatal("package name not set")
	}
	if (pageTitle == "") {
		log.Fatal("page title not set")
	}
	vers := versions.UnmarshalVersionsFromYAML("versions.yml")
	var latestRel latestRelease
	latestRel.Tarball = packageName + "-" + vers[0].Version+vers[0].Dists[0]
	latestRel.Title = vers[0].Title
	
	content := processIndexTemplate("templates/index.tmpl", latestRel)
	
	var frag fragment.Fragment
	frag.Title = pageTitle
	frag.Content.Cdata = content
	fragment.OutputXMLFragment(frag)
}

