#!/bin/sh
#
# Create Sitemap.xml and print to stdout. The files to be included in
# the Sitemap must exists when script is called.
#
# The script assumes to be called from the repository root.

set -u
set -e

BASE_URL=https://yapet.guengel.ch/

# W3C Date/Time format in UTC.
lastmod=`date -u '+%Y-%m-%dT%H:%M:%SZ'`

cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
EOF

cd public_html
for f in *.html
do
cat <<EOF
    <url>
	<loc>${BASE_URL}$f</loc>
	<lastmod>${lastmod}</lastmod>
	<changefreq>monthly</changefreq>
    </url>
EOF
done

cat <<EOF
</urlset>
EOF
