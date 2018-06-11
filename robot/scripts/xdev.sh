# dev.sh: Compile for development

color=`tput setaf 48`
magenta=`tput setaf 5`
reset=`tput setaf 7`


echo
echo "${color}Compiling${reset}"
start=`date +%s`
/Users/carlson/Downloads/elm make ./src/Main.elm --output ./dist-local/index.html
end=`date +%s`
runtime=$((end-start))
echo
echo "${magenta}Compile time: " $runtime " seconds${reset}"

echo
echo "${color}Copying files${reset}"
cp index.html ./dist-local/index.html

