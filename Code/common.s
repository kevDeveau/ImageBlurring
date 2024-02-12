#
# CMPUT 229 Public Materials License
# Version 1.0
#
# Copyright 2023 University of Alberta
# Copyright 2023 Zixu Yu
#
# This software is distributed to students in the course
# CMPUT 229 - Computer Organization and Architecture I at the University of
# Alberta, Canada.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the disclaimer below in the documentation
#    and/or other materials provided with the distribution.
#
# 2. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from this
#    software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
#-------------------------------
# Lab - Image Blurring
#
# Author: Zixu Yu
# Date: May 23, 2023
#
#-------------------------------
#

.align 2
.data
inputStream:    #space for input image to be stored
.space 1048576
copyStream:    #space for input image to be stored
.space 1048576
outPutName:
.space 512
createFileStr: .asciz "Couldn't create specified file.\n"
copyStr: .word 0x0000ff

copyDestination: .space 12
noFileStr:
.asciz "Couldn't open specified file.\n"
.align 2
testStream: .space 12
# strings for displaying test output
test_pass: .asciz " [X] Great job!    \n"
test_fail: .asciz " [ ] Almost there! \n" 
test_default_running: .asciz "\n\n-- Running tests for fucntions --\n\n"
test_1_running: .asciz "1: digitToAscii --"
test_2_running: .asciz "2: copy --"
test_3_running: .asciz "3: asciiToDigit --"
test_4_running: .asciz "4: readNextNumber --"
test_5_running: .asciz "5: PixelKernelMul --"
test_6_running: .asciz "6: storeNumber --"
testReadNextNumber: .asciz "\n32\n"
testPixelMul:
    .word 0x0000ff
    .word 0x00ff00
    .word 0xff0000
    .word 0xffffff
    .word 0x0000ff
    .word 0x00ff00
    .word 0x00ff00
    .word 0x0000ff
    .word 0x00ff00
    .word 0xff0000
    .word 0xffffff
    .word 0x0000ff
    .word 0x00ff00
    .word 0x00ff00
    .word 0x0000ff
    .word 0x00ff00
    .word 0xff0000
    .word 0xffffff
    .word 0x0000ff
    .word 0x00ff00
    .word 0x00ff00
    .word 0x0000ff
    .word 0x00ff00
    .word 0xff0000
    .word 0xffffff
    .word 0x0000ff
    .word 0x00ff00
    .word 0x00ff00
    .word 0x0000ff
    .word 0x00ff00
    .word 0xff0000
    .word 0xffffff
    .word 0x0000ff
    .word 0x00ff00
    .word 0x00ff00
    .word 0x0000ff
    .word 0x00ff00
    .word 0xff0000
    .word 0xffffff
    .word 0x0000ff
    .word 0x00ff00
    .word 0x00ff00
    .word 0x0000ff
    .word 0x00ff00
    .word 0xff0000
    .word 0xffffff
    .word 0xffffff
    .word 0xffffff
    .word 0xffffff


copyTestPixelMul:
    .word 0x0000ff
    .word 0x00ff00
    .word 0xff0000
    .word 0xffffff
    .word 0x0000ff
    .word 0x00ff00
    .word 0x00ff00
    .word 0x0000ff
    .word 0x00ff00
    .word 0xff0000
    .word 0xffffff
    .word 0x0000ff
    .word 0x00ff00
    .word 0x00ff00
    .word 0x0000ff
    .word 0x00ff00
    .word 0xff0000
    .word 0xffffff
    .word 0x0000ff
    .word 0x00ff00
    .word 0x00ff00
    .word 0x0000ff
    .word 0x00ff00
    .word 0xff0000
    .word 0xffffff
    .word 0x0000ff
    .word 0x00ff00
    .word 0x00ff00
    .word 0x0000ff
    .word 0x00ff00
    .word 0xff0000
    .word 0xffffff
    .word 0x0000ff
    .word 0x00ff00
    .word 0x00ff00
    .word 0x0000ff
    .word 0x00ff00
    .word 0xff0000
    .word 0xffffff
    .word 0x0000ff
    .word 0x00ff00
    .word 0x00ff00
    .word 0x0000ff
    .word 0x00ff00
    .word 0xff0000
    .word 0xffffff
    .word 0xffffff
    .word 0xffffff
    .word 0xffffff
.text
#----------------------------------------------------------------------------
#    main:
#        Read the picture file (.ppm) and then parse the file to get ready to be processed.
#        Call the functions in blur.s to run the blur algorithm.
#        Then, parse the file again to output the picture file.
#    Register usage:
#        s0: # rows of the pixels
#        s1: # cols of the pixels
#        s2: saturation value
#        s3: counter of which R, G, B we are at(0)
#        s4: the current ptr of the address
#        s5: the address of inputStream to store the calculated values
#        s6: outerloopCounter for parsing the file
#        s7: innerloopCounter for parsing the file
#        s10: filename
#----------------------------------------------------------------------------
main:
    lw a0, 0(a1)
    mv s10, a0            # s10 = filename
#-----------------------------------------------------------------------------------
li a7, 4
la a0, test_default_running
ecall
# test for digitToASCII
	li a7, 4
	la a0, test_1_running
	ecall
	li a0, 0x3
	jal ra, digitToAscii
	li t0, 0x33
	beq t0, a0, testSuccess1
	la a0, test_fail
	jal ra, printTestResult
	jal zero, doneDigitToAsciiTest
	testSuccess1:
		la a0, test_pass
		jal ra, printTestResult
	doneDigitToAsciiTest:
# test for copy
	li a7, 4
	la a0, test_2_running
	ecall
	la a0, copyStr
	la a1, copyDestination
	li a2, 1
	jal ra, copy
	la t0, copyDestination
	lw t0, 0(t0)
	li t1, 0x0000ff
	beq t0, t1, testSuccess2
	la a0, test_fail
	jal ra, printTestResult
	jal zero, doneCopyImageTest
	testSuccess2:
		la a0, test_pass
		jal ra, printTestResult
	doneCopyImageTest:

# test for asciiToDigit
	li a7, 4
	la a0, test_3_running
	ecall
	li a0, 0x33
	jal ra, asciiToDigit
	li t0, 3
	beq t0, a0, testSuccess3
	la a0, test_fail
	jal ra, printTestResult
	jal zero, doneAsciiToDigitResult
	testSuccess3:
		la a0, test_pass
		jal ra, printTestResult
	doneAsciiToDigitResult:

# test for readNextNumber
	li a7, 4
	la a0, test_4_running
	ecall
	la a0, testReadNextNumber
	jal ra, readNextNumber
	li t0, 32
	beq t0, a1, testSuccess4
	la a0, test_fail
	jal ra, printTestResult
	jal zero, doneReadNextNumberTest
	testSuccess4:
		la t0, testReadNextNumber
		addi t0, t0, 4
		beq t0, a0, reallyTestSuccess4
		la a0, test_fail
		jal ra, printTestResult
		jal zero, doneReadNextNumberTest
		reallyTestSuccess4:
			la a0, test_pass
			jal ra, printTestResult
	doneReadNextNumberTest:
# test for PixelKernelMul
	li a7, 4
	la a0, test_5_running
	ecall
	la a0, testPixelMul
	la a1, copyTestPixelMul
	li a2, 3
	li a3, 3
	li a4, 7
	li a5, 7
	jal ra, PixelKernelMul
	la a0, testPixelMul
	addi a0, a0, 96        # 4 * ((3 * row7) + 3)
	lw t0, 0(a0)
	li t1, 5805687
	beq t0, t1, testSuccess5
	la a0, test_fail
	jal ra, printTestResult
	jal zero, donePixelKernelMulTest
	testSuccess5:
		la a0, test_pass
		jal ra, printTestResult
	donePixelKernelMulTest:
	
# test for store Number
	li a7, 4
	la a0, test_6_running
	ecall
	li a0, 5
	la a1, testStream
	jal ra, storeNumber
	la t1, testStream
	addi t1, t1, 1
	beq a0, t1, testSuccess6
	la a0, test_fail
	jal ra, printTestResult
	jal zero, doneStoreNumberTest
	testSuccess6:
		la t0, testStream
		lb t0, 0(t0)
		li t1, 0x35
		beq t0, t1, reallySuccess6
		la a0, test_fail
		jal ra, printTestResult
		jal zero, doneStoreNumberTest
		reallySuccess6:
			la a0, test_pass
			jal ra, printTestResult

	doneStoreNumberTest:
	
	
	mv a0, s10
    li        a1, 0        #Flag: Read Only
        li        a7, 1024        #Service: Open File
                        #File descriptor gets saved in a0 unless an error happens
        ecall
        bltz    a0, main_err         #Negative means open failed

        la        a1, inputStream    #write into my binary space
        li        a2, 1048576            #read a file of at max 2mb
        li        a7, 63              #Read File Syscall
        ecall
    
    la a1, inputStream        #supply pointers as arguments
    li t3, 10
    
    
    mv a2, a1        # a2 = current address of a
    
    lb a3, 0(a2)

    P3:
        # reading the "P3" at the beginnng of the file
        addi a2, a2, 1
        lb a3, 0(a2)
        li t0, 0x0A
        beq a3, t0, exitP3
        jal zero, P3
    exitP3:
        li t0, 0    # sum of the digits
    ROWS:
        # read the # of rows
        addi a2, a2, 1
        lb a3, 0(a2)
        li t1, 0x20
        beq a3, t1, exitRows
        li t1, 10
        mul t0, t0, t1
        mv a0, a3
        addi sp, sp, -8
        sw t0, 0(sp)
        sw a2, 4(sp)
        jal ra, asciiToDigit
        lw t0, 0(sp)
        lw a2, 4(sp)
        addi sp, sp, 8
        add t0, t0, a0
        jal zero, ROWS
    exitRows:
        mv s1, t0    # s0 = # rows of the pixels
        li t0, 0
    Cols:            # read the # of cols
        addi a2, a2, 1
        lb a3, 0(a2)
        li t1, 0x20
        beq a3, t1, exitCols
        li t1, 0x0d
        beq a3, t1, exitCols
        li t1, 0x0a
        beq a3, t1, exitCols
        li t1, 10
        mul t0, t0, t1
        mv a0, a3
        addi sp, sp, -8
        sw t0, 0(sp)
        sw a2, 4(sp)
        jal ra, asciiToDigit
        lw t0, 0(sp)
        lw a2, 4(sp)
        addi sp, sp, 8
        add t0, t0, a0
        jal zero, Cols
    exitCols:
        mv s0, t0    # s1 = # cols of the pixels
        li t0, 0
    # read saturation
    mv a0, a2
    jal ra, readNextNumber
    mv s2, a1           # s2 = saturation value
    li s3, 0            # s3 = counter of which R, G, B we are at(0)
    mv s4, a0           # s4 = a0 = the current ptr of the address
    la s5, inputStream  # overriding the original data, can be changed later
    RGBLoop:
        mv a0, s4       # a0 = current ptr
        lb t0, 0(s4)
        beq t0, zero, exitRGBLoop
        jal ra, readNextNumber
        li t0, 3
        mv s4, a0
        bne s3, t0, continueRGBLoop
        # insert a space to hold the place
        sb zero, 0(s5)
        li s3, 0
        addi s5, s5, 1
    continueRGBLoop:
        sb a1, 0(s5)
        addi s5, s5, 1
        addi s3, s3, 1
        jal zero, RGBLoop
    exitRGBLoop:
        # clean the rest of the bytes
        sb zero, 0(s5)
        addi s5, s5, 1
        lb t0, 0(s5)
        bne t0, zero, exitRGBLoop
    la s3, inputStream
    la s4, copyStream
    
    mv a0, s3
    mv a1, s4
    mul a2, s0, s1        # # of pixels = s0 * s1 = rows * cols
    jal ra, copy
    
    li s7, 3            # s7 = size of the raidus (3)
    
    # a0 = kernel size(s7)
    # a1 = total row s0
    # a2 = total col s1
    mv a0, s7
    mv a1, s0
    mv a2, s1
    la a3, inputStream
    la a4, copyStream
    jal ra, blurImage
    # format the values to be ready for output
    la s5, copyStream    # s5 = address to store values at
    # store "P3\n"
    li t0, 0x50
    sb t0, 0(s5)
    addi s5, s5, 1        # s5++
    li t0, 0x33
    sb t0, 0(s5)
    addi s5, s5, 1
    li t0, 0x0A        # \n
    sb t0, 0(s5)
    addi s5, s5, 1
    # store the col and row
    # store s1 col
    mv a0, s1
    mv a1, s5
    jal ra, storeNumber
    mv s5, a0
    # store space
    li t0, 0x20
    sb t0, 0(s5)
    addi s5, s5, 1
    # store s0 row
    mv a0, s0
    mv a1, s5
    jal ra, storeNumber
    mv s5, a0
    # store \n
    li t0, 0x0A
    sb t0, 0(s5)
    addi s5, s5, 1
    # store saturation number
    li a0, 0xff
    mv a1, s5
    jal ra, storeNumber
    mv s5, a0
    # store \n
    li t0, 0x0A
    sb t0, 0(s5)
    addi s5, s5, 1
    
    li s6, 0        # s6 = outerloopCounter
    la s9, inputStream
    outerParseLoop:
        addi s6, s6, 1
        li s8, 0    # s8 = innerLoopCounter
        # inner loop to store each pair of RGB values
        innerParseLoop:
            addi s8, s8, 1
            lbu a0, 0(s9)
            addi s9, s9, 1
            mv a1, s5
            jal ra, storeNumber
            mv s5, a0
            # store space
            li t0, 0x20
            sb t0, 0(s5)
            addi s5, s5, 1
            li t0, 2
            ble s8, t0, innerParseLoop     # if s8 <= 3 - 1: goto innerParseLoop
        addi s9, s9, 1                # reach the end of a RGB group
        mul t0, s0, s1
        addi t0, t0, -1
        ble s6, t0, outerParseLoop
        
    # write this to a file
    la a1, copyStream    # a1 = where to start store
    sub a0, s5, a1        # a0 = length in bytes to be stored
    
    la s11, outPutName
    lb t0, 0(s10)
    sb t0, 0(s11)
    addOut:
        addi s10, s10, 1
        addi s11, s11, 1
        lb t0, 0(s10)
        sb t0, 0(s11)
        li t1, 0x2E
        lb t2, 1(s10)
        lb t3, 2(s10)
        lb t4, 3(s10)
        li t5, 0x70
        li t6, 0x6d
        beq t0, t1, checkAddOut1
        jal zero, addOut
        checkAddOut1:
            beq t2, t5, checkAddOut2
            jal zero, addOut
            checkAddOut2:
                beq t3, t5, checkAddOut3
                jal zero, addOut
                checkAddOut3:
                    beq t4, t6, stopAddOutLoop
                    jal zero, addOut
stopAddOutLoop:
    #addi s11, s11, 1
    li t0, 0x6F
    sb t0, 1(s11)
    li t0, 0x75
    sb t0, 2(s11)
    li t0, 0x74
    sb t0, 3(s11)
    li t0, 0x2E
    sb t0, 4(s11)
    li t0, 0x70
    sb t0, 5(s11)
    sb t0, 6(s11)
    li t0, 0x6d
    sb t0, 7(s11)
    
    la a2, outPutName
    li a3, 1
    
    jal ra, writeFile
    jal zero, endProgram
    


main_err:
    la        a0, noFileStr   #print error message in the event of an error when trying to read a file
    li        a7, 4
    ecall
        
#-------------------------------------------------------------------------------
# writeFile
# adapted from Lab_WASM
#
# opens file and writes bytes to the file
#
# input:
#    a0: number of bytes to be written, value provided by the student
#    a1: address to the beginning of the data to be written to the file
#    a2: address to the beginning of the filename string
#    a3: open flag (1 for write-create, 9 for write-append)
#-------------------------------------------------------------------------------
writeFile:
    # Prepare stack
    addi    sp, sp, -8
    sw      s0, 0(sp)
    sw      s1, 4(sp)

    mv s0, a1
    mv s1, a0
    mv s2, a2

    #open file
    mv      a0, a2             # filename for writing to
    mv      a1, a3           # open flag (write-create or write-append)
    li      a7, 1024            # Open File
    ecall
    bltz    a0, writeOpenErr    # Negative means open failed
    mv      t0, a0
    #write to file
    mv      a0, t0
    mv      a1, s0          # address of buffer from which to start the write from
    mv      a2, s1        # number of bytes to write
    li      a7, 64              # system call for write to file
    ecall                       # write to file
    #close file
    mv      a0, t0              # file descriptor to close
    li      a7, 57              # system call for close file
    ecall                       # close file
    jal     zero, writeFileDone

writeOpenErr:
    la      a0, createFileStr
    li      a7, 4
    ecall

writeFileDone:
    # Remove stack
    lw      s0, 0(sp)
    lw      s1, 4(sp)
    addi    sp, sp, 8
    jalr    zero, ra, 0

endProgram:
    li      a7, 10      #exit program syscall
        ecall

printTestResult:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	li a7, 4
	ecall
	
	lw ra, 0(sp)
	addi sp, sp, 4
	jr ra


