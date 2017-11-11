#!/bin/bash
for i in {1..423}
do
   # wget -O $i https://pokeapi.co/api/v2/evolution-chain/$i/
   python3 test.py $i
done