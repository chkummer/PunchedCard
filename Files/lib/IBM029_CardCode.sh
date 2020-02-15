# IBM029_CardCode.sh: Card Code for IBM 029
#      ________________________________________________________________
#     /&-0123456789ABCDEFGHIJKLMNOPQR/STUVWXYZ:#@'="¢.<(+|!$*);¬ ,%_>?
# 12 / O           OOOOOOOOO                        OOOOOO
# 11|   O                   OOOOOOOOO                     OOOOOO
#  0|    O                           OOOOOOOOO                  OOOOOO
#  1|     O        O        O        O                                 
#  2|      O        O        O        O       O     O     O     O
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
    \&)  HOLES="12";     DOT_MATRIX="00 34 48 54 20 50 48 30";;
    -)   HOLES="11";     DOT_MATRIX="00 00 00 00 7C 00 00 00";;
    0)   HOLES="0";      DOT_MATRIX="00 38 44 64 54 4C 44 38";;
    1)   HOLES="1";      DOT_MATRIX="00 38 10 10 10 10 30 10";;
    2)   HOLES="2";      DOT_MATRIX="00 7C 20 10 08 04 44 38";;
    3)   HOLES="3";      DOT_MATRIX="00 38 44 04 08 10 08 7C";;
    4)   HOLES="4";      DOT_MATRIX="00 08 08 7C 48 28 18 08";;
    5)   HOLES="5";      DOT_MATRIX="00 38 44 04 04 78 40 7C";;
    6)   HOLES="6";      DOT_MATRIX="00 38 44 44 78 40 20 18";;
    7)   HOLES="7";      DOT_MATRIX="00 20 20 20 10 08 04 7C";;
    8)   HOLES="8";      DOT_MATRIX="00 38 44 44 38 44 44 38";;
    9)   HOLES="9";      DOT_MATRIX="00 30 08 04 38 44 44 38";;
    A)   HOLES="12 1";   DOT_MATRIX="00 44 44 7C 44 44 44 38";;
    B)   HOLES="12 2";   DOT_MATRIX="00 78 44 44 78 44 44 78";;
    C)   HOLES="12 3";   DOT_MATRIX="00 38 44 40 40 40 44 38";;
    D)   HOLES="12 4";   DOT_MATRIX="00 70 48 44 44 44 48 70";;
    E)   HOLES="12 5";   DOT_MATRIX="00 7C 40 40 78 40 40 7C";;
    F)   HOLES="12 6";   DOT_MATRIX="00 40 40 40 78 40 40 7C";;
    G)   HOLES="12 7";   DOT_MATRIX="00 3C 44 44 5C 40 44 38";;
    H)   HOLES="12 8";   DOT_MATRIX="00 44 44 44 7C 44 44 44";;
    I)   HOLES="12 9";   DOT_MATRIX="00 38 10 10 10 10 10 38";;
    J)   HOLES="11 1";   DOT_MATRIX="00 30 48 08 08 08 08 1C";;
    K)   HOLES="11 2";   DOT_MATRIX="00 44 48 50 60 50 48 44";;
    L)   HOLES="11 3";   DOT_MATRIX="00 7C 40 40 40 40 40 40";;
    M)   HOLES="11 4";   DOT_MATRIX="00 44 44 44 54 54 6C 44";;
    N)   HOLES="11 5";   DOT_MATRIX="00 44 44 4C 54 64 44 44";;
    O)   HOLES="11 6";   DOT_MATRIX="00 38 44 44 44 44 44 38";;
    P)   HOLES="11 7";   DOT_MATRIX="00 40 40 40 78 44 44 78";;
    Q)   HOLES="11 8";   DOT_MATRIX="00 34 48 54 44 44 44 38";;
    R)   HOLES="11 9";   DOT_MATRIX="00 44 48 50 78 44 44 78";;
    /)   HOLES="0 1";    DOT_MATRIX="00 00 40 20 10 08 04 00";;
    S)   HOLES="0 2";    DOT_MATRIX="00 78 04 04 38 40 40 3C";;
    T)   HOLES="0 3";    DOT_MATRIX="00 10 10 10 10 10 10 7C";;
    U)   HOLES="0 4";    DOT_MATRIX="00 38 44 44 44 44 44 44";;
    V)   HOLES="0 5";    DOT_MATRIX="00 10 28 44 44 44 44 44";;
    W)   HOLES="0 6";    DOT_MATRIX="00 28 54 54 44 44 44 44";;
    X)   HOLES="0 7";    DOT_MATRIX="00 44 44 28 10 28 44 44";;
    Y)   HOLES="0 8";    DOT_MATRIX="00 10 10 10 28 44 44 44";;
    Z)   HOLES="0 9";    DOT_MATRIX="00 7C 40 20 10 08 04 7C";;
    :)   HOLES="8 2";    DOT_MATRIX="00 00 30 30 00 30 30 00";;
    \#)  HOLES="8 3";    DOT_MATRIX="00 28 28 7C 28 7C 28 28";;
    @)   HOLES="8 4";    DOT_MATRIX="00 38 54 54 34 04 44 38";;
    \')  HOLES="8 5";    DOT_MATRIX="00 00 00 00 00 20 10 30";;
    \=)  HOLES="8 6";    DOT_MATRIX="00 00 00 7C 00 7C 00 00";;
    \")  HOLES="8 7";    DOT_MATRIX="00 00 00 00 00 28 28 28";;
    ¢)   HOLES="12 8 2"; DOT_MATRIX="00 10 38 50 50 50 38 10";;
    .)   HOLES="12 8 3"; DOT_MATRIX="00 30 30 00 00 00 00 00";;
    \<)  HOLES="12 8 4"; DOT_MATRIX="00 08 10 20 40 20 10 08";;
    \()  HOLES="12 8 5"; DOT_MATRIX="00 08 10 20 20 20 10 08";;
    +)   HOLES="12 8 6"; DOT_MATRIX="00 00 10 10 7C 10 10 00";;
    \|)  HOLES="12 8 7"; DOT_MATRIX="00 10 10 10 10 10 10 10";;
    !)   HOLES="11 8 2"; DOT_MATRIX="00 10 00 00 10 10 10 10";;
    \$)  HOLES="11 8 3"; DOT_MATRIX="00 10 78 14 38 50 3C 10";;
    \*)  HOLES="11 8 4"; DOT_MATRIX="00 00 10 54 38 54 10 00";;
    \))  HOLES="11 8 5"; DOT_MATRIX="00 20 10 08 08 08 10 20";;
    \;)  HOLES="11 8 6"; DOT_MATRIX="00 20 10 30 00 30 30 00";;
    ¬)   HOLES="11 8 7"; DOT_MATRIX="00 00 00 00 00 00 04 7C";;
    \ )  HOLES="0 8 2";  DOT_MATRIX="00 00 00 00 00 00 00 00";;
    ,)   HOLES="0 8 3";  DOT_MATRIX="00 20 10 30 00 00 00 00";;
    %)   HOLES="0 8 4";  DOT_MATRIX="00 0C 4C 20 10 08 64 60";;
    _)   HOLES="0 8 5";  DOT_MATRIX="00 7C 00 00 00 00 00 00";;
    \>)  HOLES="0 8 6";  DOT_MATRIX="00 40 20 10 08 10 20 40";;
    \?)  HOLES="0 8 7";  DOT_MATRIX="00 10 00 10 08 04 44 38";;
    *)   HOLES="";       DOT_MATRIX="FE 82 82 82 82 82 82 FE"; echo "WARNING: can not convert char '${CURR_CHAR}' at line: '${INPUT_LINENUM}' pos: '${INPUT_POS}'";;
esac
}
