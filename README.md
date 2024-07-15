# python-firestore-bigquery
A docker image with firestore and bigquery python library
docker image: [trulyliu/python-firestore-bigquery](https://hub.docker.com/r/trulyliu/python-firestore-bigquery)

# Base image
FROM [python:3.11-slim](https://hub.docker.com/_/python)

# requirements
```
bigquery==0.0.41
firebase-admin==6.5.0
numpy==1.26.4
```
# non-root image
```
USERNAME=runner
USER_UID=1000
USER_GID=1000
WORKDIR /app
```

# How to use
Dockerfile
```
FROM trulyliu/python-firestore-bigquery:latest
WORKDIR /app
ADD main.py .
CMD ["python", "./main.py"]

```