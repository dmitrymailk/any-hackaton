FROM python:3.8-alpine
ENV PATH="/scripts:${PATH}"
COPY ./requirements.txt /requirements.txt
# --virtual .tmp gcc libc-dev linux-header - они нужны только для установки зависимостей(wsgi), после
# установки мы удаляем их
# RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers
# RUN pip install -r requirements.txt
RUN \
  apk add --no-cache python3 postgresql-libs && \
  apk add --no-cache --virtual .build-deps gcc python3-dev musl-dev postgresql-dev && \
  python3 -m pip install -r requirements.txt --no-cache-dir && \
  apk --purge del .build-deps
# RUN apk del .tmp

RUN mkdir /app
COPY ./app /app
WORKDIR /app
COPY ./scripts /scripts

RUN chmod +x /scripts/*
# RUN mkdir -p /vol/web/media
# RUN mkdir -p /vol/web/static

RUN adduser -D user
# RUN chown -R user:user /vol
# RUN chmod -R 755 /vol/web

USER user
CMD ["entrypoint.sh"]
