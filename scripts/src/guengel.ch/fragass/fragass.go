package main

import (
	"text/template"
	"encoding/xml"
	"io/ioutil"
	"flag"
	"log"
	"os"
)

type arguments struct {
	template string
	fragment string
}

type fragment struct {
	Title string `xml:"title"`
	Content string `xml:"content"`
}


func parseFlags() arguments {
	args := arguments{}
	
	flag.StringVar(&args.template, "template", "", "template file")
	flag.StringVar(&args.fragment, "fragment", "", "fragment file")
	flag.Parse()

	return args
}

func parseFragment(filename string) fragment {
	content, err := ioutil.ReadFile(filename)
	if err != nil {
		log.Fatal(err)
	}

	frag := fragment{}

	err = xml.Unmarshal(content, &frag)
	if err != nil {
		log.Fatal(err)
	}

	return frag
}

func processTemplate(filename string, data fragment) {
	tmpl, err := template.ParseFiles(filename)
	if  err != nil {
		log.Fatal(err)
	}

	if err = tmpl.Execute(os.Stdout, data); err != nil {
		log.Fatal(err)
	}	
}

func main() {
	args := parseFlags()

	frag := parseFragment(args.fragment)
	processTemplate(args.template, frag)
}
	
	

