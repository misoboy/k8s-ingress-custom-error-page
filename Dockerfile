FROM alpine

RUN apk update && apk add bash

COPY /rootfs /

ADD custom-error-pages /
CMD ["/custom-error-pages"]