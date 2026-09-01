#!/bin/bash
# archiveName => $1  (%<)
# archiveTail => $2  (%:e)
# archive     => $3  (%)
# path        => $4  (:p:h)

if [ $2 == c ]; then
    clear && gcc -Wall -Wextra $3 -o $4/$1 -lm && $4/$1
elif [ $2 == lisp ]; then
    clear && clisp $3
elif [ $2 == cpp ]; then
    clear && g++ -Wall -Wextra $3 -o $4/$1 -lm && $4/$1
elif [ $2 == scm ]; then
    clear && chicken-csi -s $3
elif [ $2 == hs ]; then
    clear && ghc -dynamic $3 && $4/$1
elif [ $2 == rs ]; then
    clear && rustc $3 && $4/$1
fi
