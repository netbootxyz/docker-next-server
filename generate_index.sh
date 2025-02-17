#!/bin/sh

# Generate index.html with ASCII logo and support message
echo "<pre>" > /httpboot/index.html
echo "                                                         " >> /httpboot/index.html
echo "            _   _                 _                      " >> /httpboot/index.html
echo " _ __   ___| |_| |__   ___   ___ | |_  __  ___   _ ____  " >> /httpboot/index.html
echo "| '_ \ / _ \ __| '_ \ / _ \ / _ \| __| \ \/ / | | |_  /  " >> /httpboot/index.html
echo "| | | |  __/ |_| |_) | (_) | (_) | |_ _ >  <| |_| |/ /   " >> /httpboot/index.html
echo "|_| |_|\___|\__|_.__/ \___/ \___/ \__(_)_/\_\\__,  /___| " >> /httpboot/index.html
echo "                                             |___/       " >> /httpboot/index.html
echo "</pre>" >> /httpboot/index.html
echo
echo "<p>This directory listing contains both latest netboot.xyz binaries and upstream iPXE files.</p>" >> /httpboot/index.html
echo "<ul>" >> /httpboot/index.html
for file in /httpboot/*; do
    filename=$(basename "$file")
    echo "<li><a href=\"$filename\">$filename</a></li>" >> /httpboot/index.html
done
echo "</ul>" >> /httpboot/index.html
echo "If you enjoy netboot.xyz projects, please support us at:<br>" >> /httpboot/index.html
echo "<a href=\"https://opencollective.com/netbootxyz\">Open Collective</a><br>" >> /httpboot/index.html
echo "<a href=\"https://github.com/sponsors/netbootxyz\">GitHub Sponsors</a>" >> /httpboot/index.html
echo "</body></html>" >> /httpboot/index.html
