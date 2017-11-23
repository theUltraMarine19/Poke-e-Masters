#!/bin/bash
psql -h localhost -p $1 -d postgres -f drop.sql
psql -h localhost -p $1 -d postgres -f create.sql
psql -h localhost -p $1 -d postgres -f pokemon.sql
#psql -h localhost -p $1 -d postgres -f pokemon_with_evolve.sql
psql -h localhost -p $1 -d postgres -f cities.sql
psql -h localhost -p $1 -d postgres -f attacks.sql
psql -h localhost -p $1 -d postgres -f pokemonMoves.sql
