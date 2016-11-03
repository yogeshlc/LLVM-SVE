// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E4Store8LSSZ
// Offset register Rm cannot be xzr
st4d {z15.d, z16.d, z17.d, z18.d}, p2, [x5, xzr, lsl #3]
// CHECK: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
