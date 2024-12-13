
# File Encoding Converter to UTF-8

This script converts a file of unknown encoding to UTF-8. It supports automatic encoding detection using uchardet or allows the user to specify the input encoding manually. The script leverages iconv to perform the actual conversion.

# Features

- Automatic Encoding Detection: Uses uchardet to detect the file encoding if not specified.

- Manual Encoding Specification: Allows specifying the input encoding via a command-line option.

- Custom Output Naming: The output file name can be customized.

- Error Handling: Provides informative error messages for missing dependencies or invalid input.

# Dependencies

- `uchardet`: For automatic encoding detection.

- `iconv`: For converting the file to UTF-8.

Install these tools if they are not already available on your machine:

`sudo apt-get install uchardet iconv`      # For Debian-based systems
`sudo yum install uchardet iconv`          # For Red Hat-based systems

Usage

Firstly, you may need to make the script executable before you can run it via the following command: `chmod +x convert.sh`

Below shows how to use the script:
`./convert.sh [-o output] [-f input_encoding] [-h] <input_file>`

## Options

`-o` aka output: Specify the output file name (without extension).

`-f` or `--from` aka the "from" encoding: Specify the encoding of the input file (Only use if you already know the encoding and wish to skip auto-detection).

-h, --help: Display the help message.

## Example Commands

Convert a file with auto-detected encoding:

`./convert.sh example.txt`

Convert a file with a specified encoding:

`./convert.sh -f ISO-8859-1 example.txt`

Convert and specify an output file name:

`./convert.sh -o converted_file -f UTF-16 input.txt`

# Potential Errors

- Missing Dependencies: The script will alert you if `uchardet` is not installed when automatic detection is needed.

- File Not Found: The script checks if the input file exists before proceeding.

- Conversion Errors: If `iconv` fails, an error message is displayed.

License

This script is provided under the MIT License.
