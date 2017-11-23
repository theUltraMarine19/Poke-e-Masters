#!/bin/bash
psql -h localhost -p $1 -d postgres -f drop.sql
psql -h localhost -p $1 -d postgres -f create.sql
psql -h localhost -p $1 -d postgres -f pokemon.sql
psql -h localhost -p $1 -d postgres -f pokemonBaseExp.sql
psql -h localhost -p $1 -d postgres -f pokemonEvolve.sql
psql -h localhost -p $1 -d postgres -f attacks.sql
psql -h localhost -p $1 -d postgres -f pokemonMoves.sql
psql -h localhost -p $1 -d postgres -f typeEffect.sql
psql -h localhost -p $1 -d postgres -f item.sql
