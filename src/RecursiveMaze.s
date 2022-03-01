#    RecursiveMaze.s
#
#
#
#    @author Vincent Marias

.data

.text
    # Arguments
    #     a2: address of the grid
    #     a3: xMax
    #     a4: yMax
    #     a5: current x index
    #     a6: current y index
    #     a7: current stack length
    # Return values
    #     None
    .globl printPaths
    printPaths:
        addi sp, sp, -12    # space for 3 words
        sw ra, 8(sp)        # save return address

        # base case 1
        bge zero, a3, printPaths_done    # return if xMax <= 0
        bge zero, a4, printPaths_done    # return if yMax <= 0

        # include current cell in route
        sw a2, 4(sp)                     # save a2
        sw a3, 8(sp)                     # save a3

        mul t0, a6, a3                   # t0 = curY * xMax
        add t0, t0, a5                   # t0 += curX
        slli t0, t0, 2                   # t0 *= 4
        add t0, t0, a2                   # t0 += grid
        lw a3, 0(t0)                     # a3 = *(grid + t0)

        add a2, zero, a7                 # a2 = stackLen

        jal ra, addValueToStack

        lw a3, 8(sp)                     # restore a3
        lw a2, 4(sp)                     # restore a2

        addi a7, a7, 1                   # stackLen++

        # base case 2 (if the last cell is reached)
        addi t0, a3, -1
        bne a5, t0, recurseDown
        addi t0, a4, -1
        bne a6, t0, recurseDown

        sw a2, 4(sp)                     # save a2
        add a2, zero, a7                 # a2 = stackLen

        jal ra, printStack
        jal zero, printPaths_done        # return

        lw a2, 4(sp)                     # restore a2

        # move down
        recurseDown:
        
        
        # move right
        recurseRight:


        # move diagonally
        recurseDiagonally:



        printPaths_done:
            lw ra, 8(sp)        # restore ra
            addi sp, sp, 12      # pop stack frame

            jalr zero, ra, 0    # return to caller
