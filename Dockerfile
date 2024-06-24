FROM python:3.9
RUN useradd -m -u 1000 user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

COPY ./requirements.txt ~/app/requirements.txt
WORKDIR $HOME/app
RUN chown -R user:user $HOME/app/
COPY --chown=user . $HOME/app/
USER user
RUN pip install -r requirements.txt
RUN pip install -qU qdrant-client
RUN pip install -qU pymupdf
COPY --chown=user . .
CMD ["chainlit", "run", "app.py", "--port", "7860"]