function files() {
    for file in `ls $1`
    do
        if [ -d "$1/$file" ]
        then
            echo "mkdir $1/$file"
            files $1"/"$file
        elif [ "$1/$file" != "./out.sh" ]
        then
            file_contents=$(cat "$1/$file")
            escaped_string=$(printf '%s\n' "$file_contents" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e "s/'/\\'/g" -e 's/`/\\`/g')
            echo "echo \"$escaped_string\" >$1/$file"
        fi
    done
}

files . >out.sh
