// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E3Load4LSSZ
// Offset register Rm cannot be xzr
ld3w {z19.s, z20.s, z21.s}, p2/z, [x9, xzr, lsl #2]
// CHECK: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
