#!/usr/bin/env bash

pdflatex p3.tex
bibtex p3
pdflatex p3.tex
pdflatex p3.tex

