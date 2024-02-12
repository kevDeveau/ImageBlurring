#
# CMPUT 229 Student Submission License
# Version 1.0
#
# Copyright 2023 <student name>
#
# Redistribution is forbidden in all circumstances. Use of this
# software without explicit authorization from the author or CMPUT 229
# Teaching Staff is prohibited.
#
# This software was produced as a solution for an assignment in the course
# CMPUT 229 - Computer Organization and Architecture I at the University of
# Alberta, Canada. This solution is confidential and remains confidential
# after it is submitted for grading.
#
# Copying any part of this solution without including this copyright notice
# is illegal.
#
# If any portion of this software is included in a solution submitted for
# grading at an educational institution, the submitter will be subject to
# the sanctions for plagiarism at that institution.
#
# If this software is found in any public website or public repository, the
# person finding it is kindly requested to immediately report, including
# the URL or other repository locating information, to the following email
# address:
#
#          cmput229@ualberta.ca
#
#------------------------------------------------------------------------------
# CCID:
# Lecture Section:
# Instructor:
# Lab Section:
# Teaching Assistant:
#-----------------------------------------------------------------------------
#
.text
.include "common.s"

#-------------------------------------------------------------------------------
# digitToAscii
#   return the ASCII value of digit 
# 
# 
# input:
#	a0: a single digit represented as an integer, between 0 and 9
# return:
# 	a0: the ASCII value of the digit, between 48 (0x30) and 57 (0x39)
#-------------------------------------------------------------------------------
digitToAscii:

# --- insert your solution here ---

    ret



#-------------------------------------------------------------------------------
# copy
#   This function copies all the RGB values to another address.
# 
#
# input:
# 	a0: address of the start of RGB values (where to copy from)
# 	a1: address of the start of where to copy to
#	a2: length in words
#-------------------------------------------------------------------------------	
copy:

# --- insert your solution here ---

    ret


#-------------------------------------------------------------------------------
# asciiToDigit
#   This function returns the digit for the given ASCII value
# 
# 
# input:
#	a0: the ASCII value of the digit, between 48 (0x30) and 57 (0x39)
# return:
# 	a0: a single digit represented as an integer, between 0 and 9
#-------------------------------------------------------------------------------
asciiToDigit:

# --- insert your solution here ---

    ret


#-------------------------------------------------------------------------------
# readNextNumber
#   This function returns the next number starting from the current address.
# 
#   Details and examples are given in the instruction
#
# input:
# 	a0: current address to start reading
# return:
# 	a0: the address to start reading the next numbe
#	a1: the number
#-------------------------------------------------------------------------------		
readNextNumber:

# --- insert your solution here ---

    ret

#-------------------------------------------------------------------------------
# storeNumber
#   This function converts the integer(between 0 and 255) to 
#   ASCII and then stores their ASCII to the address. 
#   Store the leftmost digit first, consider using the function digitToAscii.
# 
# input:
#	a0: the number represented as an integer
#	a1: address for the number to be stored
# return:
# 	a0: the next address that's available to be stored
#-------------------------------------------------------------------------------
storeNumber:

# --- insert your solution here ---

    ret


#-------------------------------------------------------------------------------
# PixelKernelMul
#   This function calculates the average for each of the R, G, B values and stores the value.
# 
#   details and examples are given in the instruction
#
# input:
# 	a0: address of the start of RGB values, store the calculated RGB values in this region
#		(a0 is the base address)
# 	a1: address of the start of the copy of RGB values
# 	a2: row # of the current pixel to blur
# 	a3: col # of the current pixel to blur
# 	a4: total row (may not be used)
# 	a5: total col
#-------------------------------------------------------------------------------	
PixelKernelMul:

# --- insert your solution here ---

    ret
	
#-------------------------------------------------------------------------------
# blurImage
#   This function blurs the image using PixelKernelMul on all possible pixels.
#   It will run PixelKernelMul on all pixels except for the ones on the edges and corners.
#
#   details and pesudo code are given in the instruction
#
#
# input:
#   a0: kernel size
#   a1: total row
#   a2: total col
#   a3: address of the start of RGB values, store the calculated RGB values in this region
#       (a0 is the base address)
#   a4: address of the start of the copy of RGB values
#-------------------------------------------------------------------------------
blurImage:

# --- insert your solution here ---

    ret
