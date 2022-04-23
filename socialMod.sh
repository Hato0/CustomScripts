#Google Dorks
dorksResultMax=$1
companyTargeted=$2
lnkdCookie=$3
linkedinURL=""
echo "[+] Gethering company employees"
for i in $(seq 0 10 $dorksResultMax)
do
    curl -k -sA "Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1" \
    -L "https://www.google.com/search?q=site%3Alinkedin.com+$companyTargeted+-inurl%3A$companyTargeted&start=$i" -o GDEmployeeResult.txt 
    linkedinURL=$linkedinURL" "`cat GDEmployeeResult.txt | grep -o 'href="[^"]*' | grep '/url' | grep -v 'google' | awk -F'in/' '{print $2}' | awk -F'&amp' '{print $1}' | grep -v -e '^[[:space:]]*$' -e '^#'`
    sleep 2
done
echo "$linkedinURL"
# Linkedin part
echo "[+] Looking for linkedin information"
userData=""
echo "|User|Birth Date|Address|Phone Number|Email Address|Interests|Websites|" > userInfo.md
echo "|:---:|:---:|:---:|:---:|:---:|:---:|:---:|" >> userInfo.md
for user in $linkedinURL
do
    curl -s --cookie "li_at=$lnkdCookie" "https://www.linkedin.com/in/$user/overlay/contact-info/" -o userOut 
    userData="`grep 'Twitter'  userOut | python3 -c 'import html, sys; [print(html.unescape(l), end="") for l in sys.stdin]' |jq -r '.data'`"
    echo "|$user|`echo $userData|jq '.birthDateOn'`|`echo $userData|jq '.address'`|`echo $userData|jq '.phoneNumbers'`|`echo $userData|jq '.emailAddress'`|`echo $userData|jq '.interests'`|`echo $userData|jq '.websites[].url' 2>/dev/null`|" >> userInfo.md
    sleep 3
done
cat userInfo.md
rm userOut GDEmployeeResult.txt userInfo.md