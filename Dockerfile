FROM alpine:3.10

COPY /rootfs /

ADD custom-error-pages /
CMD ["/custom-error-pages"]