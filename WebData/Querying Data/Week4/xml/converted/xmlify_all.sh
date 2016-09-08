#!/bin/bash
# file: xmlify_all.sh

python xmlify.py city 6 name country province population longitude latitude
python xmlify.py continent 2 name area
python xmlify.py country 6 name code capital province area population
python xmlify.py desert 4 name area longitude latitude
python xmlify.py economy 6 country gdp agriculture service industry inflation
python xmlify.py ethnicgroup 3 country name percentage
python xmlify.py island 7 name islands area height type longitude latitude
python xmlify.py lake 8 name area depth altitude type river longitude latitude
python xmlify.py language 3 country name percentage
python xmlify.py mountain 6 name mountains height type longitude latitude
python xmlify.py mountainonisland 2 mountain island
python xmlify.py organization 6 abbreviation name city country province established
python xmlify.py politics 4 country independence dependent government
python xmlify.py population 3 country population_growth infant_mortality
python xmlify.py province 6 name country population area capital capprov
python xmlify.py religion 3 country name percentage
python xmlify.py river 11 name river lake sea length sourcelongitude sourcelatitude mountains sourcealtitude estuarylongitude estuarylatitude
python xmlify.py sea 2 name depth
python xmlify.py borders 3 country1 country2 length
python xmlify.py encompasses 3 country continent percentage
python xmlify.py geo_desert 3 desert country province
python xmlify.py geo_estuary 3 river country province
python xmlify.py geo_island 3 island country province
python xmlify.py geo_lake 3 lake country province
python xmlify.py geo_mountain 3 mountain country province
python xmlify.py geo_river 3 river country province
python xmlify.py geo_sea 3 sea country province
python xmlify.py geo_source 3 river country province
python xmlify.py ismember 3 country organization type
python xmlify.py islandin 4 island sea lake river
python xmlify.py located 6 city province country river lake sea
python xmlify.py locatedon 4 city province country island
python xmlify.py mergeswith 2 sea1 sea2
