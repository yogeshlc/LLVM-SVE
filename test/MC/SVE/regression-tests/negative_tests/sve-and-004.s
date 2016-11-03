// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64AndVIX
// Immediate not compatible with encode/decode function.
and z22.d, z22.d, #4010
// CHECK: error: expected compatible register or logical immediate
