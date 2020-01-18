#!/bin/bash
#==========================================================================
#        FILE: make_template.sh
#
# DESCRIPTION: Create Java source code templete file
#
#      AUTHOR: Mihai Gătejescu
#     VERSION: 1.4.0
#     CREATED: 15.08.2017
#==========================================================================

#==========================================================================
# Copyright 2017, 2018, 2019, 2020 Mihai Gătejescu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#	http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#==========================================================================

# Define show_usage() function
show_usage()
{
	echo "usage: $0 filename"
	exit 1
}

# Display usage and exit, if erroneous input
if [ ! $# == 1 ]; then
    show_usage
fi

filename=$1

#===================================================
# Write header comment to file
#===================================================

# Delete file if it already exists
if [ -f "$filename" ]; then
	rm -f "$filename"
fi

# Function to print one line at a time
print_line()
{
    case $# in
        1 )
            printf "$1" >> "$filename"
            ;;
        2 )
            printf "$1" "$2" >> "$filename"
            ;;
    esac
}

print_line \
"/**********************************************************************\n"
print_line \
" *        FILE: %-54s*\n" $filename
print_line \
" *                                                                    *\n"
print_line \
" * DESCRIPTION:                                                       *\n"
print_line \
" *                                                                    *\n"
print_line \
" *      AUTHOR:                                                       *\n"
print_line \
" *     CREATED: $(date  +"%D %T")                                     *\n"
print_line \
" **********************************************************************/\n\n"

#===================================================
# Create Java template code and write it to file
#===================================================
text=${filename%.*}
text=${text##*/}
text="public class $text\n"
text+="{\n\tpublic static void main(String[] args)\n\t{\n\t}\n}" 
echo -e "$text" >> $1

# Open file in vim
vim "+runtime indent/java.vim" "$filename"
