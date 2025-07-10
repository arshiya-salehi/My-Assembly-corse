# Tic-Tac-Toe game in MIPS assembly

.data
board:  .space 9    # 3x3 game board
player: .word 1     # Player indicator: 1 for X, 2 for O

.text
main:
    li $t0, 0       # Initialize loop counter
    li $t1, 9       # Set the number of moves

    # Initialize the game board
    la $t2, board
    li $t3, 0       # Counter for initializing the board
init_board_loop:
    sb $zero, 0($t2)  # Initialize each cell to zero
    addi $t2, $t2, 1
    addi $t3, $t3, 1
    bne $t3, 9, init_board_loop

    # Start the game loop
game_loop:
    # Display the current state of the board
    li $v0, 4
    la $a0, board
    syscall

    # Prompt for player move
    li $v0, 4
    la $a0, player_prompt
    syscall

    # Get player move
    li $v0, 5
    syscall
    move $t4, $v0  # $t4 stores the player's move

    # Check if the move is valid
    blt $t4, 0, invalid_move
    bge $t4, 9, invalid_move
    lb $t5, board($t4)  # Check if the cell is already occupied
    bnez $t5, invalid_move

    # Update the board with the player's move
    sb $player, board($t4)

    # Check for a win or a tie
    jal check_win
    bnez $v0, winner_found

    # Switch players
    beq $player, 1, switch_to_O
    j switch_to_X

switch_to_O:
    li $player, 2
    j game_loop

switch_to_X:
    li $player, 1
    j game_loop

invalid_move:
    li $v0, 4
    la $a0, invalid_move_msg
    syscall
    j game_loop

winner_found:
    li $v0, 4
    la $a0, winner_msg
    syscall

    # Exit the program
    li $v0, 10
    syscall

# Function to check for a win
check_win:
    # Check rows, columns, and diagonals
    la $t6, win_patterns
    li $t7, 0

check_win_loop:
    lw $t8, 0($t6)      # Load the current win pattern
    li $t9, 0

check_pattern_loop:
    lb $t5, board($t8)  # Load the cell value
    beqz $t5, next_pattern
    bne $t5, $player, next_pattern

    addi $t9, $t9, 1
    bne $t9, 3, next_pattern  # Move to the next cell in the pattern

    # If all cells in the pattern match, we have a winner
    li $v0, 1
    jr $ra

next_pattern:
    addi $t6, $t6, 4  # Move to the next win pattern
    addi $t7, $t7, 1
    bne $t7, 8, check_win_loop  # Check all patterns

    # If no winner is found, check for a tie
    li $t7, 0
    la $t6, board

check_tie_loop:
    lb $t5, 0($t6)
    bnez $t5, not_tie
    addi $t7, $t7, 1
    addi $t6, $t6, 1
    bne $t7, 9, check_tie_loop

    # If all cells are filled and no winner, it's a

not_tie:
    # If no winner or tie is found, return 0
    li $v0, 0
    jr $ra

.data
player_prompt:  .asciiz "Player X, enter your move (0-8): "
invalid_move_msg: .asciiz "Invalid move. Please try again.\n"
winner_msg: .asciiz "Congratulations! Player X wins!\n"

# Win patterns: indices represent cell positions (0-8)
win_patterns:   .word 0, 1, 2, 3, 4, 5, 6, 7, 0, 3, 6, 1, 4, 7, 2, 5, 8, 0, 4, 8, 2, 4, 6

# Helper macro to calculate the address of a board cell
.macro board index
    4*index(board)
.end_macro

# Additional constants for better code readability
PLAYER_X:   .word 1
PLAYER_O:   .word 2

# Function to print the board
print_board:
    li $v0, 4
    la $a0, board
    syscall
    jr $ra

# Function to handle player moves
handle_player_move:
    # Prompt for player move
    li $v0, 4
    la $a0, player_prompt
    syscall

    # Get player move
    li $v0, 5
    syscall
    move $t4, $v0  # $t4 stores the player's move
    jr $ra
    
    # Function to display the winner message and exit the program
display_winner_and_exit:
    li $v0, 4
    la $a0, winner_msg
    syscall

    # Exit the program
    li $v0, 10
    syscall

# Main game loop
main_game_loop:
    # Display the current state of the board
    jal print_board

    # Get player move
    jal handle_player_move

    # Check if the move is valid
    blt $t4, 0, invalid_move
    bge $t4, 9, invalid_move
    lb $t5, board($t4)  # Check if the cell is already occupied
    bnez $t5, invalid_move

    # Update the board with the player's move
    beq $player, PLAYER_X, update_board_X
    j update_board_O

update_board_X:
    sb $player, board($t4)
    
# Check for a win or a tie
    jal check_win
    bnez $v0, winner_found

    # Switch players
    li $player, PLAYER_O
    j main_game_loop

update_board_O:
    sb $player, board($t4)

    # Check for a win or a tie
    jal check_win
    bnez $v0, winner_found

    # Switch players
    li $player, PLAYER_X
    j main_game_loop

winner_found:
    # Display the winner message and exit
    jal display_winner_and_exit

invalid_move:
    li $v0, 4
    la $a0, invalid_move_msg
    syscall
    j main_game_loop

# The rest of the code remains unchanged.