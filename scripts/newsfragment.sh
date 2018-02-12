#!/bin/sh
#
# Create a fragment from the YAPET NEWS file using pandoc.
#
# The script assumes its current working directory is the repository
# root, and `work/tmp` already exists

if [ $# -ne 2 ]
then
    echo "`basename $0 \<NEWSFILE\> \<OUTPUTDIRECTORY\>`" >&2
    exit 1
fi

news_file=$1
output_dir=$2

# The fragment below provides the section header, so we don't need the
# first line of the HTMLized NEWS file, which also happens to be a
# `<h1>`
content=`pandoc -t html5 "${news_file}" | sed -e 1d`
cat > "${output_dir}/news.xml" <<EOF
<?xml version="1.0" encoding="utf-8"?>
<fragment>
  <title>
    YAPET News
  </title>
  <content>
    <![CDATA[
    <main class="container">
      <section>
        <header>
          <h1 class="mt-4">NEWS</h1>
        </header>
	${content}
      </section>
    </main>
      ]]>
  </content>
</fragment>
EOF
exit 0
