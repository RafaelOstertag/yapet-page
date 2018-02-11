#!/bin/sh
#
# Create a fragment from the YAPET yapet.html file using xsltproc.
#
# The script assumes its current working directory is the repository
# root, and `work/tmp` already exists

if [ $# -ne 2 ]
then
    echo "`basename $0 <YAPET> <OUTPUTDIRECTORY>`" >&2
    exit 1
fi

yapet_file=$1
output_dir=$2
content=`xsltproc xslt/manpage.xslt "${yapet_file}"`

cat > "${output_dir}/manual.xml" <<EOF
<?xml version="1.0" encoding="utf-8"?>
<fragment>
  <title>
    YAPET - Manual
  </title>
  <content>
    <![CDATA[
    <main class="container">
      <section>
        <header>
          <h1 class="mt-4">Manual</h1>
        </header>
	${content}
      </section>
    </main>
      ]]>
  </content>
</fragment>
EOF
exit 0
