#!/bin/bash

if [ "$#" == "0" ]; then
echo "Error: No arguments" >&2; exit 1;
fi

if [ "$#" == "1" ]; then
	if [ "$1" == "-v" ] || [ "$1" == "--version" ]; then
		docker run docker-tellread cat /tellysis/tellread/version.txt; exit 1;
	fi
fi

while (( "$#" )); do
  case "$1" in
    -i|--input)
      input_path=$2
      shift 2
      ;;
    -o|--output)
      output_path=$2
      shift 2
      ;;
    -f|--reference)
      ref_path=$2
      shift 2
      ;;
    -s|--samples)
      samples=$2
      shift 2
      ;;
    -g|--genomes)
      genomes=$2
      shift 2
      ;;
    -*|--*=|*) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
  esac
done

#single sample does not need -p option (partial samples indicator)
if [ "$samples" != '' ]; then
	samples_opt="-s $samples"
else
	samples_opt="-s T500"
fi

cmd_opt="-i $input_path -o $output_path $samples_opt -g $genomes"

uid=$(id -u ${USER})
mkdir -p $output_path
docker run \
	-v $input_path:$input_path \
	-v $output_path:$output_path \
	-v $ref_path:/tellysis/genomes \
  docker-tellread \
	bash -c "adduser --uid $uid --disabled-password myuser >> /dev/null 2>&1; chown -R myuser:myuser $output_path; su myuser -c \
  '/tellysis/tellread/StartTellReadPipeline $cmd_opt 2>&1 | tee $output_path/$(basename $output_path).log'"
