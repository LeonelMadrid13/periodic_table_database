#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --tuples-only -c"

if [[ -z $1 ]]
then
 echo -e "Please provide an element as an argument."
 exit
fi

if [[ $1 =~ ^[1-9]+$ ]]
then
  element=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements JOIN properties using(atomic_number) JOIN types USING(type_id) WHERE atomic_number = '$1'")
else
  element=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements JOIN properties using(atomic_number) JOIN types USING(type_id) WHERE name = '$1' or symbol = '$1'")
fi

if [[ -z $element ]]
then
 echo -e "I could not find that element in the database."
 exit
fi
