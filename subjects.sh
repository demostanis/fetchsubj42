#!/bin/sh

COOKIES=${COOKIES?-'Nu cookies!!!!!!!!!!111 Refer to the README.'}

pid=$$

projects=$(curl -s 'https://projects.intra.42.fr/projects/list' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:120.0) Gecko/20100101 Firefox/120.0' -H 'Cookie: '"$COOKIES" |\
	 xmllint --html --xpath '//a[starts-with(@href, "/projects")]/@href' - 2>/dev/null |\
	 cut -d\" -f2 |\
	 sort -u)
i=0
for project in $projects; do
	[[ "$project" = *projects_users* ]] && continue

	(
		pdf=$(curl -s 'https://projects.intra.42.fr/'$project -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:120.0) Gecko/20100101 Firefox/120.0' -H 'Cookie: '"$COOKIES" |\
			xmllint --html --xpath '//a[text()="subject.pdf"]/@href' - 2>/dev/null |\
			cut -d\" -f2)

		echo $project...
		if [ -z "$pdf" ]; then
			echo no pdf for $project
		else
			curl -s "$pdf" -o ${project##/projects/}.pdf
		fi
	) &

	i=$(( i + 1 ))
	if (( i > 10 )); then
		wait
		i=0
	fi
 done
 wait
