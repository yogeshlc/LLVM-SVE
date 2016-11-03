// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E3Load2LSSZ
// Offset register Rm cannot be xzr
ld3h {z7.h, z8.h, z9.h}, p0/z, [x5, xzr, lsl #1]
// CHECK: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
