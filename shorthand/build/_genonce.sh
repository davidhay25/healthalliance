#!/bin/bash
set -e
java -jar input-cache/org.hl7.fhir.publisher.jar -ig ig.ini

echo "zipping output..."

cd ~/IG/healthalliance/shorthand/build/output

zip -r -X archive.zip . > /dev/null

while true; do
    read -p "Do you wish to upload the zipped output to the server" yn
    case $yn in
        [Yy]* ) scp ~/IG/healthalliance/shorthand/build/output/archive.zip root@igs.clinfhir.com:/var/www/healthalliance; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
