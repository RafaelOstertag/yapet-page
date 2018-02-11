/*
Create a XML fragment for YAPET index.html to be consumed by
fragass. It reads versions.yml and index.tmpl from templates
directory from the repository root.
*/
package main

import (
	"bytes"
	"log"
	"text/template"
	"guengel.ch/versions"
	"guengel.ch/fragment"
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

func main() {
	vers := versions.UnmarshalVersionsFromYAML("versions.yml")
	var latestRel latestRelease
	latestRel.Tarball = "yapet-"+vers[0].Version+vers[0].Dists[0]
	latestRel.Title = vers[0].Title
	
	content := processIndexTemplate("templates/index.tmpl", latestRel)
	
	var frag fragment.Fragment
	frag.Title = "YAPET- Yet Another Password Encryption Tool"
	frag.Content.Cdata = content
	fragment.OutputXMLFragment(frag)
}

