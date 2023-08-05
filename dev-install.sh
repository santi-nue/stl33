#!/usr/bin/env bash

# For a clean conda environment please read docs/source/dev_install.md

echo -n "Checking pip... "
pip --version
if [ $? -ne 0 ]; then
    echo "'pip --version' failed, therefore pip is not installed. In order to perform
    a developer install of ipywidgets you must have pip installed on
    your machine! See https://packaging.python.org/installing/ for installation instructions."
    exit 1
fi

echo -n "Checking JupyterLab (assuming JupyterLab >=4)... "
jupyter lab --version 2>/dev/null
if [ $? -ne 0 ]; then
    echo "no, skipping installation of widgets for jupyterlab"
    skip_jupyter_lab=yes
fi


# All following commands must run successfully
set -e

nbExtFlags="--sys-prefix $1"

# echo -n "Installing and building all yarn packages"
# jlpm
# jlpm build

echo -n "widgetsnbextension"
pip install widgetsnbextension
if [[ "$OSTYPE" == "msys" ]]; then
    jupyter nbextension install --overwrite --py $nbExtFlags widgetsnbextension || true
else
    jupyter nbextension install --overwrite --py --symlink $nbExtFlags widgetsnbextension || true
fi
jupyter nbextension enable --py $nbExtFlags widgetsnbextension || true

echo -n "ipywidgets"
pip install ipywidgets

pip install jupyterlab_widgets


