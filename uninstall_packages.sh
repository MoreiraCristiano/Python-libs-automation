#!/bin/bash

# Script para remover todos os pacotes Python (com suporte para @ local paths)
# Autor: Cristiano Amaral
# Data: 2026-02-03

echo "=========================================="
echo "Script de remoção de pacotes Python"
echo "=========================================="
echo ""

# Cores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Verificar venv
if [ -z "$VIRTUAL_ENV" ]; then
    echo -e "${RED}ERRO: Você não está em um ambiente virtual!${NC}"
    echo "Ative o venv primeiro com: source venv/bin/activate"
    exit 1
fi

echo -e "${GREEN}✓ Ambiente virtual ativo: $VIRTUAL_ENV${NC}"
echo ""

# Mostrar pacotes
echo "Pacotes atualmente instalados:"
pip list
echo ""

# Confirmação
echo -e "${YELLOW}ATENÇÃO: Todos os pacotes serão removidos!${NC}"
read -p "Deseja continuar? (s/n): " confirm

if [[ ! "$confirm" =~ ^[Ss]$ ]]; then
    echo "Operação cancelada."
    exit 0
fi

echo ""
echo "Removendo todos os pacotes..."
echo ""

# SOLUÇÃO: Extrair apenas os nomes dos pacotes (antes do @ ou ==)
pip freeze | cut -d'@' -f1 | cut -d'=' -f1 | xargs pip uninstall -y

echo ""
echo -e "${GREEN}=========================================="
echo "Remoção concluída!"
echo "==========================================${NC}"
echo ""

echo "Pacotes restantes:"
pip list

exit 0