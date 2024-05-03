# FROM python:3.9
# don't pin to tag, pin to this
FROM python@sha256:b81bfd63a766f385494a585e154465bb7178c820c4cd1e9cb6a8c3daa62433b7 as requirements

ENV PATH=/opt/poetry/bin:$PATH \
    POETRY_VERSION=1.8.2 \
    POETRY_HOME=/opt/poetry \
    POETRY_WARNINGS_EXPORT=false

RUN python3 -m venv $POETRY_HOME
RUN $POETRY_HOME/bin/pip install poetry==$POETRY_VERSION
RUN poetry self add poetry-plugin-export

RUN poetry --version

COPY ./src/poetry.lock ./src/pyproject.toml ./

RUN poetry export -f requirements.txt --without-hashes -o requirements.txt


FROM python@sha256:b81bfd63a766f385494a585e154465bb7178c820c4cd1e9cb6a8c3daa62433b7 as pdmeinstall

ENV PDME_HOME=/opt/pdme
ENV PATH=${PDME_HOME}/bin:$PATH

RUN python3 -m venv ${PDME_HOME}
COPY --from=requirements requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
