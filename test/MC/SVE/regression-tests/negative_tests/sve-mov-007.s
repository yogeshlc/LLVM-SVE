// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32MovDupS
// Immediate not compatible with encode/decode function.
mov z26.s, s26, #64
// CHECK: {{(error\:\ immediate\ must\ be\ an\ integer\ in\ range\ \[\-128\,\ 255\]\ with\ a\ shift\ amount\ of\ 0)|(error\:\ immediate\ must\ be\ an\ integer\ in\ range\ \[\-128\,\ 127\]\ or\ a\ multiple\ of\ 256\ in\ range\ \[\-32768\,\ 32512\])}}
