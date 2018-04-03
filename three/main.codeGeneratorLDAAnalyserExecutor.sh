#!/bin/bash

#  This script aim to apply LDA machine learning algorithm to a dataset provided by the 
#  Dundee City Council. This script and all its dependencies were wrote on the 
#  Dundee Public Data Hack
#  https://data.dundeecity.gov.uk/


# Structure:
# main.codeGeneratorLDAAnalyserExecutor.sh  
#      |---> tail
#      |---> header
#      |---> list-of-traders.csv

# This script  generates the Python script and runs its
# Example of expected result:
#
# Code generated AnalyseCorpusTradersDescription.py
# 
# Results of applying LDA-Topic modeling to the Farmers Traders Description
# 
# [(0, u'0.028*"homemade" + 0.022*"gin" + 0.022*"cake"'), (1, u'0.027*"fish" + 0.019*"smoked" + 0.019*"egg"'), (2, u'0.020*"au" + 0.020*"pain" + 0.020*"including"')]


# The output of this script requires to be copied to the head the dundeCorputs.py 
FILE="list-of-traders.csv"
PYTHONFILE="AnalyseCorpusTradersDescription.py"


# Building the Python code to analyse the text base description of
# the Farmer trader dataset provided by Dundee Council city
echo -e "Generating code of the Python script for LDA analysis"
cat header > $PYTHONFILE
nawk -F",http" '{ print $1}' $FILE  | grep -v  Website | sed 's/\r//g' | sed 's/\"//g' | nawk 'BEGIN{id=1}{print "doc"id" = \""$0"\""; id++;}' >> $PYTHONFILE
cat tail >> $PYTHONFILE

echo -e "Code generated "$PYTHONFILE
# Executing the analysis

echo -e "\nResults of applying LDA-Topic modeling to the Farmers Traders Description\n"
python $PYTHONFILE
