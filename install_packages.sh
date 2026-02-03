#!/bin/bash

# Script para instalar pacotes Python offline (.whl)
# Autor: Cristiano Amaral
# Data: 2026-02-03

echo "=========================================="
echo "Iniciando instalação de pacotes Python"
echo "=========================================="
echo ""

# Cores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Contador de sucesso/erro
SUCCESS=0
FAILED=0

# Função para instalar pacote
# $folder = Path dos arquivos de instalacao (whl)
# $package = Arquivo .whl principal do pacote
# $package_name = Nome do package (usado pelo pip install <package_name>)
install_package() {
    local folder=$1
    local package=$2
    local package_name=$3

    echo -e "${YELLOW}Instalando: ${package_name}${NC}"

    if [ -f "${folder}/${package}" ]; then
        cd $folder
        pip install -f ./ --no-index ${package_name}

        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ ${package_name} instalado com sucesso${NC}"
            ((SUCCESS++))
        else
            echo -e "${RED}✗ Erro ao instalar ${package_name}${NC}"
            ((FAILED++))
        fi
    else
        echo -e "${RED}✗ Arquivo não encontrado: ${folder}/${package}${NC}"
        ((FAILED++))
    fi
    echo ""
}

# Verificar se está em um venv
if [ -z "$VIRTUAL_ENV" ]; then
    echo -e "${RED}AVISO: Você não está em um ambiente virtual!${NC}"
    read -p "Deseja continuar mesmo assim? (s/n): " response
    if [[ ! "$response" =~ ^[Ss]$ ]]; then
        echo "Instalação cancelada."
        exit 1
    fi
    echo ""
fi

# Instalar pacotes ()
install_package "/home/a0155266/downloads/python-312-packages/black" "black-25.9.0-py3-none-any.whl" "black"
install_package "/home/a0155266/downloads/python-312-packages/fastapi_standard" "fastapi-0.116.1-py3-none-any.whl" "fastapi[standard]"
install_package "/home/a0155266/downloads/python-312-packages/lxml" "lxml-6.0.2-cp312-cp312-manylinux_2_26_x86_64.manylinux_2_28_x86_64.whl" "lxml"
install_package "/home/a0155266/downloads/python-312-packages/requests" "requests-2.32.4-py3-none-any.whl" "requests"

# Resumo
echo "=========================================="
echo "Resumo da instalação:"
echo -e "${GREEN}Sucesso: ${SUCCESS}${NC}"
echo -e "${RED}Falhas: ${FAILED}${NC}"
echo "=========================================="

# Listar pacotes instalados
echo ""
echo "Pacotes instalados:"
pip list | grep -E "black|cryptography|fastapi|lxml|requests"

exit 0