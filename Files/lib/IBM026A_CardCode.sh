# IBM026A_CardCode.sh: Card Code for IBM 026 A (Commercial)
#      ________________________________________________________________
#     /&-0123456789ABCDEFGHIJKLMNOPQR/STUVWXYZ #@    .¤    $*    ,%
#  Y / O           OOOOOOOOO                        OOOOOO
#  X|   O                   OOOOOOOOO                     OOOOOO
#  0|    O                           OOOOOOOOO      ?     ?     OOOOOO
#  1|     O        O        O        O
#  2|      O        O        O        O       O     ?     ?     O
#  3|       O        O        O        O       O     O     O     O
#  4|        O        O        O        O       O     O     O     O
#  5|         O        O        O        O       O     O     O     O
#  6|          O        O        O        O       O     O     O     O
#  7|           O        O        O        O       O     O     O     O
#  8|            O        O        O        O OOOOOOOOOOOOOOOOOOOOOOOO
#  9|             O        O        O        O
#   |__________________________________________________________________
# 
# For more information about Card Codes read:
#   http://homepage.divms.uiowa.edu/~jones/cards/codes.html
#
CONVERT_CHAR () {
case ${CURR_CHAR} in
    \ )  HOLES="";       DOT_MATRIX="00 00 00 00 00 00 00 00";;
    \&)  HOLES="12";     DOT_MATRIX="00 34 48 54 20 50 50 20";;
    -)   HOLES="11";     DOT_MATRIX="00 00 00 00 7C 00 00 00";;
    0)   HOLES="0";      DOT_MATRIX="00 38 44 44 44 44 44 38";;
    1)   HOLES="1";      DOT_MATRIX="00 38 10 10 10 10 30 10";;
    2)   HOLES="2";      DOT_MATRIX="00 7C 40 40 38 04 44 38";;
    3)   HOLES="3";      DOT_MATRIX="00 38 44 04 18 04 44 38";;
    4)   HOLES="4";      DOT_MATRIX="00 08 08 7C 48 28 18 08";;
    5)   HOLES="5";      DOT_MATRIX="00 38 44 04 04 78 40 7C";;
    6)   HOLES="6";      DOT_MATRIX="00 38 44 44 78 40 20 18";;
    7)   HOLES="7";      DOT_MATRIX="00 20 20 20 10 08 04 7C";;
    8)   HOLES="8";      DOT_MATRIX="00 38 44 44 38 44 44 38";;
    9)   HOLES="9";      DOT_MATRIX="00 30 08 04 3C 44 44 38";;
    A)   HOLES="12 1";   DOT_MATRIX="00 44 44 7C 44 44 28 10";;
    B)   HOLES="12 2";   DOT_MATRIX="00 38 24 24 38 24 24 78";;
    C)   HOLES="12 3";   DOT_MATRIX="00 38 44 40 40 40 44 38";;
    D)   HOLES="12 4";   DOT_MATRIX="00 78 24 24 24 24 24 78";;
    E)   HOLES="12 5";   DOT_MATRIX="00 7C 40 40 78 40 40 7C";;
    F)   HOLES="12 6";   DOT_MATRIX="00 40 40 40 78 40 40 7C";;
    G)   HOLES="12 7";   DOT_MATRIX="00 3C 44 44 4C 40 40 3C";;
    H)   HOLES="12 8";   DOT_MATRIX="00 44 44 44 7C 44 44 44";;
    I)   HOLES="12 9";   DOT_MATRIX="00 10 10 10 10 10 10 10";;
    J)   HOLES="11 1";   DOT_MATRIX="00 38 44 04 04 04 04 04";;
    K)   HOLES="11 2";   DOT_MATRIX="00 44 48 50 60 50 48 44";;
    L)   HOLES="11 3";   DOT_MATRIX="00 7C 40 40 40 40 40 40";;
    M)   HOLES="11 4";   DOT_MATRIX="00 44 44 44 54 54 6C 44";;
    N)   HOLES="11 5";   DOT_MATRIX="00 44 44 44 4C 54 64 44";;
    O)   HOLES="11 6";   DOT_MATRIX="00 38 44 44 44 44 44 38";;
    P)   HOLES="11 7";   DOT_MATRIX="00 40 40 40 78 44 44 78";;
    Q)   HOLES="11 8";   DOT_MATRIX="00 34 48 54 44 44 44 38";;
    R)   HOLES="11 9";   DOT_MATRIX="00 44 48 50 78 44 44 78";;
    /)   HOLES="0 1";    DOT_MATRIX="00 00 40 20 10 08 04 00";;
    S)   HOLES="0 2";    DOT_MATRIX="00 38 44 08 10 20 44 38";;
    T)   HOLES="0 3";    DOT_MATRIX="00 10 10 10 10 10 10 7C";;
    U)   HOLES="0 4";    DOT_MATRIX="00 38 44 44 44 44 44 44";;
    V)   HOLES="0 5";    DOT_MATRIX="00 10 10 28 28 44 44 44";;
    W)   HOLES="0 6";    DOT_MATRIX="00 44 6C 54 44 44 44 44";;
    X)   HOLES="0 7";    DOT_MATRIX="00 44 44 28 10 28 44 44";;
    Y)   HOLES="0 8";    DOT_MATRIX="00 10 10 10 10 28 44 44";;
    Z)   HOLES="0 9";    DOT_MATRIX="00 7C 40 20 10 08 04 7C";;
    \#)  HOLES="8 3";    DOT_MATRIX="00 28 28 6C 00 6C 28 28";;
    @)   HOLES="8 4";    DOT_MATRIX="00 38 54 54 34 04 44 38";;
    .)   HOLES="12 8 3"; DOT_MATRIX="00 30 30 00 00 00 00 00";;
    ¤)   HOLES="12 8 4"; DOT_MATRIX="00 44 38 28 28 28 38 44";;
    \$)  HOLES="11 8 3"; DOT_MATRIX="00 10 78 04 38 40 3C 10";;
    \*)  HOLES="11 8 4"; DOT_MATRIX="00 00 00 54 38 38 38 54";;
    ,)   HOLES="0 8 3";  DOT_MATRIX="00 20 10 30 30 00 00 00";;
    %)   HOLES="0 8 4";  DOT_MATRIX="00 4C 4C 20 10 08 64 64";;
    *)   HOLES="0 8 2";  DOT_MATRIX="00 00 00 00 00 00 00 00"; echo "WARNING: can not convert char '${CURR_CHAR}' at line: '${INPUT_LINENUM}' pos: '${INPUT_POS}'";;
esac
}
