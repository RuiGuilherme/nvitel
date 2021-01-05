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
	--ok-label="Close/Restart Selected Process" \
	--cancel-label="Ok" \
	--column "PID" \
	--column "Process" \
	--column "Memory" \
	"${finalResult[@]}"`)

	if [ $finalResult -gt 0 ]; then 
		Kill=1
		Hup=2
		SecondOption=(`zenity --width=600 --height=400 \
		--list \
		--separator="$\n" \
		--text="Select one option. PID: $finalResult" \
		--column "Exec" \
		--column "Description" \
		$Kill "Kill process (this can cause issue in the application)" \
		$Hup "Reload process"`)
		if [ "$SecondOption" = "$Kill" ]; then
			kill -9 $finalResult
			exit
		elif [ "$SecondOption" = "$Hup" ]; then
			kill -HUP $finalResult
			exit
		else
			exit
		fi
	else 
		exit
	fi

