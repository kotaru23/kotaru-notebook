FROM kotaru/machine-learning-notebook:latest

# Jupyter NotebookのExtensionの設定
RUN jupyter contrib nbextension install --user && \
    : "Jupyter NotebookのキーバインドをVim風に設定" && \
    mkdir -p $(jupyter --data-dir)/nbextensions && \
    cd $(jupyter --data-dir)/nbextensions && \
    git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding &&  \
    jupyter nbextension enable vim_binding/vim_binding && \
    : "Jupyter Notebookでプレゼンをするためのライブラリ" && \
    jupyter-nbextension install rise --py --sys-prefix && \
    jupyter-nbextension enable rise --py --sys-prefix && \
    : "セルごとに実行時間を測定" && \
    jupyter-nbextension enable execute_time/ExecuteTime  && \
    jupyter nbextension enable move_selected_cells/main && \
    jupyter nbextension enable toggle_all_line_numbers/main && \
    jupyter nbextension enable code_prettify/code_prettify && \
    jupyter nbextension enable scratchpad/main

WORKDIR /notebooks
EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
