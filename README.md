# ASTRAQ: Accurate Species Tree Reconstruction by Amalgamating Quartets

ASTRAQ reconstructs a phylogeny from quartet tree topologies using constrained
dynamic programming to maximize agreement with the input quartets. It constructs
candidate bipartitions directly from quartet-derived neighbor-joining trees and
randomized taxon subsets, without requiring complete gene trees.

## Build

You need a C++17 compiler and `make`. ASTRAQ has no other dependencies.

```bash
git clone https://github.com/KulyaNikita/ASTRAQ.git
cd ASTRAQ
make
```

This builds `./ASTRAQ` with OpenMP, so the main computation can run on several
threads (`--threads`). If your compiler has no OpenMP support (for example
Apple clang), build a single-threaded version instead:

```bash
make OPENMP=0
```

The compiler and flags can be changed with the usual variables, for example
`make CXX=clang++ CXXFLAGS="-O2"`.

## Test

```bash
make test
```

This runs ASTRAQ on the small quartet files in `tests/data` and compares the
results with the trees in `tests/expected`.

## Install

```bash
make install                         # installs to /usr/local/bin
make install PREFIX="$HOME/.local"   # installs to ~/.local/bin
```

## Usage

Display the available options or reconstruct a tree from a quartet file:

```bash
./ASTRAQ --help
./ASTRAQ -q quartets.txt -o species.tre
```

Each line of the quartet file holds one quartet, in either format, with an
optional weight (separated by a space or a tab):

```text
A B C D 2
((A,B),(C,D)); 2
```

See `ASTRAQ --help` for all options.

## License

ASTRAQ is free software, distributed under the GNU General Public License,
version 3 or (at your option) any later version (`GPL-3.0-or-later`); see
`LICENSE`.

`CLI11.hpp` is the bundled [CLI11](https://github.com/CLIUtils/CLI11) header
(version 2.6.2). It is distributed under the BSD 3-Clause license, and keeps its
original license notice at the top of the file.
