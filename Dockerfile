FROM ocaml/opam

RUN sudo apt-get update && sudo apt-get install -y nasm gdb

RUN opam init -a
RUN opam install utop

RUN mkdir -p /home/opam/project
WORKDIR /home/opam/project
