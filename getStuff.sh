#!/bin/bash

#prompts
#specify subdomaind
echo "Which showpad instance would you like to download from? Please type the subdomain ONLY:"
read subdomain

#specify OAuth access token
echo "Thanks! Now go to the API Explorer in the target Showpad account and copy the Access Code. Paste it below:"
read accessCode

#specify the file type
echo "Thanks! Your files will be downloaded to ~/Downloads/"$subdomain

#silly banter
echo "Let's Go!"
sleep 1

#API requests:
getAssetIds=( $(curl -X GET --header 'Accept: application/json' --header 'Authorization: Bearer '"$accessCode"'' 'https://'"$subdomain"'.showpad.biz/api/v3/assets.json?fields=id&isDownloadable=true&limit=1000' | jq .response.items[].id | tr -d \") )

for id in ${getAssetIds[@]}
do
	downloadLinks=( $(curl -X GET --header 'Accept: application/json' --header 'Authorization: Bearer '"$accessCode"'' 'https://'"$subdomain"'.showpad.biz/api/v3/assets/'"${id}"'.json?fields=shortLivedDownloadLink,name' | jq -r .response.shortLivedDownloadLink) )
	response=$(curl -s -o /dev/null -w '%{http_code}\n' $downloadLinks)
if (($response == 401))
then
    echo "Please enter a new Authorization Key"
		read accessCode
else
	wget --content-disposition ${downloadLinks[@]} -P ~/Downloads/$subdomain
fi
done
 $ wget 2> error.log

 echo "The script took "
 time
