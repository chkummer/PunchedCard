#!/bin/bash
#
# punchcard.sh: UNIX shell script that reads a text file and generates postscript file(s) of punched cards.
#               These files may then be printed to paper and then be cut using a lasercutter.
#
# For more inforamtion see https://github.com/chkummer/PunchedCard
#
INPUT_LINE="&-0123456789ABCDEFGHIJKLMNOPQR/STUVWXYZ:#@'=\"¢.<(+|!$*);¬ ,%_>?"
# default color values using postscript rgb schema
CUT_COLOR="1 0 0" # red
CARD_TEXT_COLOR="0 0 0" # black
DOC_BORDER_COLOR="0 1 0" # green
DOT_MATRIX_COLOR="0.5 0.5 0.5" # gray
# default value for the card coding
CARD_CODE="IBM029"
# default value for the card type (background printing)
CARD_TYPE="IBM5081"
# default value for corner cut of the card (Left, Right, Both or Uncut
CARD_CORNER="Left"
# split output for printer and cutter (0=no, 1=yes)
SPLIT_OUTPUT=0
# default output file name
BASE_OUTFILE="punchcard"
OUTFILE="${BASE_OUTFILE}.eps"
OUTFILE_NUM=1
# default page size in postscript points
OUT_PAGE_WIDTH="595" # DIN-A4=595
OUT_PAGE_HEIGHT="842" # DIN-A4=842
# line number on input file
INPUT_LINE_NUM=1
# default start page number
OUT_PAGE_NUM=1
OUT_CARD_NUM=1
# get current date for CREATION_DATE
CREATION_DATE=`date '+%d-%b-%Y'`
# 
# Shell Functions
#
# USAGE
#
USAGE () {
cat <<=USAGE_EOF=
usage: $0 [options]

options are:
 -i <file>      # input file name
 -c <code>      # card coding (default: ${CARD_CODE})
 -C <corners>   # card corners (default: ${CARD_CORNER})
 -t <type>      # card type (default: ${CARD_TYPE})
 -o <outfile>   # output base file name (default: ${BASE_OUTFILE})
 -s             # split output
 -h             # this help text

=USAGE_EOF=
exit
}
if [ -r lib/EPS_Functions.sh ]
then
    . lib/EPS_Functions.sh
else
    echo "ERROR: can't read lib/EPS_Functions.sh"
    exit 1
fi
#
# Main
#
while getopts i:c:C:t:o:sh option
do
    case "${option}" in
        i) INPUT_FILE=${OPTARG};;
        c) CARD_CODE=${OPTARG};;
        C) CARD_CORNER=${OPTARG};;
        t) CARD_TYPE=${OPTARG};;
        o) BASE_OUTFILE=${OPTARG};;
        s) SPLIT_OUTPUT=1;;
        h) USAGE;;
    esac
done
#
# checking if all files are acessable
#
if [ -r ${INPUT_FILE} ]
then
    if [ ${SPLIT_OUTPUT} -eq 1 ]
    then
        OUTFILE_SEQNUM=`printf "%04d" ${OUTFILE_NUM}`
        PRINTER_OUTFILE="${BASE_OUTFILE}_printer.eps"
        CUTTER_OUTFILE="${BASE_OUTFILE}_cutter_${OUTFILE_SEQNUM}.eps"
        OUTFILE="/dev/null"
    else
        PRINTER_OUTFILE="/dev/null"
        CUTTER_OUTFILE="/dev/null"
        OUTFILE="${BASE_OUTFILE}.eps"
    fi 
else
    echo "ERROR: can't read input file '${INPUT_FILE}'"
    exit 1
fi
if [ -r lib/${CARD_CODE}_CardCode.sh ]
then
    . lib/${CARD_CODE}_CardCode.sh
else
    echo "ERROR: can't read lib/${CARD_CODE}_CardCode.sh"
    CARD_CODE_LIST=`ls lib/*_CardCode.sh | sed 's?^.*lib/??g;s?_CardCode.sh??g'`
    echo "Valid Card Codes are:"
    for CARD_CODE_ITEM in ${CARD_CODE_LIST}
    do
        echo " - ${CARD_CODE_ITEM}"
    done
    exit 1
fi
if [ ! -r lib/${CARD_CORNER}_CardOutline.ps ]
then
    echo "ERROR: can't read lib/${CARD_CORNER}_CardOutline.ps"
    CARD_CORNER_LIST=`ls lib/*_CardOutline.ps | sed 's?^.*lib/??g;s?_CardOutline.ps??g'`
    echo "Valid Card Corners are:"
    for CARD_CORNER_ITEM in ${CARD_CORNER_LIST}
    do
        echo " - ${CARD_CORNER_ITEM}"
    done
    exit 1
fi
if [ ! -r lib/${CARD_TYPE}_CardType.ps ]
then
    echo "ERROR: can't read lib/${CARD_TYPE}_CardType.ps"
    CARD_TYPE_LIST=`ls lib/*_CardType.ps | sed 's?^.*lib/??g;s?_CardType.ps??g'`
    echo "Valid Card Types are:"
    for CARD_TYPE_ITEM in ${CARD_TYPE_LIST}
    do
        echo " - ${CARD_TYPE_ITEM}"
    done
    exit 1
fi
#
# all required files are available; let's go and create some output
#
EPS_HEADER | tee ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
echo "%%BeginProcSet" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
eval "sed 's/@@CUT_COLOR@@/${CUT_COLOR}/g' lib/${CARD_CORNER}_CardOutline.ps | tee -a ${OUTFILE} ${CUTTER_OUTFILE} >/dev/null"
EPS_CUTTER_FUNCTS | tee -a ${OUTFILE} ${CUTTER_OUTFILE} >/dev/null
eval "sed 's/@@CARD_TEXT_COLOR@@/${CARD_TEXT_COLOR}/g' lib/${CARD_TYPE}_CardType.ps | tee -a ${OUTFILE} ${PRINTER_OUTFILE} >/dev/null"
EPS_PRINTER_FUNCTS | tee -a ${OUTFILE} ${PRINTER_OUTFILE} >/dev/null
echo "%%EndProcSet\n" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
EPS_INIT_PAGE | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
echo "%%Card: ${OUT_CARD_NUM}" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
echo "30 520 translate" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
echo "cardOutline" | tee -a ${OUTFILE} ${CUTTER_OUTFILE} >/dev/null
echo "printLayout" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} >/dev/null
INPUT_LEN=`expr ${#INPUT_LINE} - 1`
INPUT_POS=0
# cat ${INPUT_FILE} | while read ${INPUT_LINE} || [[ -n ${INPUT_LINE} ]];
while [ ${INPUT_POS} -le ${INPUT_LEN} ]
do
    CURR_CHAR=${INPUT_LINE:${INPUT_POS}:1}
    CONVERT_CHAR
    echo "/Pos `expr ${INPUT_POS} + 1` def" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
    echo "[${HOLES}] { /Hole exch def punchHole} forall" | tee -a ${OUTFILE} ${CUTTER_OUTFILE} >/dev/null
    echo "/DotMatrixPattern <${DOT_MATRIX}> def printDotMatrix" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} >/dev/null
    INPUT_POS=`expr ${INPUT_POS} + 1`
done
echo "showpage" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
