#!/bin/bash

gcta \
  --grm 1kg_eas \
  --pheno ../01_Dataset/1kgeas_binary.txt \
  --prevalence 0.4 \
  --reml \
  --out 1kg_eas
