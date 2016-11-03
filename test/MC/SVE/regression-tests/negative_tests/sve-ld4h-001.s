// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E4Load2LSSZ
// Offset register Rm cannot be xzr
ld4h {z11.h, z12.h, z13.h, z14.h}, p1/z, [x15, xzr, lsl #1]
// CHECK: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
