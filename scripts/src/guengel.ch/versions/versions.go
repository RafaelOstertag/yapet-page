package versions

import (
	"gopkg.in/yaml.v2"
	"io/ioutil"
	"log"
)

type Version struct {
	Version string `yaml:"version"`
	Title string `yaml:"title"`
	Dists []string `yaml:"dists"`
}

func UnmarshalVersionsFromYAML(filename string) []Version {
	yamlFileContent, err := ioutil.ReadFile(filename)
	if err != nil {
		log.Fatal(err)
	}

	var versions []Version

	err = yaml.Unmarshal(yamlFileContent, &versions)
	if err != nil {
		log.Fatal(err)
	}

	return versions
}
