FROM python:3.13-slim AS build

COPY /stuff/say.py say.py

RUN python3 say.py > message.txt

FROM scratch AS final
COPY --from=build /message.txt /message.txt
