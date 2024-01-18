#!/bin/sh

COOKIES=${COOKIES?-'Nu cookies!!!!!!!!!!111 Refer to the README.'}

projects=$(curl -s 'https://projects.intra.42.fr/projects/list' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:120.0) Gecko/20100101 Firefox/120.0' -H 'Cookie: '"$COOKIES" |\
	 xmllint --html --xpath '//a[starts-with(@href, "/projects")]/@href' - 2>/dev/null |\
	 cut -d\" -f2 |\
	 sort -u)
for project in $projects; do
	(
		pdf=$(curl -s 'https://projects.intra.42.fr/'$project -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:120.0) Gecko/20100101 Firefox/120.0' -H 'Cookie: '"$COOKIES" |\
			xmllint --html --xpath '//a[text()="subject.pdf"]/@href' - 2>/dev/null |\
			cut -d\" -f2)
		echo $project...
		curl -s "$pdf" -o ${project##/projects/}.pdf
	) &
 done
 wait
