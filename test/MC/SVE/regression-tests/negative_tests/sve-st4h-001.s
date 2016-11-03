// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E4Store2LSSZ
// Offset register Rm cannot be xzr
st4h {z21.h, z22.h, z23.h, z24.h}, p1, [x9, xzr, lsl #1]
// CHECK: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
