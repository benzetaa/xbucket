#!/bin/bash

# Seta as cores 
RED='\033[0;31m' # Red
NC='\033[0m' # No Color
VERDE='\033[0;32m' # Green 
LAZUL='\e[96m' # Ligth Blue 
BOLD='\e[1m' # Bold 
AMARELO='\033[1;33m'
AZUL='\033[1;34m'
RESET="\033[0m"			# Normal Colour
BOLD="\033[01;01m"    		# Highlight
YELLOW="\033[1;33m"		# Warning
PADDING="  "
# Seta as cores 
 
bucket_argumento=$2

banner (){ 
    echo -e "\n ${YELLOW}xbucket ${RESET}- Enumeration of s3 files if vulnerable ${RESET}"
    echo -e " ${BOLD}By Benzeta${RESET}\n" 
}

banner_help (){
    banner
    printf "\nExemple of use:\n"
    printf "ex: $0 --bucket/-b bucket-name\n" 
    printf "ex: $0 --url/-u bucketname.com.br\n" 
}

## Função para verificar se o bucket está vulnerável atravéz do nome  ##
function bucket () {
	
	for regi in $(cat regions.txt); do
		printf "\n${BOLD}${VERDE}Bucket $bucket_argumento and region $regi ${NC}"
        VAR=$(aws s3 ls $bucket_argumento --no-sign-request --region  $regi)
        if [ $? -eq 0 ]
        then 
            printf "\n${RED}${BOLD}Vulnerable $bucket_argumento region $regi${NC}\n\n"
            echo "$VAR"
            exit
        fi
	done
}  ## Função para verificar se o bucket está vulnerável atravéz do nome  ##


## Função para verificar se o bucket está vulnerável atravéz da url  ##
function url () {
	
	for regi in $(cat regions.txt); do
		printf "\n${BOLD}${VERDE}$bucket_argumento and region $regi ${NC}"
        VAR=$(aws s3 ls --endpoint-url $bucket_argumento --no-sign-request --region  $regi)
        if [ $? -eq 0 ]
        then 
            printf "\n${RED}${BOLD}Vulnerable $bucket_argumento region $regi${NC}\n\n"
            echo "$VAR"
            exit
        fi
	done
}  ## Função para verificar se o bucket está vulnerável atravéz da url  ##

 
 
case $1 in
--bucket | -b)  
    banner
    bucket ;; 

--url | -u) 
    banner
    url ;; 

--help | -h)
    banner_help
    exit ;;

* | --help | -h)   
    banner_help
    exit ;;
esac
