#!/usr/bin/env python

# python xmlify.py <rel-name> <arity> <att-name_1> ...
#
# assumes the existence of a file <rel-name>.txt
# writes out two files <rel-name_a.xml and <rel-name>_e.xml
# the first transforms each column into a name/value attribute into a single element
# the second transforms each column into a separate element
#
# example call
# python xmlify.py desert 4 name area longitude latitude

import sys
import os
import string

relation = sys.argv[1]
arity    = int(sys.argv[2])
j = 3

schema = []
end  = j+arity

while j < end:
    schema.append(sys.argv[j])
    j = j+1

tmp_name  = "delete_me"

input     = open(relation + ".txt","r")
tmp_name1 = tmp_name + "1"
tmp1      = open(tmp_name1,"w")
outputa   = open(relation + "_a" + ".xml","w")

lines = input.readlines()

tmp1.write("\n" + "<" + relation + ">")
for line in lines:
    tuple = line.split("|")
    i = 0
    l = "\n" + "   " + "<" + relation + "-tuple"
    for attribute in schema:
        value = tuple[i]
        i = i+1
        stripped = value.strip(" \t\n")
        if stripped == "":
            value = "MISSING"
        l = l + " " + attribute + "=" + '"' + value + '"'
    l = l + "/>"
    tmp1.write(l)
tmp1.write("\n" + "</" + relation + ">")

input.close()
tmp1.close()

input     = open(relation + ".txt","r")
tmp_name2 = tmp_name + "2"
tmp2      = open(tmp_name2,"w")
outpute   = open(relation + "_e" + ".xml","w")

lines = input.readlines()

tmp2.write("\n" + "<" + relation + ">")
for line in lines:
    tuple = line.split("|")
    i = 0
    tmp2.write("\n" + "   " + "<" + relation + "-tuple>")
    for attribute in schema:
        value = tuple[i]
        i = i+1
        stripped = value.strip(" \t\n")
        if stripped == "":
            value = "MISSING"
        tmp2.write("\n" + "   " + "   " + "<" + attribute + ">")
        tmp2.write("\n" + "   " + "   " + "   " + value )
        tmp2.write("\n" + "   " + "   " + "</" + attribute + ">")
    tmp2.write("\n" + "   " + "</" + relation + "-tuple>")
tmp2.write("\n" + "</" + relation + ">")

input.close()
tmp2.close()

tmp1 = open(tmp_name1,"r")

filecontent = tmp1.read()
stripped = string.replace(filecontent, '\n"/>', '"/>')
outputa.write(stripped)

tmp1.close()
outputa.close()

tmp2 = open(tmp_name2,"r")

lines = tmp2.readlines()
for line in lines:
    stripped = line.strip("\n")
    if not(stripped == ""):
        outpute.write(line)

tmp2.close()
outpute.close()

os.remove(tmp_name1)
os.remove(tmp_name2)

