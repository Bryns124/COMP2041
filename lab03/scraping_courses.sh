#! /usr/bin/env dash

positive_int=$(echo $1 | grep -E "^[0-9]+$")

if [ $# -ne 2 ]; then
    echo "Usage: $0 <year> <course-prefix>"
elif [ $1 -lt 2019 -o $1 -gt 2023 ] 2>/dev/null; then
    echo "$0: argument 1 must be an integer between 2019 and 2023"
elif ! [ "$1" -eq "$1" ] 2>/dev/null; then
    echo "$0: argument 1 must be an integer between 2019 and 2023"
fi

undergrad=https://www.handbook.unsw.edu.au/api/content/render/false/query/+unsw_psubject.implementationYear:$1%20+unsw_psubject.studyLevel:undergraduate%20+unsw_psubject.educationalArea:$2*%20+unsw_psubject.active:1%20+unsw_psubject.studyLevelValue:ugrd%20+deleted:false%20+working:true%20+live:true/orderby/unsw_psubject.code%20asc/limit/10000/offset/0
postgrad=https://www.handbook.unsw.edu.au/api/content/render/false/query/+unsw_psubject.implementationYear:$1%20+unsw_psubject.studyLevel:postgraduate%20+unsw_psubject.educationalArea:$2*%20+unsw_psubject.active:1%20+unsw_psubject.studyLevelValue:pgrd%20+deleted:false%20+working:true%20+live:true/orderby/unsw_psubject.code%20asc/limit/10000/offset/0
wget -qO- $undergrad | jq '.contentlets[] | {code: .code, title: .title}' | sed 's/[{}"]//g' | sed 's/  code: //g' | sed 's/  title: //g' | sed -z 's/,\n/ /g' | sed -z 's/\n\n/ /g' | sed '1d' > under.txt
wget -qO- $postgrad | jq '.contentlets[] | {code: .code, title: .title}' | sed 's/[{}"]//g' | sed 's/  code: //g' | sed 's/  title: //g' | sed -z 's/,\n/ /g' | sed -z 's/\n\n/ /g' | sed '1d' > post.txt

cat under.txt post.txt | sort | uniq