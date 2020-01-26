#!/bin/bash
#
# punchcard.sh: UNIX shell script that reads a text file and generates postscript file(s) of punched cards.
#               These files may then be printed to paper and then be cut using a lasercutter.
#
# For more inforamtion see https://github.com/chkummer/PunchedCard
#
INPUT_LINE="THIS IS JUST A TEST"
# default color values using postscript rgb schema
CUT_COLOR="1 0 0" # red
CARD_TEXT_COLOR="0 0 0" # black
DOC_BORDER_COLOR="0 1 0" # green
# default value for the card coding
CARD_CODE="IBM029"
# default value for the card type (background printing)
CARD_TYPE="IBM5081"
# default value for corner cut of the card (Left, Right, Both or Uncut
CARD_CORNER="Left"
# default output file name
OUTFILE="punchcard.eps"
# default page size in postscript points
OUT_PAGE_WIDTH="595" # DIN-A4=595
OUT_PAGE_HEIGHT="842" # DIN-A4=842
# default start page number
OUT_PAGE_NUM=1
OUT_CARD_NUM=1
# get current date for CREATION_DATE
CREATION_DATE=`date '+%d-%b-%Y'`
#
# Shell Functions
#
# EPS_HEADER
#
EPS_HEADER () {
cat <<=EPS_HEADER_EOF=
%!PS-Adobe-2.0 EPSF-1.2
%%Title: PunchedCard (${OUTFILE})
%%Creator: punchcard.sh (https://github.com/chkummer/PunchedCard)
%%CreationDate: ${CREATION_DATE}
%%BoundingBox: 0 0 ${OUT_PAGE_WIDTH} ${OUT_PAGE_HEIGHT}
%%EndComments

=EPS_HEADER_EOF=
}
#
# EPS_INIT_PAGE
#
EPS_INIT_PAGE () {
cat <<=EPS_INIT_PAGE_EOF= 
%%Page: ${OUT_PAGE_NUM}
0.5 setlinewidth
${DOC_BORDER_COLOR} setrgbcolor
newpath
0 0 moveto
${OUT_PAGE_WIDTH} 0 lineto
${OUT_PAGE_WIDTH} ${OUT_PAGE_HEIGHT} lineto
0 ${OUT_PAGE_HEIGHT} lineto
closepath stroke
=EPS_INIT_PAGE_EOF=
}
#
# EPS_CUTTER_FUNCTS
#
EPS_CUTTER_FUNCTS () {
cat <<=EPS_CUTTER_FUNCTS_EOF=
/Pos 0 def
/Hole 0 def

/hole
 { newpath moveto
   ${CUT_COLOR} setrgbcolor
   0.25 setlinewidth
   -1.98 -4.5 rmoveto
   3.96 0 rlineto
   0 9 rlineto
   -3.96 0 rlineto
   0 -9 rlineto
   closepath
   stroke } def

/punchHole
 { /XPos Pos 6.264 mul 11.808 add def
   XPos [180 162 144 126 108 90 72 54 36 18 0 198 218] Hole get hole } def

=EPS_CUTTER_FUNCTS_EOF=
}
#
# EPS_PRINTER_FUNCTS
#
EPS_PRINTER_FUNCTS () {
cat <<=EPS_PRINTER_FUNCTS_EOF=
/DotMatrixPattern <00 00 00 00 00 00 00 00> def

/printDotMatrix
 { newpath
   /XPos Pos 6.264 mul 9 add def
   ${CARD_TEXT_COLOR} setrgbcolor
   gsave
   XPos 225 translate
   6 6 scale
   8 8 true
   [8 0 0 8 0 0] { DotMatrixPattern } imagemask
   grestore } bind def


=EPS_PRINTER_FUNCTS_EOF=
}
#
# Main
#
if [ -r lib/${CARD_CODE}_CardCode.sh ]
then
    . lib/${CARD_CODE}_CardCode.sh
fi
EPS_HEADER > ${OUTFILE}
echo "%%BeginProcSet" >> ${OUTFILE}
eval "sed 's/@@CUT_COLOR@@/${CUT_COLOR}/g' lib/${CARD_CORNER}_CardOutline.ps >> ${OUTFILE}"
EPS_CUTTER_FUNCTS >> ${OUTFILE}
eval "sed 's/@@CARD_TEXT_COLOR@@/${CARD_TEXT_COLOR}/g' lib/${CARD_TYPE}_CardType.ps >> ${OUTFILE}"
EPS_PRINTER_FUNCTS >> ${OUTFILE}
echo "%%EndProcSet" >> ${OUTFILE}
echo "" >> ${OUTFILE}
EPS_INIT_PAGE >> ${OUTFILE}
echo "%%Card: ${OUT_CARD_NUM}" >> ${OUTFILE}
echo "30 520 translate" >> ${OUTFILE}
echo "cardOutline" >> ${OUTFILE}
echo "printLayout" >> ${OUTFILE}
INPUT_LEN=`expr ${#INPUT_LINE} - 1`
INPUT_POS=0
while [ ${INPUT_POS} -le ${INPUT_LEN} ]
do
    CURR_CHAR=${INPUT_LINE:${INPUT_POS}:1}
    CONVERT_CHAR
    echo "/Pos `expr ${INPUT_POS} + 1` def" >> ${OUTFILE}
    echo "[${HOLES}] { /Hole exch def punchHole} forall" >> ${OUTFILE}
    echo "/DotMatrixPattern <${DOT_MATRIX}> def printDotMatrix" >> ${OUTFILE}
    INPUT_POS=`expr ${INPUT_POS} + 1`
done
echo "showpage" >> ${OUTFILE}

