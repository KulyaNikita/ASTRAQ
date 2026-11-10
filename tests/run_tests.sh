#!/bin/sh
# Run ASTRAQ on the small examples in tests/data and compare with tests/expected.
#
# Usage: sh tests/run_tests.sh [path/to/ASTRAQ]   (default: ASTRAQ on the PATH)
#
# The inputs hold every quartet of a 6-taxon tree, so the correct answer is known:
#   T1 = ((A,B),C,D,(E,F))      written as (A,(B,(C,(D,(E,F)))));
#   T2 = ((A,D),E,(B,(C,F)))    written as (A,(D,(E,(B,(C,F)))));
#   newick.txt       T1 quartets, Newick format, no weights
#   plain.txt        T1 quartets, plain "A B C D" format
#   weighted_t1.txt  T1 quartets (weight 5) and T2 quartets (weight 2): expect T1
#   weighted_t2.txt  the same with the weights swapped: expect T2

ASTRAQ=${1:-ASTRAQ}
DIR=$(cd "$(dirname "$0")" && pwd)
OUT=$DIR/out
mkdir -p "$OUT"

"$ASTRAQ" --version || { echo "FAIL: cannot run $ASTRAQ"; exit 1; }

failed=0
check() {
    input=$1 expected=$2 threads=$3
    name=$(basename "$input" .txt)_t$threads
    if "$ASTRAQ" -q "$DIR/data/$input" -o "$OUT/$name.tre" -t "$threads" > "$OUT/$name.log" 2>&1 \
        && cmp -s "$OUT/$name.tre" "$DIR/expected/$expected"; then
        echo "PASS: $name"
    else
        echo "FAIL: $name"
        echo "  expected: $(cat "$DIR/expected/$expected")"
        echo "  got:      $(cat "$OUT/$name.tre" 2>/dev/null)"
        sed 's/^/  log: /' "$OUT/$name.log"
        failed=1
    fi
}

for threads in 1 2; do
    check newick.txt      t1.tre "$threads"
    check plain.txt       t1.tre "$threads"
    check weighted_t1.txt t1.tre "$threads"
    check weighted_t2.txt t2.tre "$threads"
done

[ "$failed" -eq 0 ] && echo "All tests passed."
exit "$failed"
