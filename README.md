# ASTRAQ

ASTRAQ reconstructs a phylogeny from quartet tree topologies using constrained dynamic programming to maximize agreement with the input quartets. 
It constructs candidate bipartitions directly from quartet-derived neighbor-joining trees and randomized taxon subsets, without requiring complete gene trees.

Clone the repository and compile with a C++17 compiler (OpenMP is not required):

```bash
git clone https://github.com/KulyaNikita/ASTRAQ.git
cd ASTRAQ
c++ -std=c++17 -O3 ASTRAQ.cpp -o ASTRAQ
./ASTRAQ --help
./ASTRAQ -q quartets.txt -o species.tre
```

`CLI11.hpp` is the accompanying CLI11 header and retains its original license
notice. See `ASTRAQ --help` for supported quartet formats and weights.
