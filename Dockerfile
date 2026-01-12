FROM alpine:20251224

RUN date > build_date.txt

COPY touch touch

RUN cat touch >> build_date.txt

RUN cat build_date.txt

RUN apk add --no-cache openssl git vim

CMD ["cat", "build_date.txt"]