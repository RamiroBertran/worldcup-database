#!/bin/bash
# Program to diff output against exected_output.txt
echo -e "\n~~~ Program to create file_n.txt and diff against expeted_ouput.txt ~~~\n"

echo -e "\n Insert the number of the test => Example text_1.txt, 'Only the number'\n"
echo -e "\n Last number of test are\n"
ls -t test

read X

DIFF_TEST_AGAINST_EXPECTED_OUTPUT() {
  ./query.sh > ./test/test_$X.txt
  }
DIFF_TEST_AGAINST_EXPECTED_OUTPUT 

diff expected_output.txt test/test_$X.txt

if [[ $? -gt 0 ]]
then 
echo "Error"
else 
echo "Success"
fi



