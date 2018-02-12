/*
Create a XML fragment for YAPET downloads to be consumed by
fragass. It reads versions.yml and download.tmpl from templates
directory from the repository root.
*/
package main

import (
	"bytes"
	"encoding/xml"
	"fmt"
	"log"
	"text/template"
	"guengel.ch/versions"
)



type fragment struct {
	Title string `xml:"title"`
	Content struct {
		XMLName xml.Name `xml:"content"`
		Cdata string `xml:",cdata"`
	}
}

func processDownloadsTemplate(filename string, vers []versions.Version) string {
	type data struct {
		Versions []versions.Version
	}
	
	tmpl, err := template.ParseFiles(filename)
	if  err != nil {
		log.Fatal(err)
	}

	buffer := new(bytes.Buffer)

	var d data
	d.Versions = vers
	if err = tmpl.Execute(buffer, d); err != nil {
		log.Fatal(err)
	}

	return buffer.String()
}

func outputXMLFragment(frag fragment) {
	xmlData, err := xml.Marshal(frag)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Print(string(xmlData))
}

func main() {
	vers := versions.UnmarshalVersionsFromYAML("versions.yml")
	content := processDownloadsTemplate("templates/downloads.tmpl", vers)
	var frag fragment
	frag.Title = "YAPET Downloads"
	frag.Content.Cdata = content
	outputXMLFragment(frag)
}

