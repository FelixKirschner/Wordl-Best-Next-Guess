include("aux_functions.jl")

function best_next(guess, indicator, possible_solutions, accepted_guesses)

    new_guess_set = ret_new_feas(guess, indicator, accepted_guesses)

    if length(new_guess_set) == 1
        println("Only one possible guess left: ", new_guess_set[1])
        return Nothing, Nothing
    else

        new_sol_set = ret_new_feas(guess, indicator, possible_solutions)

        performance = [0.0 for i = 1:length(new_guess_set)]
        N = length(new_guess_set)
        curr_max = 0.0

        #str1 = "wordle_guess_perf"
        #io = open(str1, "w")
        for i = 1:N
            new_guess = new_guess_set[i]
            tmp = evaluate_guess(new_guess, new_guess_set, new_sol_set, N)
            performance[i] = tmp
            if tmp >= curr_max
                #display((i, new_guess, tmp))
                curr_max = tmp
            end
            #display((i,guess,tmp))
            if tmp > 10000
                break
            end
            #str = string(i)*" , "*guess*" , "*string(tmp)
            #write(io, str * "\n")
        end
        #close(io)
        str = new_guess_set[findall(x -> x == maximum(performance), performance)][1]
        println("The best next guess is: $(str)")

        return new_guess_set, new_sol_set
    end
        

end

##
##
## EXAMPLE
##
##


# Using this program: 
# Choose your starting word at https://wordle.at , e.g., "TARNE" 
# Enter it and generate the indicator according to
# the colors return by the website. Let's assume the solution is 
# "KIOSK". Then, when starting with "TARNE", the indicator woud be [0,0,0,0,0] 
# i.e., none of the letters in TARNE appear in the solution
# Run the function 

guesses, solutions = best_next("TARNE", [0,0,0,0,0], possible_solutions, accepted_guesses);

# There are 442 possible guesses left. 
# The program says "MULIS" is the best guess
# Entering it would lead to the indicator [0,0,0,1,1]
# Run programm again:

guesses, solutions = best_next("MULIS", [0,0,0,1,1], solutions, guesses);

# Only 12 possible guesses left.  
# Let's try "FISCH" as the programm suggest
# The indicator would be [0,2,1,0,0]
# Running the programm again we get

guesses, solutions = best_next("FISCH", [0,2,1,0,0], solutions, guesses);

# And the program returns the correct solution at last. 