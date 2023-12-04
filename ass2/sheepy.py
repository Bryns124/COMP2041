#!/usr/bin/python3 -u

import sys
import re

# Check for comments
# Splits line and comment and returns both
def check_comment(line):
    comment = ""
    if '#' in line:
        line, comment = line.split('#', 1)
        comment = '#' + comment
    return line, comment

# Check for variables in if and while statements
# Different cases for strings, numeric values and variables
def check_if_while_condition(line):
    compare_int = convert_comparators(line)
    # Helper function to refactor repeated code
    def process_element(element):
        if "$" in element:
            if compare_int:
                return re.sub(r'^\$(.*)', r'int(\1)', element)
            return element.replace("$", "")
        return f"'{element}'"
    
    line[1] = process_element(line[1])
    line[3] = process_element(line[3])

# Convert the similar but different comparators used 
# for strings and numeric values in shell to python
def convert_comparators(line):
    compare_int = False
    # For strings
    if "=" in line:
        compare_int = False
        index = line.index('=')
        line[index] = '=='
    elif "!=" in line:
        compare_int = False
        index = line.index('!=')
        line[index] = '!='
    elif "<" in line:
        compare_int = False
        index = line.index('<')
        line[index] = '<'
    elif ">" in line:
        compare_int = False
        index = line.index('>')
        line[index] = '>'
    # For numeric values
    elif "-eq" in line:
        compare_int = True
        index = line.index('-eq')
        line[index] = '=='
    elif "-ne" in line:
        compare_int = True
        index = line.index('-ne')
        line[index] = '!='
    elif "-lt" in line:
        compare_int = True
        index = line.index('-lt')
        line[index] = '<'
    elif "-gt" in line:
        compare_int = True
        index = line.index('-gt')
        line[index] = '>'
    elif "-le" in line:
        compare_int = True
        index = line.index('-le')
        line[index] = '<='
    elif "-ge" in line:
        compare_int = True
        index = line.index('-ge')
        line[index] = '>='
    return compare_int

# Check for file-based and string-based check conditions
# Different cases for strings and variables
def check_file_or_string_condition(line, indent, comment):
    is_variable = False
    option = line[1]
    file_or_dir_path = line[2]
    file_or_dir_path = file_or_dir_path.replace("$", "")
    formatted_path = format_path(file_or_dir_path, is_variable)
    # File-based conditions:
    if option == "-r":
        print(f"{indent}if os.access({formatted_path}, os.R_OK): {comment}")
    elif option == "-f":
        print(f"{indent}if os.path.isfile({formatted_path}): {comment}")
    elif option == "-w":
        print(f"{indent}if os.access({formatted_path}, os.W_OK): {comment}")
    elif option == "-x":
        print(f"{indent}if os.access({formatted_path}, os.X_OK): {comment}")
    elif option == "-d":
        print(f"{indent}if os.path.isdir({formatted_path}): {comment}")
    elif option == "-a" or option == "-e":
        print(f"{indent}if os.path.exists({formatted_path}): {comment}")
    elif option == "-s":
        print(f"{indent}if os.path.getsize({formatted_path}) > 0: {comment}")
    # String-based conditions
    elif option == "-n":
        print(f"{indent}if len({formatted_path}) > 0: {comment}")
    elif option == "-z":
        print(f"{indent}if len({formatted_path}) == 0: {comment}")

# Helper function for checking file strings and conditions
# Formats file/directory path by removing quotations if it is a variable
# and keeping if it is a string
def format_path(file_or_dir_path, is_variable):
    return file_or_dir_path if is_variable else f"'{file_or_dir_path}'"

# Handles lines that begin with echo
# Handles prints for different cases like strings, variables, backticks
# different quotations and the combination
def handle_echo_line(line, indent, globbing_characters):
    line, comment = check_comment(line)
    line = line.replace("echo ", "")
    replaced_line = re.sub(r'\$([A-Za-z0-9_]+)', r'{\1}', line)
    # Handle echo with quotation marks, '' and ""
    if (line.strip().startswith("'") and line.strip().endswith("'")) or (line.strip().startswith('"') and line.strip().endswith('"')):
        line = line.strip()
        # Handle variable expansion $ inside quotation marks
        if '$' in line:
            if re.search(r'\$[0-9]', line):
                replaced_line = re.sub(r'\{([0-9])\}', r'\{sys.argv[\1]\}', replaced_line)
                print(f'{indent}print(f{replaced_line.strip()}) {comment}')
                return
            elif re.search(r'\$([A-Za-z0-9_]+)', line):
                replaced_line = replaced_line.replace("$", "")
                print(f'{indent}print(f{replaced_line.strip()}) {comment}')
                return
            else:
                print(f'{indent}print(f{replaced_line.strip()}) {comment}')
                return
        # Handle backticks inside quotation marks
        elif "`" in line:
            handle_backtick_command_echo(line, indent, comment)
        print(f'{indent}print({line}) {comment}')
        return
    # Handle echo without quotation marks
    else:
        replaced_line = re.sub(r'\s+', ' ', replaced_line)
        line = line.strip()
        # Handle variable expansion $ without quotation marks
        if '$' in line:
            if re.search(r'\$[0-9]', line):
                if "`" in line:
                    handle_backtick_command_echo(replaced_line, indent, comment)
                    return
                replaced_line = re.sub(r'{([0-9])}', r'{sys.argv[\1]}', replaced_line)
                print(f'{indent}print(f"{replaced_line.strip()}") {comment}')
            elif re.search(r'\$([A-Za-z0-9_]+)', line):
                if "`" in line:
                    handle_backtick_command_echo(replaced_line, indent, comment)
                    return
                replaced_line = replaced_line.replace("$", "")
                print(f'{indent}print(f"{replaced_line.strip()}") {comment}')
            else:
                print(f'{indent}print(f"{replaced_line.strip()}") {comment}')
        # Handle globbing without quotation marks
        elif any(char in line for char in globbing_characters):
            replaced_line = replaced_line.strip().split(" ")
            for i in enumerate(replaced_line):
                glob_print = f'" ".join(sorted(glob.glob("{replaced_line[i]}")))'
                print(f'{indent}print({glob_print}) {comment}')
        else:
            print(f'{indent}print("{replaced_line.strip()}") {comment}')

# Helper function for echo to handle printing backticks
def handle_backtick_command_echo(line, indent, comment):
    backtick = re.findall(r'`([^`]*)`', line)[0]
    backtick = backtick.strip().split(" ")
    backtick_command = f"subprocess.run({backtick}, text=True, stdout=subprocess.PIPE).stdout"
    line = re.sub(r'(.*)`([^`]*)`(.*)', lambda m: f"{m.group(1)}{backtick_command}{m.group(3)}", line)
    line = line.replace("subprocess.run(", "{subprocess.run(").replace(").stdout", ").stdout}")
    print(f'{indent}print({line}) {comment}')

# Handles lines that begin with an if-statement clause
# Indents lines accordingly
def handle_if_line(line, indent_level):
    indent = '    ' * indent_level
    # Decrease indent for lines with elif and else
    if line.strip().startswith("elif test "):
        indent_level -= 1
        indent = '    ' * indent_level
    elif line.strip().startswith("else"):
        indent_level -= 1
        indent = '    ' * indent_level
    line, comment = check_comment(line)
    line = line.strip().split(" ")
    if "test" in line:
        del line[1]
    else:
        pass
    if len(line) == 4:
        check_if_while_condition(line)
    elif len(line) == 3:
        check_file_or_string_condition(line, indent, comment)
        return indent_level
    print(f'{indent}{" ".join(line)}: {comment}')
    # Increase next indent for next line after line with else
    if line[0].strip().startswith("else"):
        indent_level += 1
    return indent_level

# Handles lines with external commands
# Transpiled to subprocess in python
def handle_external_commands_line(line, indent):
    skip_to_next_line = False
    run_subprocess = []
    line, comment = check_comment(line)
    line = line.strip().split(" ")
    for word in line:
        if "$" in word.strip():
            if word.strip().startswith('"'):
                skip_to_next_line = handle_quotations_external_commands(line, indent, comment, r"'.\$([A-Za-z0-9_]+).'")
                break
            elif word.strip().startswith("'"):
                skip_to_next_line = handle_quotations_external_commands(line, indent, comment, r'".\$([A-Za-z0-9_]+)."')
                break
            else:
                run_subprocess.append(str(line))
        else:
            stripped_word = word.strip("'")
            run_subprocess.append(f'"{stripped_word}"')
    if skip_to_next_line:
        return
    print(f'{indent}subprocess.run([{", ".join(run_subprocess)}]) {comment}')

# Helper function for external commands to handle printing external commands
# with quotations
def handle_quotations_external_commands(line, indent, comment, pattern):
    skip_to_next_line = True
    var_name = str(line)
    run_process_var = re.sub(pattern, r"\1", var_name)
    print(f'{indent}subprocess.run({run_process_var}) {comment}')
    return skip_to_next_line

# Handles lines with while statements
def handle_while_line(line, indent):
    line, comment = check_comment(line)
    line = line.strip().split(" ")
    if "test" in line:
        del line[1]
    else:
        pass
    if len(line) == 4:
        check_if_while_condition(line)
    print(f'{indent}{" ".join(line)}: {comment}')

# Handles lines with '=' 
# Handles strings, variables, backticks and different
# quotation marks and the combination of them.
def handle_equals_line(line, indent, variables):
    line, comment = check_comment(line)
    line = line.strip().split("=")
    var = line[0]
    val = re.sub(r'\$([A-Za-z0-9_]+)', r'{\1}', line[1])
    if "$" in line[1]:
        # Handles variable expansion for $0-$9
        if re.search(r'^\$[0-9]', line[1]):
            val = re.sub(r'{([0-9])}', r'sys.argv[\1]', val)
            print(f"{indent}{var} = {val} {comment}")
        # Handles variable expansion for $10...
        elif re.search(r'^\$1[0-9]+', line[1]):
            val = re.sub(r'(1[0-9]+)', r'sys.argv[\1]', val)
            print(f"{indent}{var} = f\"{val}\" {comment}")
        # Handles variable expansion for $ with any characters and numbers
        elif re.search(r'^\$([A-Za-z0-9_]+)', line[1]):
            val = re.sub(r'{([A-Za-z0-9_]+)}', r'\1', val)
            print(f"{indent}{var} = {val} {comment}")
        # Handles backtick and $ in the same line (likely for loop increment)
        elif "`" in line[1]:
            backtick_command = line[1].strip("`").split(" ")
            backtick_command_str = str(backtick_command)
            final_backtick_command = re.sub(r"'\$([a-zA-Z0-9_]+)'", r"\1", backtick_command_str)
            print(f"{indent}{var} = subprocess.run({final_backtick_command}, text=True, stdout=subprocess.PIPE).stdout.rstrip('\\n') {comment}")
        else:
            print(f"{indent}{var} = f\"{val}\" {comment}")
    elif "`" in line[1]:
        backtick_command = line[1].strip("`").split(" ")
        print(f"{indent}{var} = subprocess.run({backtick_command}, text=True, stdout=subprocess.PIPE).stdout {comment}")
    elif line[1].strip().startswith('"'):
        line[1] = line[1].strip('"')
        print(f"{indent}{var} = {val} {comment}")
    elif line[1].strip().startswith("'"):
        line[1] = line[1].strip("'")
        print(f"{indent}{var} = {val} {comment}")
    else:
        print(f"{indent}{var} = \"{val}\" {comment}")
    # Save variables and values into 'variables' dictionary
    variables[var] = val

# Handle lines with for statements
# Handles variables, globs and iterable lists
def handle_for_line(line, indent, variables, globbing_characters):
    line, comment = check_comment(line)
    line = line.strip().split(" ")
    for_vals = line[3:]
    # Handles a glob in the for line
    if any(char in line[3].strip() for char in globbing_characters):
        glob_print = f'" ".join(sorted(glob.glob("{line[3]}")))'
        print(f'{indent}for {line[1]} in {glob_print}: {comment}')
    # Handles a variable expansion $ in the for line
    elif "$" in line[3].strip():
        var = line[3].strip().replace("$", "")
        if "*" in variables[var].strip() or "?" in variables[var].strip():
            glob_print = f'" ".join(sorted(glob.glob("{variables[var]}")))'
            print(f'{indent}for {line[1]} in {glob_print}: {comment}')
        else:
            print(f'{indent}for {line[1]} in {var}: {comment}')
    else:
        for_vals[-1] = for_vals[-1].replace("#", "")
        line_items = ', '.join(f'"{item}"' for item in for_vals)
        print(f'{indent}for {line[1]} in [{line_items}]: {comment}')

# Handles lines with the exit command
def handle_exit_line(line, indent):
    line, comment = check_comment(line)
    line = line.strip().split(" ")
    exit_code = line[1]
    if len(line) > 1:
        print(f"{indent}sys.exit({exit_code}) {comment}")
    else:
        print(f"{indent}sys.exit() {comment}")

# Handles lines with the read command
def handle_read_line(line, indent):
    line, comment = check_comment(line)
    line = line.strip().split(" ")
    var = line[1]
    print(f'{indent}{var} = input() {comment}')

# Transpiles the given shell file into python line-by-line
def transpile_file(file):
    variables = {}
    indent_level = 0
    imports = ["import"]
    globbing_characters = ['*', '?', '[', ']']
    subprocess_commands = ['touch', 'ls', 'mkdir', 'chmod', 'rm', 'cp', 'mv', 'rmdir', 'cat', 'grep', '`']
    os_commands = ['cd', '-r', '-f', '-w', '-x', '-d']
    need_glob = False
    need_sys = False
    need_os = False
    need_subprocess = False

    # First traveral through shell script to check for what
    # modules need to be imported
    with open(file, "r") as shell_file:
        lines = shell_file.readlines()
        for line in lines:
            if any(char in line for char in globbing_characters):
                need_glob = True
            elif "exit" in line or re.search(r'\$[0-9]', line):
                need_sys = True
            elif any(command in line for command in os_commands):
                need_os = True
            elif any(command in line for command in subprocess_commands):
                need_subprocess = True

    # Second traversal through shell script to transpile shell
    # script to python
    with open(file, "r") as shell_file:
        lines = shell_file.readlines()
        for line in lines:
            # Indent for if statements and while and for loops
            indent = '    ' * indent_level
            if line.strip() == "#!/bin/dash":
                print("#!/usr/bin/python3 -u\n")
                # Append modules to be imported and prints them 
                if need_glob:
                    imports.append("glob,")
                if need_sys:
                    imports.append("sys,")
                if need_os:
                    imports.append("os,")
                if need_subprocess:
                    imports.append("subprocess,")
                if len(imports) > 1:
                    imports[-1] = imports[-1].replace(",", "\n")
                    print(' '.join(imports))
            # Handle different commands line by line
            elif line.strip().startswith("echo "):
                handle_echo_line(line, indent, globbing_characters)
            elif line.strip().startswith("if test ") or line.strip().startswith("elif test ") or line.strip().startswith("else"):
                indent_level = handle_if_line(line, indent_level)
            elif any(command in line.split() for command in subprocess_commands):
                handle_external_commands_line(line, indent)
            elif line.strip().startswith("while"):
                handle_while_line(line, indent)
            elif "=" in line:
                handle_equals_line(line, indent, variables)
            elif line.strip().startswith("#"):
                print(f'{indent}{line.strip()}')
            elif line.strip().startswith("for "):
                handle_for_line(line, indent, variables, globbing_characters)
            elif line.strip().startswith("exit"):
                handle_exit_line(line, indent)
            elif line.strip().startswith("read"):
                handle_read_line(line, indent)
            # Handle indenting for if statements and for and while loops
            elif line.strip().startswith("done") or line.strip().startswith("fi"):
                indent_level -= 1
                continue
            elif line.strip().startswith("do") or line.strip().startswith("then"):
                indent_level += 1
                continue

if __name__ == "__main__":
    file = sys.argv[1]
    transpile_file(file)
