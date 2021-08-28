FROM dora56/jupyter-base

RUN manda install --quiet --yes \
    'opencv' \
    'scikit-image' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}

WORKDIR /work