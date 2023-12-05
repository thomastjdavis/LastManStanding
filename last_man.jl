using Plots, Random

"""
    coin(n::Int64) = rand([0,1],n)
    coin()=coin(1)
simulates n coin flips, 
without an argument, simulates
1 coin flip"""
coin(n::Int64) = rand([0,1],n)
#for just one coin
coin()=coin(1)

#simulates a trial, ie. fliping over the n alive tiles repeatedly, and removing the "dead" tiles

"""
    flips(start::Float64)
simulates a trial, ie. fliping over the n alive tiles repeatedly, and removing the "dead" tiles
until all the tiles are removed. This returns an array of the tiles remaining after n steps. 
"""
function flips(start::Int64)
    current_amount=start
    values=[start]
    while(current_amount>0)
        current_amount=count(==(1),coin(current_amount))
        push!(values,current_amount)
    end
    values
end

"""
    example(start::Int64)

first simulates a trial, calling flips(start), then plotting the survivorship curve versus the 
exponential function:

    f(x)=start * (1/2)^x

"""
function example(start::Int64)
    p=plot(;legend=:false,xlabel="Trials",ylabel="Number left")
    f(x)=start*(1/2)^x
    trial=flips(start)
    residual(index)=f(index)-trial(index+1)
    plot!(p,f,xlims=[0,length(trial)])
   # p2=plot(residual,)
    for i in 1:length(trial)
        scatter!([(i-1,trial[i])])
    end
   # vline!(p,[5])
    p
end