module SparseDiffTools

using Compat
using FiniteDiff
using ForwardDiff
using Graphs
using Graphs: SimpleGraph
using Requires
using VertexSafeGraphs
using Adapt

using LinearAlgebra
using SparseArrays, ArrayInterfaceCore

import StaticArrays, ArrayInterfaceStaticArrays

using ForwardDiff: Dual, jacobian, partials, DEFAULT_CHUNK_THRESHOLD
using DataStructures: DisjointSets, find_root!, union!

using ArrayInterfaceCore: matrix_colors

export contract_color,
       greedy_d1,
       greedy_star1_coloring,
       greedy_star2_coloring,
       matrix2graph,
       matrix_colors,
       forwarddiff_color_jacobian!,
       forwarddiff_color_jacobian,
       ForwardColorJacCache,
       numauto_color_hessian!,
       numauto_color_hessian,
       autoauto_color_hessian!,
       autoauto_color_hessian,
       ForwardColorHesCache,
       ForwardAutoColorHesCache,
       auto_jacvec, auto_jacvec!,
       num_jacvec, num_jacvec!,
       num_vecjac, num_vecjac!,
       num_hesvec, num_hesvec!,
       numauto_hesvec, numauto_hesvec!,
       autonum_hesvec, autonum_hesvec!,
       num_hesvecgrad, num_hesvecgrad!,
       auto_hesvecgrad, auto_hesvecgrad!,
       JacVec, HesVec, HesVecGrad

include("coloring/high_level.jl")
include("coloring/backtracking_coloring.jl")
include("coloring/contraction_coloring.jl")
include("coloring/greedy_d1_coloring.jl")
include("coloring/acyclic_coloring.jl")
include("coloring/greedy_star1_coloring.jl")
include("coloring/greedy_star2_coloring.jl")
include("coloring/matrix2graph.jl")
include("differentiation/compute_jacobian_ad.jl")
include("differentiation/compute_hessian_ad.jl")
include("differentiation/jaches_products.jl")
include("differentiation/vecjac_products.jl")

Base.@pure __parameterless_type(T) = Base.typename(T).wrapper
parameterless_type(x) = parameterless_type(typeof(x))
parameterless_type(x::Type) = __parameterless_type(x)

function __init__()
    @require Zygote="e88e6eb3-aa80-5325-afca-941959d7151f" begin
        export numback_hesvec, numback_hesvec!, autoback_hesvec, autoback_hesvec!,
               auto_vecjac, auto_vecjac!

        include("differentiation/vecjac_products_zygote.jl")
        include("differentiation/jaches_products_zygote.jl")
    end
end

end # module
