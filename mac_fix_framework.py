import os
import re
import subprocess
import sys

path = sys.argv[1]
for directory_name, sub_directories, file_list in os.walk(path):
    for file_name in file_list:
        file_path = os.path.join(directory_name, file_name)
        if file_path.endswith(".exe"):
            continue
        if file_path.endswith(".ico"):
            continue
        #print(f"File: {file_path}")
        printed = False
        try:
            result = subprocess.check_output(['otool', '-L', file_path]).decode('utf-8')
            results = result.split('\n')
            lines = []
            for line in results:
                if re.match('\t\/Library\/Frameworks\/Python\.framework\/', line) is not None:
                    if not printed:
                        print(f"\nFILE: {file_path}")
                        printed = True
                    print(f"  {line}")
                    framework_path = re.search('\t\/Library\/Frameworks\/Python\.framework\/(\S+)', line).group(1)
                    original_path = re.search('\t(\S+)' + framework_path, line).group(1)
                    subprocess_args = ['chmod', '+w', file_path]
                    subprocess.check_output(subprocess_args)
                    # print(f"{original_path + framework_path} {'/Library/Frameworks/' + file_path}")
                    if original_path + framework_path == "/Library/Frameworks/" + file_path:
                        # subprocess_args = ['install_name_tool', '-id', '@executable_path/../Frameworks/Python.framework/' + framework_path, file_path]
                        subprocess_args = ['install_name_tool', '-id', '@rpath/Python.framework/' + framework_path, file_path]
                    else:
                        # subprocess_args = ['install_name_tool', '-change', original_path + framework_path, '@executable_path/../Frameworks/Python.framework/' + framework_path, file_path]
                        subprocess_args = ['install_name_tool', '-change', original_path + framework_path, '@rpath/Python.framework/' + framework_path, file_path]
                    subprocess.check_output(subprocess_args)
                    print(" ".join(subprocess_args))
        except subprocess.CalledProcessError:
            continue
