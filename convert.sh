#!/bin/bash
# TODO: allow for passing in directory to save to

print_help() {
    echo "Usage: $0 [-o output] [-f input_encoding] [-h] <input_file>"
    echo "Convert a file to UTF-8 encoding"
    echo
    echo "Options:"
    echo "  -o output         Specify the output file name (without extension)"
    echo "  -f, --from encoding Specify the input file encoding (skips auto-detection)"
    echo "  -h, --help        Display this help message"
    exit 1
}

output_name=""
input_encoding=""
while [[ $# -gt 0 ]]; do
    case $1 in
    -o)
        output_name="$2"
        shift 2
        ;;
    -f | --from)
        input_encoding="$2"
        shift 2
        ;;
    -h | --help)
        print_help
        ;;
    *)
        break
        ;;
    esac
done

# Shift the options so that $1 is the input file
shift $((OPTIND - 1))

# Check if a file is provided as an argument
if [ $# -eq 0 ]; then
    print_help
fi

input_file="$1"

if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found."
    exit 1
fi

if [ -z "$input_encoding" ]; then
    if ! command -v uchardet &>/dev/null; then
        echo "Error: uchardet is not installed. Please install it or use the -f flag to specify the input encoding."
        exit 1
    fi

    detected_encoding=$(uchardet "$input_file")

    if [ $? -ne 0 ]; then
        echo "Error: Unable to detect encoding."
        exit 1
    fi
else
    detected_encoding="$input_encoding"
fi

file_extension="${input_file##*.}"

if [ -n "$output_name" ]; then
    output_file="${output_name}.${file_extension}"
else
    output_file="${input_file%.*}_utf8.${file_extension}"
fi

iconv -f "$detected_encoding" -t UTF-8 "$input_file" >"$output_file"

if [ $? -eq 0 ]; then
    echo "Conversion successful. Output file: $output_file"
else
    echo "Error: Conversion failed."
    exit 1
fi
