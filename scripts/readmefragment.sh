#!/bin/sh
#
# Create a fragment from the YAPET README.html file using xsltproc.
#
# The script assumes its current working directory is the repository
# root, and `work/tmp` already exists

if [ $# -ne 2 ]
then
    echo "`basename $0 <README> <OUTPUTDIRECTORY>`" >&2
    exit 1
fi

readme_file=$1
output_dir=$2
content=`xsltproc xslt/article.xslt "${readme_file}"`

cat > "${output_dir}/readme.xml" <<EOF
<?xml version="1.0" encoding="utf-8"?>
<fragment>
  <title>
    YAPET - Readme
  </title>
  <content>
    <![CDATA[
    <main class="container">
      <section>
        <header>
          <h1 class="mt-4">Readme</h1>
        </header>
	${content}
      </section>
    </main>
      ]]>
  </content>
</fragment>
EOF
exit 0
