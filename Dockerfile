FROM jupyter/minimal-notebook:lab-3.1.9

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends ffmpeg dvipng cm-super curl wget && \
    curl -sL https://deb.nodesource.com/setup_lts.x |bash - && \
    apt-get install --yes --no-install-recommends nodejs && \
    apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# Install Python 3 packages
RUN mamba install --quiet --yes \
    'jupyterlab_code_formatter' \
    'numpy' \
    'matplotlib-base' \
    'pandas' \
    'scikit-learn' \
    'scipy' \
    'networkx' \
    'PuLP' \
    'dlib' \
    'mecab-python3' \
    'PuLP' \
    'black' \
    'openpyxl' && \
    mamba clean --i -t -y -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" && \
    pip install jupyter-kite ortoolpy --no-cache-dir && \
    jupyter labextension install \
    "@ryantam626/jupyterlab_code_formatter" \
    "@kiteco/jupyterlab-kite" && \
    jupyter serverextension enable --py jupyterlab_code_formatter

RUN cd && \
    wget https://linux.kite.com/dls/linux/current && \
    chmod 777 current && \
    sed -i 's/"--no-launch"//g' current > /dev/null && \
    ./current --install ./kite-installer

WORKDIR /work