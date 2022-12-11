FROM python:3.9

ENV PATH=/opt/poetry/bin:$PATH \
    POETRY_VERSION=1.3.0 \
    POETRY_HOME=/opt/poetry

RUN apt-get update && apt-get install --no-install-recommends -y curl \
    && curl -sSL https://install.python-poetry.org | python3 - \
    && rm -rf /var/lib/apt/lists/*


RUN poetry --version
ENTRYPOINT ["python"]
CMD ["--version"]

WORKDIR /code
COPY ./src/poetry.lock ./src/pyproject.toml /code/

RUN poetry config virtualenvs.create false
RUN poetry install --no-interaction --no-ansi
