# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=bswrundquist/scipy-notebook-gpu
FROM $BASE_CONTAINER

LABEL maintainer="Emmanuel Benazera <emmanuel.benazera@jolibrain.com>"

# Install Tensorflow
RUN conda install --quiet --yes \
    'tensorflow-gpu=1.14*' \
    'keras' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN conda install pytorch torchvision cudatoolkit=10.0 -c pytorch

