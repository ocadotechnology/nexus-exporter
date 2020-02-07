FROM python:3.7-alpine

WORKDIR /usr/src/app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY nexus_exporter.py /nexus_exporter.py

EXPOSE 9184

ENTRYPOINT ["/nexus_exporter.py"]