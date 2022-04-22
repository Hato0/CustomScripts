#Google Dorks
dorksResultMax=$1
companyTargeted=$2
lnkdCookie=$3
for i in {0..$dorksResultMax..10}
do
    curl -k -sA "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1" \
    -L "https://www.google.com/search?q=site%3Alinkedin.com+$companyTargeted+-inurl%3A$companyTargeted&start=$i" -o GDEmployeeResult.txt 
    linkedinURL=`grep 'href="[^"]*' GDEmployeeResult.txt | grep -F 'linkedin'`
    echo $linkedinURL
    exit
done




# Linkedin part
exit
echo ".www.linkedin.com       TRUE    /       TRUE    1682198650      li_at   $lnkdCookie" > lnkcookie.txt
userData=""
for user in "${arr[@]}"
do
    wget --load-cookies lnkcookie.txt https://www.linkedin.com/in/jonathanraspaud/overlay/contact-info/ -O userOut 
    userData=$userData" ""`grep 'Twitter'  userOut | python3 -c 'import html, sys; [print(html.unescape(l), end="") for l in sys.stdin]' |jq -r '.data'`"
done
rm lnkcookie.txt userOut
