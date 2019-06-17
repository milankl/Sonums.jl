using SOM
using PyCall
using PyPlot


# create training data
N = 10000
x1 = randn(N) .+ 3
x2 = randn(N) .- 3

y1 = randn(N) .+ 0
y2 = randn(N) .- 0

train = hcat(vcat(x1,x2),vcat(y1,y2))

# intialise

nx = 10
ny = 8
global som = initSOM(train,nx,ny,topol=:rectangular)

ioff()

fig,ax = subplots(1,1)

ax.plot(train[:,1],train[:,2],"C0.",ms=3,alpha=0.1)

# add grid in x direction
lx = Array{PyCall.PyObject,1}(undef,ny)
ly = Array{PyCall.PyObject,1}(undef,nx)

for j in 1:ny
    istart = nx*(j-1)+1
    iend = nx*j
    global lx[j], = ax.plot(som.codes[istart:iend,1],som.codes[istart:iend,2],"k",lw=1)
end

# add grid in y direction
for i in 1:nx
    global ly[i], = ax.plot(som.codes[i:nx:end,1],som.codes[i:nx:end,2],"k",lw=1)
end

lnodes, = ax.plot(som.codes[:,1],som.codes[:,2],"w.",ms=10,markeredgecolor="k")
tight_layout()

##
for ii = 1:500

    global som = trainSOM(som,train,10)

    for j in 1:ny
        istart = nx*(j-1)+1
        iend = nx*j
        lx[j].set_data(som.codes[istart:iend,1],som.codes[istart:iend,2])
    end

    # add grid in y direction
    for i in 1:nx
        ly[i].set_data(som.codes[i:nx:end,1],som.codes[i:nx:end,2])
    end

    lnodes.set_data(som.codes[:,1],som.codes[:,2])

    savefig("/local/home/kloewer/somdata/frames/frame$(lpad(ii,4,"0")).png")
    println(ii)

end

close(fig)
