#!/bin/bash
set -e


# Add color
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0)

# Pre-install checks

OS_TYPE=$(uname)
TERRAFORM_VERSION="0.9.11"

# Clean directory if needed
echo "${YELLOW}Running pre-install checks${NC}"

if [ ! -d 'bin' ] ; then
    mkdir -p bin
fi

case $OS_TYPE in
    Linux )
        TERRAFORM_FILE=terraform_${TERRAFORM_VERSION}_linux_amd64.zip
        ;;
    Darwin )
        TERRAFORM_FILE=terraform_${TERRAFORM_VERSION}_darwin_amd64.zip
        ;;
    * )
        echo "${RED}ERROR - OS not supported ${OS_TYPE} ${NC}"
        exit 1
        ;;
esac

echo "${GREEN}Pre-install checks passed${NC}"

# Download and unpack if doesn't exist

if [ ! -f bin/${TERRAFORM_FILE} ] || [ ! -f bin/terraform  ] ; then
    cd bin
    rm -f ${TERRAFORM_FILE} packer
    echo "${GREEN}Cleaning old installation ${NC}"

    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_FILE}
    echo "${GREEN}Terraform file downloaded${NC}"
    unzip ${TERRAFORM_FILE}
    echo "${GREEN}Terraform file uncompressed in $(pwd) ${NC}"
else
    echo "${GREEN}Terraform already installed in $(pwd) ${NC}"
fi
