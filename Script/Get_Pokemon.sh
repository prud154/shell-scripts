#!/bin/bash
set -x
#Declare Start and Stop Ranges
echo "Declaring Stop & Start Ranges.."
STARTRANGE=$1
STOPRANGE=$2

#Run Curl Command to request POKEMON API to list names.
echo "Running The CURL Command...."
curl -sL "https://pokeapi.co/api/v2/pokemon/?offset=${STARTRANGE}&limit=${STOPRANGE}" | jq ".results[].name" -r
POKEMON_COUNT=$(curl -sL "https://pokeapi.co/api/v2/pokemon/?offset=${STARTRANGE}&limit=${STOPRANGE}" | jq ".results[].name" -r | wc -l)
echo "The POKEMON Count is $POKEMON_COUNT"
