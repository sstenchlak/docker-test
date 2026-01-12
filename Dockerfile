FROM alpine:20251224

RUN date > build_date.txt

COPY touch touch

RUN cat touch >> build_date.txt

RUN cat build_date.txt

CMD ["cat", "build_date.txt"]