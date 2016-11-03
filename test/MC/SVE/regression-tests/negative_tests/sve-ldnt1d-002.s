// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoadNT8SIZ
// Restricted predicate has range [0, 7].
ldnt1d z28.d, p8/z, [x8, #8, MUL VL]
// CHECK: error: invalid operand
