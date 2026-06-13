FROM python:3.11.9-bullseye

WORKDIR /app
COPY motd.txt .

ENTRYPOINT [ "/bin/bash", "-c" ]
CMD [ "cat motd.txt" ]
