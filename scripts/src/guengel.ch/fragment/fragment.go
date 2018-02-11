package fragment

import (
	"encoding/xml"
	"fmt"
	"log"
)

type Fragment struct {
	Title string `xml:"title"`
	Content struct {
		XMLName xml.Name `xml:"content"`
		Cdata string `xml:",cdata"`
	}
}

func OutputXMLFragment(frag Fragment) {
	xmlData, err := xml.Marshal(frag)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Print(string(xmlData))
}
