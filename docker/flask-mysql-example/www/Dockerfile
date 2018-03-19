# Simple Flask container.
FROM python:2.7
LABEL maintainer="Daniel Lennart"

# Copy app files to the container
COPY app /opt/www
WORKDIR /opt/www

# Install dependencies for the project.
RUN pip install -r requirements.txt

EXPOSE 5000
CMD python index.py
