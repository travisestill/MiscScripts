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
echo "Last Question! What filetype do you want to download? You can say: audio, document, photo, video, webapp. You can specify multiple types as well"
read filetype

#silly banter
echo "commencing download in..."
sleep 1
echo 3
sleep 1
echo 2
sleep 1
echo 1
sleep 1
echo "...begin!"
sleep 1

#API requests:
getAssetIds=( $(curl -X GET --header 'Accept: application/json' --header 'Authorization: Bearer '"$accessCode"'' 'https://'"$subdomain"'.showpad.biz/api/v3/assets.json?filetype='"$filetype"'&fields=id&limit=1000' | jq .response.items[].id | tr -d \") )

for id in ${getAssetIds[@]}
do
	downloadLinks=( $(curl -X GET --header 'Accept: application/json' --header 'Authorization: Bearer '"$accessCode"'' 'https://'"$subdomain"'.showpad.biz/api/v3/assets/'"${id}"'.json?fields=shortLivedDownloadLink,name' | jq -r .response.shortLivedDownloadLink) )
#Download
	wget --content-disposition ${downloadLinks[@]} -P ~/Downloads/$subdomain

done
 $ wget 2> error.log

 echo "The script took " 
 time