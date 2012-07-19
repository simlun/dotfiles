#!/bin/bash
set -e
F=$HOME/.gitconfig.local
if [ ! -f $F ];
then
    echo "$F was not found"
    read -p "Would you like to create it? (y/n)?" CONT
    if [ "$CONT" == "y" ]; then
        echo "[user]" > $F
        read -p "name = " NAME
        read -p "email = " EMAIL
        echo "    name = \"$NAME\"" >> $F
        echo "    email = \"$EMAIL\"" >> $F
        echo "The $F file was created with the following contents:"
        echo "---"
        cat $F
        echo "---"
    else
        echo "Ok, it won't be created. Note that the user.* variables are probably not set.";
    fi
fi
