// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E4Load8LSSZ
// Offset register Rm cannot be xzr
ld4d {z14.d, z15.d, z16.d, z17.d}, p1/z, [x25, xzr, lsl #3]
// CHECK: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
