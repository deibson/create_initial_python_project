#!/bin/bash

# Nome do projeto (sem espaços)
NOME_PROJETO=""
while [ -z "$NOME_PROJETO" ]; do
    echo "Informe o nome do projeto:"
    read -r NOME_PROJETO
done

# Cria o diretório do projeto
mkdir "$NOME_PROJETO"

# Navega para o diretório do projeto
cd "$NOME_PROJETO"

# Verifica se o Git está instalado
if ! command -v git >/dev/null; then
    echo "O Git não está instalado."
    echo "Deseja instalá-lo? (s/n)"
    read -r INSTALAR_GIT
    if [[ $INSTALAR_GIT =~ ^[Ss]$ ]]; then
        echo "Instalando o Git..."
        sudo apt-get install git -y
    else
        echo "O Git não será instalado."
    fi
fi

# Verifica se o Python 3 está instalado
if ! command -v python3 >/dev/null; then
    echo "O Python 3 não está instalado."
    echo "Deseja instalá-lo? (s/n)"
    read -r INSTALAR_PYTHON3
    if [[ $INSTALAR_PYTHON3 =~ ^[Ss]$ ]]; then
        echo "Instalando o Python 3..."
        sudo apt-get install python3 -y
    else
        echo "O Python 3 não será instalado."
    fi
fi

# Verifica se o venv está disponível
if ! command -v python3 -m venv >/dev/null; then
    echo "O venv não está disponível."
    echo "Deseja instalá-lo? (s/n)"
    read -r INSTALAR_VENV
    if [[ $INSTALAR_VENV =~ ^[Ss]$ ]]; then
        echo "Instalando o venv..."
        sudo apt-get install python3-venv -y
    else
        echo "O venv não será instalado."
    fi
fi

# Cria o ambiente virtual
python3 -m venv .venv

# Ativa o ambiente virtual
source .venv/bin/activate

# Verifica se o pip está instalado
if ! command -v pip3 >/dev/null; then
    echo "O pip3 não está instalado."
    echo "Deseja instalá-lo? (s/n)"
    read -r INSTALAR_PIP3
    if [[ $INSTALAR_PIP3 =~ ^[Ss]$ ]]; then
        echo "Instalando o pip3..."
        sudo apt-get install python3-pip -y
    else
        echo "O pip3 não será instalado."
    fi
fi

# Cria o diretório para armazenar os arquivos Python do projeto
mkdir src

# Cria o diretório para documentação (opcional).
mkdir docs

# Cria o arquivo principal (geralmente main.py)
touch main.py

# Cria o arquivo de requisitos (opcional)
touch requirements.txt

# Cria o arquivo README.md (opcional)
touch README.md

# Cria o arquivo gitignore (opcional)
touch .gitignore

# Gera conteúdo do README.md
CONTEUDO_README=:'

## NOME_PROJETO

**1. Ative o Ambiente Virtual:**

* Ative o ambiente virtual para que o comando seja executado dentro dele:

    **Linux:**

        ```bash
            source .venv/bin/activate
        ```

**2. Instale as Dependências do Projeto:**

* Com arquivo `requirements.txt` listando as dependências, instale-as utilizando o comando `pip`:

    ```bash
        pip install -r requirements.txt
    ```

**Observações:**

* **Desativando o Ambiente Virtual:** 

Para desativar o ambiente virtual e voltar ao terminal principal, utilize o comando:

    ```bash
        deactivate
    ```
'

# Grava o conteúdo no README.md
echo "$CONTEUDO_README" > README.md

# Grava o conteúdo no gitignore
echo ".venv" > .gitignore

# Grava o conteúdo no main.py
echo "if __name__ == "__main__":
    print("Hello, World!")" > main.py

# Verifica se o nome e email do Git estão configurados
NOME_GIT=$(git config user.name)
EMAIL_GIT=$(git config user.email)

if [ -z "$NOME_GIT" ] || [ -z "$EMAIL_GIT" ]; then
    # Nome e email não configurados, solicita configuração
    echo "Nome e email Git não configurados."
    echo "Deseja configurá-los agora? (s/n)"
    read -r CONFIGURAR_GIT
    if [[ $CONFIGURAR_GIT =~ ^[Ss]$ ]]; then
        NOME_GIT=""
        while [ -z "$NOME_GIT" ]; do
            echo "Digite seu nome Git:"
            read -r NOME_GIT
        done

        EMAIL_GIT=""
        while [ -z "$EMAIL_GIT" ]; do
            echo "Digite seu email Git:"
            read -r EMAIL_GIT
        done

        # Configura nome e email no Git
        git config user.name "$NOME_GIT"
        git config user.email "$EMAIL_GIT"
    else
        echo "Nome e email Git não configurados."
    fi
fi

# Inicializa o repositório Git (opcional)
git init

# Adiciona os arquivos ao repositório Git (opcional)
git add main.py requirements.txt README.md .gitignore

# Faz o commit inicial (opcional)
git commit -m "inital commit"

# Exibe mensagem de conclusão
echo "Projeto inicial Python '$NOME_PROJETO' criado com sucesso!"
