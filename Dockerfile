FROM python:3.9

ENV PATH=/opt/poetry/bin:$PATH \
    POETRY_VERSION=1.8.2 \
    POETRY_HOME=/opt/poetry

RUN python3 -m venv $POETRY_HOME
RUN $POETRY_HOME/bin/pip install poetry==$POETRY_VERSION

RUN poetry --version
ENTRYPOINT ["python"]
CMD ["--version"]

WORKDIR /code
COPY ./src/poetry.lock ./src/pyproject.toml /code/

RUN poetry config virtualenvs.create false
RUN poetry install --no-interaction --no-ansi --only main
