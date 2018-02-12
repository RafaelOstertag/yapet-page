#!/bin/sh
#
# Create fragments from YAPET htmlized docbook article files using xsltproc.
#
# The script assumes its current working directory is the repository
# root.
#
# The output goes to stdout

set -e
set -n

if [ $# -ne 3 ]
then
    echo "`basename $0` <ARTICLE> <PAGETITLE> <SECTIONHEADER>" >&2
    exit 1
fi

article_file=$1
pagetitle=$2
sectionheader=$3
content=`xsltproc xslt/article.xslt "${article_file}"`

cat <<EOF
<?xml version="1.0" encoding="utf-8"?>
<fragment>
  <title>
    ${pagetitle}
  </title>
  <content>
    <![CDATA[
    <main class="container">
      <section>
        <header>
          <h1 class="mt-4">${sectionheader}</h1>
        </header>
	${content}
      </section>
    </main>
      ]]>
  </content>
</fragment>
EOF
exit 0
