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
        python3 -m pip install --upgrade pip
    else
        echo "O pip3 não será instalado."
    fi
fi

# Criar o diretório para documentação (opcional).
mkdir docs

# Criar o arquivo de MANIFEST (opcional)
touch MANIFEST.in

# Criar o arquivo de LICENSE (opcional)
touch LICENSE.txt

# Criar o arquivo de requisitos (opcional)
touch requirements.txt

# Criar o arquivo de requisitos de test(opcional)
touch test-requirements.txt

# Criar o arquivo README.md (opcional)
touch README.md

# Criar o arquivo gitignore (opcional)
touch .gitignore

# Criar o arquivo setup (opcional)
touch setup.py

# Criar o arquivo pypirc (opcional)
touch .pypirc

# Gerar conteúdo do MANIFEST.in
CONTEUDO_MANIFEST='include LICENSE
include README.md
include requirements.txt
'

# Grava o conteúdo no requirements.txt
echo "$CONTEUDO_MANIFEST" > MANIFEST.in

# Gerar conteúdo do LICENSE.txt
CONTEUDO_LICENSE='MIT License

Copyright (c) 2023 ArjanCodes

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
'

# Grava o conteúdo no LICENSE.txt
echo "$CONTEUDO_LICENSE" > LICENSE.txt

# Gerar conteúdo do requirements.txt
CONTEUDO_REQUIREMENTS='twine
setuptools
wheel
setuptools-declarative-requirements
'

# Grava o conteúdo no requirements.txt
echo "$CONTEUDO_REQUIREMENTS" > requirements.txt

# Gerar conteúdo do README.md
CONTEUDO_README='

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

# Gerar conteúdo do .gitignore
CONTEUDO_GITIGNORE='# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
.pypirc
MANIFEST

# PyInstaller
#  Usually these files are written by a python script from a template
#  before PyInstaller builds the exe, so as to inject date/other infos into it.
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/
cover/

# Translations
*.mo
*.pot

# Django stuff:
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal

# Flask stuff:
instance/
.webassets-cache

# Scrapy stuff:
.scrapy

# Sphinx documentation
docs/_build/

# PyBuilder
.pybuilder/
target/

# Jupyter Notebook
.ipynb_checkpoints

# IPython
profile_default/
ipython_config.py

# pyenv
#   For a library or package, you might want to ignore these files since the code is
#   intended to run in multiple environments; otherwise, check them in:
# .python-version

# pipenv
#   According to pypa/pipenv#598, it is recommended to include Pipfile.lock in version control.
#   However, in case of collaboration, if having platform-specific dependencies or dependencies
#   having no cross-platform support, pipenv may install dependencies that dont work, or not
#   install all needed dependencies.
#Pipfile.lock

# PEP 582; used by e.g. github.com/David-OConnor/pyflow
__pypackages__/

# Celery stuff
celerybeat-schedule
celerybeat.pid

# SageMath parsed files
*.sage.py

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# Spyder project settings
.spyderproject
.spyproject

# Rope project settings
.ropeproject

# mkdocs documentation
/site

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# Pyre type checker
.pyre/

# pytype static type analyzer
.pytype/

# Cython debug symbols
cython_debug/
'

# Grava o conteúdo no gitignore
echo "$CONTEUDO_GITIGNORE" > .gitignore

# Gerar conteúdo do setup.py
CONTEUDO_SETUP='from setuptools import setup, find_packages


with open("README.md", "r") as f:
    page_description = f.read()


with open("requirements.txt") as f:
    requirements = f.read().splitlines()


setup(
    name="package_name",
    version="0.0.1",
    author="my_name",
    author_email="my_email",
    description="My short description",
    long_description=page_description,
    long_description_content_type="text/markdown",
    url="my_repository_project_link",
    packages=find_packages(exclude=["tests"]),
    install_requires=requirements,
    python_requires=">=3.10",
    classifiers=[
        "Programming Language :: Python :: 3.10",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    extras_require={
        "dev": ["pytest", "twine"],
    },
    license="MIT",
    zip_safe=False,
    test_suite="unittest",
)
'

# Grava o conteúdo no setup.py
echo "$CONTEUDO_SETUP" > setup.py

# Gerar conteúdo do .pypirc
CONTEUDO_PYPIRC='[distutils]
index-servers=
    pypi
    pypitest

[pypitest]
repository = https://testpypi.python.org/pypi
username = user_name

[pypi]
repository = https://pypi.python.org/pypi
username = user_name
'

# Grava o conteúdo no .pypirc
echo "$CONTEUDO_PYPIRC" > .pypirc

# Instalar dependencias python basicas
pip install -r requirements.txt

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


# Criar o pacote do projeto
mkdir "$NOME_PROJETO"

# Navegar para o pacote do projeto
cd "$NOME_PROJETO"

# Criar o arquivo init (geralmente main.py)
touch __init__.py

# Criar o diretório para armazenar os arquivos Python do projeto
mkdir src

# Criar o arquivo init 
touch src/__init__.py

# Criar o arquivo principal (geralmente main.py)
touch main.py

# Gravar o conteúdo no main.py
echo 'def print_message():
    print("Hello, World!")' > main.py

# Gravar o conteúdo no __init__.py
echo 'from .main import *' > __init__.py

# Navegar para o Diretorio do Projeto
cd ..

# Criar o diretório para armazenar os arquivos de tests do projeto
mkdir tests

# Inicializar o repositório Git (opcional)
git init

# Adicionar os arquivos ao repositório Git (opcional)
git add .

# Fazer o commit inicial (opcional)
git commit -m "inital commit"

# Executar Build do Pacote
python setup.py sdist bdist_wheel

# Exibe mensagem de conclusão
echo "Projeto inicial Python '$NOME_PROJETO' criado com sucesso!"
