# FROM python:3.9
# don't pin to tag, pin to this
FROM python@sha256:b81bfd63a766f385494a585e154465bb7178c820c4cd1e9cb6a8c3daa62433b7

ENV PATH=/opt/poetry/bin:$PATH \
    POETRY_VERSION=1.8.2 \
    POETRY_HOME=/opt/poetry

RUN python3 -m venv $POETRY_HOME
RUN $POETRY_HOME/bin/pip install poetry==$POETRY_VERSION

RUN poetry --version

WORKDIR /code
COPY ./src/poetry.lock ./src/pyproject.toml /code/

RUN poetry config virtualenvs.create false
RUN poetry install --no-interaction --no-ansi --only main

ENTRYPOINT ["poetry", "run", "python"]
CMD ["--version"]
