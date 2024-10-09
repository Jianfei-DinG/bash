#!/bin/bash

# 定义颜色和样式
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;36m'  # 青色
MAGENTA='\033[0;35m'
CYAN='\033[0;32m'
BOLD='\033[1m'
UNDERLINE='\033[4m'
NC='\033[0m' # 无色

# 打印带样式的标题
print_stylish_title() {
    echo -e "${BOLD}${MAGENTA}"
    echo "+=================================+"
    echo "|      SSL 证书一键生成器          |"
    echo "+=================================+"
    echo -e "${NC}"
}

# 生成证书
generate_certificate() {
    local DOMAIN=$1
    local EMAIL=$2
    echo -e "${CYAN}正在为 ${YELLOW}$DOMAIN${CYAN} 生成私钥和证书...${NC}"
    openssl genpkey -algorithm RSA -out "$DOMAIN.key"
    openssl req -new -key "$DOMAIN.key" -out "$DOMAIN.csr" -subj "/C=CN/ST=Hong Kong/L=Hong Kong/O=MyCompany/OU=IT Department/CN=$DOMAIN/emailAddress=$EMAIL"
    openssl x509 -req -in "$DOMAIN.csr" -signkey "$DOMAIN.key" -out "$DOMAIN.crt" -days 5475
    echo -e "${GREEN}证书为 $DOMAIN 生成完毕 (${DOMAIN}.crt)${NC}"
}

# 打印证书信息
print_certificate() {
    local DOMAIN=$1
    echo -e "${CYAN}${BOLD}正在显示 ${YELLOW}$DOMAIN${CYAN} 的证书信息:${NC}"
    openssl x509 -in "$DOMAIN.crt" -noout -text | sed \
        -e "s/^Certificate:/$(echo -e "${MAGENTA}${BOLD}Certificate:${NC}")/" \
        -e "s/^    Data:/$(echo -e "${BLUE}${BOLD}    Data:${NC}")/" \
        -e "s/^        Version:/$(echo -e "${GREEN}        Version:${NC}")/" \
        -e "s/^        Serial Number:/$(echo -e "${GREEN}        Serial Number:${NC}")/" \
        -e "s/^    Signature Algorithm:/$(echo -e "${BLUE}${BOLD}    Signature Algorithm:${NC}")/" \
        -e "s/^        Issuer:/$(echo -e "${GREEN}        Issuer:${NC}")/" \
        -e "s/^        Validity:/$(echo -e "${YELLOW}${BOLD}${UNDERLINE}        Validity:${NC}")/" \
        -e "s/^            Not Before:/$(echo -e "${YELLOW}${BOLD}            Not Before:${NC}")/" \
        -e "s/^            Not After :/$(echo -e "${YELLOW}${BOLD}            Not After :${NC}")/" \
        -e "s/^        Subject:/$(echo -e "${GREEN}        Subject:${NC}")/" \
        -e "s/^        Subject Public Key Info:/$(echo -e "${GREEN}        Subject Public Key Info:${NC}")/" \
        -e "s/^        X509v3 extensions:/$(echo -e "${GREEN}        X509v3 extensions:${NC}")/" \
        -e "s/^    Signature Algorithm:/$(echo -e "${BLUE}${BOLD}    Signature Algorithm:${NC}")/"
}

# 主流程
main() {
    print_stylish_title
    
    echo -e "${CYAN}${BOLD}请输入域名或IP (例如：www.example.com 或 192.168.1.1): ${NC}"
    echo -e "${YELLOW}示例:${NC}"
    echo -e "${BLUE}  - 标准域名: www.example.com${NC}"
    echo -e "${BLUE}  - 通配符域名: *.example.com${NC}"
    echo -e "${BLUE}  - IP地址: 192.168.1.1${NC}"
    echo -e "${RED}${BOLD}按 Ctrl+C 可随时退出程序${NC}"
    echo
    echo -ne "${GREEN}${BOLD}请输入域名 >>: ${NC}"
    read -r DOMAIN

    if [ -z "$DOMAIN" ]; then
        echo -e "${RED}输入不能为空，请重新运行脚本。${NC}"
        exit 1
    fi

    echo -ne "${CYAN}${BOLD}请输入邮箱地址 >>: ${NC}"
    read -r EMAIL

    if [ -z "$EMAIL" ]; then
        echo -e "${RED}邮箱不能为空，请重新运行脚本。${NC}"
        exit 1
    fi

    generate_certificate "$DOMAIN" "$EMAIL"
    print_certificate "$DOMAIN"

    # 删除临时 CSR 文件
    # rm "$DOMAIN.csr"
    echo -e "${GREEN}${BOLD}>> 所有操作已完成！<<${NC}"
}

main
