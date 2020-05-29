#!/bin/bash
#
# punchcard.sh: UNIX shell script that reads a text file and generates postscript file(s) of punched cards.
#               These files may then be printed to paper and then be cut using a lasercutter.
#
# For more inforamtion see https://github.com/chkummer/PunchedCard
#
# default color values using postscript rgb schema
CUT_OUTLINE_COLOR="1 0 0" # red
CUT_HOLE_COLOR="0 0 1" # blue
CARD_TEXT_COLOR="0 0 0" # black
DOC_BORDER_COLOR="0 1 0" # green
DOT_MATRIX_COLOR="0.5 0.5 0.5" # gray
# default value for the card coding
CARD_CODE="IBM029"
# default value for the card type (background printing)
CARD_TYPE="IBM5081"
# default value for corner cut of the card (Left, Right, Both or Uncut)
CARD_CORNER="Left"
# card outline default is Round this may be changed by using the argument '-S' to change it to Square
CARD_OUTLINE="Round"
# input line number
INPUT_LINENUM=1
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
# USAGE: show script usage
#
USAGE () {
cat <<=USAGE_EOF=
usage: $0 [options]

options are:
 -i <file>      # input file name
 -c <code>      # card coding (default: ${CARD_CODE})
 -C <corners>   # card corners (default: ${CARD_CORNER})
 -S             # change from round to square corners
 -t <type>      # card type (default: ${CARD_TYPE})
 -o <outfile>   # output base file name (default: ${BASE_OUTFILE})
 -s             # split output
 -h             # this help text

=USAGE_EOF=
exit
}
#
# INIT_CARD: initialize punch card
#
INIT_CARD () {
PAGEBREAK_CARD_NUM=$((${OUT_PAGE_NUM} * 3))
if [ ${OUT_CARD_NUM} -gt ${PAGEBREAK_CARD_NUM} ]
then
    echo "showpage" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
    OUT_PAGE_NUM=`expr ${OUT_PAGE_NUM} + 1`
    if [ ${SPLIT_OUTPUT} -eq 1 ]
    then
        OUTFILE_NUM=`expr ${OUTFILE_NUM} + 1`
        OUTFILE_SEQNUM=`printf "%04d" ${OUTFILE_NUM}`
        CUTTER_OUTFILE="${BASE_OUTFILE}_cutter_${OUTFILE_SEQNUM}.eps"
        EPS_HEADER | tee ${OUTFILE} ${CUTTER_OUTFILE} >/dev/null
        EPS_CUTTER_FUNCTS | tee -a ${OUTFILE} ${CUTTER_OUTFILE} >/dev/null
        echo "%%EndProcSet" | tee -a ${OUTFILE} ${CUTTER_OUTFILE} >/dev/null
        EPS_INIT_PAGE | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
    else
        EPS_INIT_PAGE | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
    fi
fi
echo "%%Card: ${OUT_CARD_NUM}" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
CARD_NUM_ON_PAGE=$(( ${OUT_CARD_NUM} % 3 ))
case ${CARD_NUM_ON_PAGE} in
    1)    echo "30 520 translate" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null;;
    2)    echo "0 -245 translate" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null;;
    0)    echo "0 -245 translate" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null;;
esac
echo "cardOutline" | tee -a ${OUTFILE} ${CUTTER_OUTFILE} >/dev/null
echo "printLayout" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} >/dev/null
}
#
# checking for EPS Functions
#
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
while getopts i:c:C:t:o:Ssh option
do
    case "${option}" in
        i) INPUT_FILE=${OPTARG};;
        c) CARD_CODE=${OPTARG};;
        C) CARD_CORNER=${OPTARG};;
	S) CARD_OUTLINE="Square";;
        t) CARD_TYPE=${OPTARG};;
        o) BASE_OUTFILE=${OPTARG};;
        s) SPLIT_OUTPUT=1;;
        h) USAGE;;
    esac
done
#
# checking if all files are acessable
#
if [ -z "${INPUT_FILE}" ]
then
    echo "ERROR: no input file specified!"
    USAGE
    exit 1
fi
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
if [ ! -r lib/${CARD_OUTLINE}_${CARD_CORNER}_CardOutline.ps ]
then
    echo "ERROR: can't read lib/${CARD_OUTLINE}_${CARD_CORNER}_CardOutline.ps"
    CARD_CORNER_LIST=`ls lib/${CARD_OUTLINE}_*_CardOutline.ps | awk -F_ '{print $2}'`
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
EPS_CUTTER_FUNCTS | tee -a ${OUTFILE} ${CUTTER_OUTFILE} >/dev/null
EPS_PRINTER_FUNCTS | tee -a ${OUTFILE} ${PRINTER_OUTFILE} >/dev/null
echo "%%EndProcSet" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
EPS_INIT_PAGE | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
# read input file
cat ${INPUT_FILE} | while read INPUT_LINE || [[ -n ${INPUT_LINE} ]];
do
    INIT_CARD
    INPUT_LEN=`expr ${#INPUT_LINE} - 1`
    INPUT_POS=0
    while [ ${INPUT_POS} -le ${INPUT_LEN} ]
    do
        CURR_CHAR=${INPUT_LINE:${INPUT_POS}:1}
        CONVERT_CHAR
        echo "% Char: '${CURR_CHAR}'" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
        echo "/Pos `expr ${INPUT_POS} + 1` def" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
        echo "[${HOLES}] { /Hole exch def punchHole } forall" | tee -a ${OUTFILE} ${CUTTER_OUTFILE} >/dev/null
        echo "/DotMatrixPattern <${DOT_MATRIX}> def printDotMatrix" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} >/dev/null
        INPUT_POS=`expr ${INPUT_POS} + 1`
        if [ ${INPUT_POS} -eq 80 ]
        then
            echo "WARNING: line: '${INPUT_LINENUM}' is too long, ignoring rest of line"
            INPUT_POS=`expr ${INPUT_LEN} + 1`
        fi
    done
    INPUT_LINENUM=`expr ${INPUT_LINENUM} + 1`
    OUT_CARD_NUM=`expr ${OUT_CARD_NUM} + 1`
done
echo "showpage" | tee -a ${OUTFILE} ${PRINTER_OUTFILE} ${CUTTER_OUTFILE} >/dev/null
