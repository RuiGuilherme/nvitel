#!/bin/zsh
nvidiaReport="$(nvidia-smi -q --xml-format | grep -oP '(?<=<pid>).*(?=</pid>)|(?<=<process_name>).*(?=--type)|(?<=<process_name>).*(?=</process_name>)|(?<=<used_memory>).*(?=</used_memory>)')"
count=1
finalResult=()
for i in $(echo $nvidiaReport | sed -e 's/ //g')
do
	case "$count" in
		1) pid=$i ;;
		2) process=$i ;;
		3) memory=$i;;
	esac
	((count++))
	if [ $count -gt 3 ]; then 
		count=$((1))
		finalResult=("${finalResult[@]}" "$pid" "$process" "$memory")
	fi
done
finalResult=(`zenity --width=600 --height=400 \
	--list \
	--separator="$\n" \
	--text="Running Processes:" \
	--column "PID" \
	--column "Process" \
	--column "Memory" \
	"${finalResult[@]}"`)
exit