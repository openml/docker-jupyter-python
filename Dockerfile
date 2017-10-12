FROM jupyter/scipy-notebook:18e5563b7486
MAINTAINER "Andrey Ustyuzhanin" <anaderi@yandex-team.ru>

#RUN conda install -y -q r-cairo r-ggplot2 r-dplyr r-rpart gcc
#RUN conda install -y -q -c damianavila82 rise

COPY version environment.yml start_jupyter_or_everware.sh $HOME/
RUN conda env create -n openml_py3 --file environment.yml && \
    echo "source activate openml_py3" >> ~/.bashrc

USER root
RUN apt-get update && \
    apt-get install -y xvfb pkg-config less jq && \
    mkdir -p /notebooks && chown jovyan /notebooks
USER jovyan
WORKDIR $HOME

CMD bash -c "$HOME/start_jupyter_or_everware.sh"
