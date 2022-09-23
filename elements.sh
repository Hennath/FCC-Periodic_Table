PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# check if the script was called with an argument
if [[ $1 ]]
# there is an argument
then
  ELEMENT_RESULT=$($PSQL "SELECT * FROM elements
    INNER JOIN properties USING (atomic_number)
    INNER JOIN types USING (type_id)
    WHERE symbol='$1' OR name='$1' OR atomic_number::varchar='$1'") # check if the argument is either atomic_number symbol or name of an element
  
  # check if there is a result in the database
  if [[ -z $ELEMENT_RESULT ]]
  # there is no result
  then
    # message that the the element could'nt be found
    echo I could not find that element in the database.
  
  # the element exists in the database
  else
    # read the columns into variables
    echo "$ELEMENT_RESULT" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING BAR BOILING BAR TYPE
      do
        # print a message with the elemnt's attributes
        echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
  fi
# there is no argument
else
  # print a message to ask for an argument
  echo Please provide an element as an argument.
fi