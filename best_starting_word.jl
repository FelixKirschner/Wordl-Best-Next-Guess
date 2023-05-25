cd(@__DIR__)
include("aux_functions.jl")
##
## This code runs over all possible guesses
## and assigns a value to them indicating
## how much the set of possible solutions
## shrinks on average when starting with 
## this word. 
##

##
## Best starting word "TARNE" value -> 0.9196271872904803
##

performance = [0.0 for i = 1:length(accepted_guesses)]
N = length(accepted_guesses)
curr_max = 0.0

str1 = "wordle_guess_perf"
io = open(str1, "w")
@time for i = 1:N
    guess = accepted_guesses[i]
    tmp = evaluate_guess(guess, accepted_guesses, possible_solutions, N)
    performance[i] = tmp
    if tmp >= curr_max
        display((i,guess, tmp))
        curr_max = tmp
    end
    if tmp > 10000
        break
    end
    str = string(i)*" , "*guess*" , "*string(tmp)
    write(io, str * "\n")
end
close(io)

accepted_guesses[findall(x -> x == maximum(performance), performance)]




