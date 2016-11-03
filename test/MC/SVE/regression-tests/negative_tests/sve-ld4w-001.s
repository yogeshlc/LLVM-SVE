// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32E4Load4LSSZ
// Offset register Rm cannot be xzr
ld4w {z7.s, z8.s, z9.s, z10.s}, p5/z, [x28, xzr, lsl #2]
// CHECK: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
