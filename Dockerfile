FROM debian:bullseye-20220622-slim as builder

RUN apt-get update && apt-get install -y make

COPY . /usr/src/build/

WORKDIR /usr/src/build/

RUN make -C fks-scripts install DESTDIR=/usr/src/dist/
RUN make -C fks-templates install DESTDIR=/usr/src/dist/
RUN make -C fks-texmf install DESTDIR=/usr/src/dist/

# Apply patches
COPY ./patches/gloss-czech.ldf /usr/src/dist/root/texmf/tex/latex/polyglossia/gloss-czech.ldf
COPY --chmod=777 ./patches/pdfbook /usr/src/dist/usr/local/bin/pdfbook

# Keep the static version to not trigger cache invalidations
FROM debian:bullseye-20220622-slim

# Install static files
RUN apt-get update && apt-get install -y \
    bash \
    fonts-sil-doulos \
    git \
    gnuplot \
    imagemagick \
    inkscape \
    ipe \
    libc-bin \
    lmodern \
    make \
    #pdfjam \
    perl \
    #pgf \
    python \
    sed \
    #texlive-base \
    #texlive-binaries \
    #texlive-extra-utils \
    #texlive-font-utils \
    #texlive-fonts-extra \
    #texlive-fonts-recommended \
    #texlive-lang-czechslovak \
    #texlive-lang-greek \
    #texlive-latex-base \
    #texlive-latex-extra \
    #texlive-latex-recommended \
    ##texlive-math-extra \
    #texlive-metapost \
    #texlive-pictures \
    #texlive-pstricks \
    #texlive-science \
    #texlive-xetex \
    texlive-full \
    wget \
    xsltproc \
&& rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/src/dist/ /

RUN mktexlsr

WORKDIR /usr/src/local