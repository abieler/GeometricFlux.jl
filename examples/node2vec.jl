using GeometricFlux
using GraphSignals
using Graphs
using SparseArrays
using Plots
using GraphPlot

using TSne
using Clustering
using Cairo, Compose


function alias_sampling_example()
    J, q = alias_setup([0.05, 0.1, 0.2, 0.3, 0.2, 0.1, 0.05])
    samples = [alias_sample(J, q) for _ in 1:1000]
    counts = countmap(samples)
    for i in 1:7
        println(i, ": ", counts[i])
    end
end


clusters = Dict(
3 => 1,
14 => 1,
20 => 1,
8 => 1,
2 => 1,
1 => 1,
4 => 1,
18 => 1,
13 => 1,
22 => 1,
12 => 1,
5 => 1,
6 => 1,
11 => 1,
7 => 1,
17 => 1,
32 => 2,
25 => 2,
26 => 2,
28 => 2,
29 => 2,
24 => 2,
9 => 2,
19 => 2,
33 => 2,
34 => 2,
21 => 2,
30 => 2,
31 => 2,
16 => 2,
27 => 2,
15 => 2,
23 => 2,
10 => 2,
)
int2col_symbol(x::Int) = x==1 ? :blue : :red
int2col_str(x::Int) = x==1 ? "blue" : "red"


function n2v()
    g = smallgraph(:karate)
    fg = FeaturedGraph(g)
    vectors = node2vec(fg; walks_per_node=10, len=80, p=1.0, q=1.0)
    println(typeof(vectors))
    points = tsne(vectors')
    point_tuples = [tuple(row...) for row in eachrow(points)]
    R = kmeans(vectors, 2)
    display(scatter(point_tuples, markercolor=[int2col_symbol(assignments(R)[i]) for i in 1:34] ))

    draw(
        PDF("karateclub.pdf", 16cm, 16cm),
        gplot(g,
            nodelabel=map(string, 1:34),
            nodefillc=[int2col_str(assignments(R)[i]) for i in 1:34]

        )
    )
end



# alias_sampling_example()
# sample_random_walk()
