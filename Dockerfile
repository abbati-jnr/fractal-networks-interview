# syntax=docker/dockerfile:1

ARG PYTHON_VERSION=3.11.5
# pull official base image
FROM python:${PYTHON_VERSION}-slim as base

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

# create directory for the app user
RUN mkdir -p /home/fractal_networks

# create the app user
RUN addgroup --system fractal && adduser --system --group fractal

# create the appropriate directories
ENV HOME=/home/fractal_networks
ENV APP_HOME=/home/fractal_networks/web
RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/static
WORKDIR $APP_HOME

# install system dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install postgis postgresql-15-postgis-scripts -y

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.cache/pip to speed up subsequent builds.
# Leverage a bind mount to requirements.txt to avoid having to copy them into
# into this layer.
RUN --mount=type=cache,target=/root/.cache/pip \
    --mount=type=bind,source=requirements.txt,target=requirements.txt \
    python -m pip install -r requirements.txt

# Switch to the non-privileged user to run the application.
#USER appuser

# copy entrypoint.sh
COPY ./entrypoint.sh .
RUN sed -i 's/\r$//g' $APP_HOME/entrypoint.sh
RUN chmod +x $APP_HOME/entrypoint.sh

# Copy the source code into the container.
COPY . $APP_HOME

# chown all the files to the app user
RUN chown -R fractal:fractal $APP_HOME

# change to the app user
USER fractal
