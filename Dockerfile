FROM python:3.8

RUN python -m pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN rm ~/.cache/pip -rf
RUN useradd -ms /bin/bash runuser
WORKDIR /app/

COPY ./docker/requirements.txt ./

RUN pip install \
    --trusted-host pypi.org \
    --trusted-host pypi.python.org \
    --trusted-host=files.pythonhosted.org \
    --no-cache-dir \
    -r requirements.txt

COPY . .
RUN chown -R admin:admin /app
RUN chmod 755 /app
USER runuser
ENTRYPOINT [ "python", "privateGPT.py" ]