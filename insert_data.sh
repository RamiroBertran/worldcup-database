#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=kvothe_snow --dbname=worldcup -t --no-align -c"
fi

echo "$($PSQL "TRUNCATE games, teams")"

# Do not change code above this line. Use the PSQL variable above to query your database.


# INSERT TEAMS INTO TEAMS TABLE 


cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENTS_GOALS
do 
	if [[ $WINNER != "winner" ]] 
	then
		# Check if team winner is already on table 
		#
		TEAM_ID="$($PSQL "SELECT team_id FROM teams WHERE team_name='$WINNER'")"

		# if is not there
		if [[ -z $TEAM_ID ]]
		then
			INSERT_TEAM_NAME="$($PSQL "INSERT INTO teams(team_name) VALUES('$WINNER')")"
		fi
		# Check if opponent teams are already in table 
		TEAM_ID="$($PSQL "SELECT team_id FROM teams WHERE team_name='$OPPONENT'")"
		if [[ -z $TEAM_ID ]]
		then
			INSERT_TEAM_NAME="$($PSQL "INSERT INTO teams(team_name) VALUES('$OPPONENT')")"
		fi

	fi

done 

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
	if [[ $YEAR != 'year' ]]
	then
		# Get WINNER AND OPPONENT ID 
		WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE team_name='$WINNER'")"
		OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE team_name='$OPPONENT'")"
		# Insert values into table 
		INSERT_VALUES_RESULT="$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")"
		echo -e "\nInserted into Games: '$YEAR', '$ROUND', '$WINNER_ID', '$OPPONENT_ID', '$WINNER_GOALS', '$OPPONENT_GOALS'"
	fi
done



