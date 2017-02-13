#!/bin/bash

# ----------------------------------------------------
# My usbs mounting /run/media/chuck directory.
# We are copying /home/chuck/usbs directory , all usbs
# ----------------------------------------------------

usbs=/run/media/chuck
secretDirectory=/home/chuck/usbs

DATE=`date +%Y-%m-%d`

for usb in $(cd $usbs; ls -a); do
    if [ "$usb" = "." -o "$usb" = ".." ]; then
        echo "Unnecessary!: ${usb}"
    else
        echo "Okey. There are few usb!"
        echo $usb
        echo "Let's copying usb with Secretly:)))"
        if [ -d $secretDirectory ]; then
            newSecretDir="${secretDirectory}/${usb}-${DATE}"
            currentUsbDir="${usbs}/${usb}"
            echo "New Secret Dir: $newSecretDir"
            echo "Current Usb Dir: $currentUsbDir"
            #mkdir -p $newSecretDir
            cp -r $currentUsbDir $newSecretDir
        else
            echo "There isn't a Secret Directory!"
            echo "[-] Make Secret Directory? [y/n]: "
            read
            if [ "$REPLY" = "y" ]; then
                mkdir -p $secretDirectory
                echo "Please restarting this script!"
            fi
        fi
    fi
done
