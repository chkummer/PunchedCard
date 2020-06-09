# EPS_Functions.sh: some basic eps funtions for punchcard.sh script
#
# For more inforamtion see https://github.com/chkummer/PunchedCard
#
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

%%BeginProcSet
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
if [ ${DOCU_FLAG} -eq 1 ]
then
    TMP_PS_CMD="gsave fill grestore"
else
    TMP_PS_CMD="stroke"
fi
eval "sed 's/@@CUT_OUTLINE_COLOR@@/${CUT_OUTLINE_COLOR}/g;s/@@CUT_HOLE_COLOR@@/${CUT_HOLE_COLOR}/g' lib/${CARD_OUTLINE}_${CARD_CORNER}_CardOutline.ps"
cat <<=EPS_CUTTER_FUNCTS_EOF=
/Pos 0 def
/Hole 0 def

/hole
 { newpath moveto
   ${CUT_HOLE_COLOR} setrgbcolor
   0.25 setlinewidth
   -1.98 -4.5 rmoveto
   3.96 0 rlineto
   0 9 rlineto
   -3.96 0 rlineto
   0 -9 rlineto
   closepath
   ${TMP_PS_CMD} } def

/punchHole
 { /XPos Pos 6.264 mul 11.808 add def
   XPos [180 162 144 126 108 90 72 54 36 18 0 198 216] Hole get hole } def

=EPS_CUTTER_FUNCTS_EOF=
}

#
# EPS_PRINTER_FUNCTS
#
EPS_PRINTER_FUNCTS () {
eval "sed 's/@@CARD_TEXT_COLOR@@/${CARD_TEXT_COLOR}/g' lib/${CARD_TYPE}_CardType.ps"
cat <<=EPS_PRINTER_FUNCTS_EOF=
/DotMatrixPattern <00 00 00 00 00 00 00 00> def

/printDotMatrix
 { newpath
   /XPos Pos 6.264 mul 9 add def
   ${DOT_MATRIX_COLOR} setrgbcolor
   gsave
   XPos 225 translate
   6 6 scale
   8 8 true
   [8 0 0 8 0 0] { DotMatrixPattern } imagemask
   grestore } bind def


=EPS_PRINTER_FUNCTS_EOF=
}
