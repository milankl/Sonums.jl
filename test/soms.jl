using SOM
using PyCall
using PyPlot


# create training data
N = 10000
x1 = randn(N)
y1 = rand(N)

train = hcat(x1,y1)

# intialise

nx = 50
ny = 2
global som = initSOM(train,nx,ny,topol=:hexagonal)

inicodes = deepcopy(som.grid)
inicodes[:,1] /= maximum(inicodes[:,1])
inicodes[:,1] *= (maximum(train[:,1]) - minimum(train[:,1]))

inicodes[:,2] /= maximum(inicodes[:,2])
inicodes[:,2] *= (maximum(train[:,2]) - minimum(train[:,2]))

inicodes[:,1] .+= minimum(train[:,1])
inicodes[:,2] .+= minimum(train[:,2])

som.codes[:,:] = inicodes

##

som = trainSOM(som,train,100000,kernelFun=bubbleKernel)

##

ioff()

fig,ax = subplots(1,1)

ax.plot(train[:,1],train[:,2],".",ms=3,alpha=0.1)

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

#lnodes, = ax.plot(som.codes[:,1],som.codes[:,2],"w.",ms=1,markeredgecolor="k")
ax.scatter(som.codes[:,1],som.codes[:,2],40,som.population,edgecolor="k",cmap="rainbow",zorder=10)
tight_layout()
savefig("/local/home/kloewer/somdata/frames/frame0000.png")

##
for ii = 1:100

    global som = trainSOM(som,train,100)

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
