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
	"gopkg.in/yaml.v2"
	"io/ioutil"
	"log"
	"text/template"
)

type version struct {
	Version string `yaml:"version"`
	Title string `yaml:"title"`
	Dists []string `yaml:"dists"`
}

type fragment struct {
	Title string `xml:"title"`
	Content struct {
		XMLName xml.Name `xml:"content"`
		Cdata string `xml:",cdata"`
	}
}

func unmarshalVersionsFromYAML(filename string) []version {
	yamlFileContent, err := ioutil.ReadFile(filename)
	if err != nil {
		log.Fatal(err)
	}

	var versions []version

	err = yaml.Unmarshal(yamlFileContent, &versions)
	if err != nil {
		log.Fatal(err)
	}

	return versions
}

func processDownloadsTemplate(filename string, versions []version) string {
	type data struct {
		Versions []version
	}
	
	tmpl, err := template.ParseFiles(filename)
	if  err != nil {
		log.Fatal(err)
	}

	buffer := new(bytes.Buffer)

	var d data
	d.Versions = versions
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
	versions := unmarshalVersionsFromYAML("versions.yml")
	content := processDownloadsTemplate("templates/downloads.tmpl", versions)
	var frag fragment
	frag.Title = "YAPET - Downloads"
	frag.Content.Cdata = content
	outputXMLFragment(frag)
}

