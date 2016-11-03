// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqdecp  x21, p10.s, w21  // 00100101-10101010-10001001-01010101
// CHECK: sqdecp  x21, p10.s, w21 // encoding: [0x55,0x89,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-10001001-01010101
SQDECP  X21, P10.S, W21  // 00100101-10101010-10001001-01010101
// CHECK: sqdecp  x21, p10.s, w21 // encoding: [0x55,0x89,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-10001001-01010101
sqdecp  x0, p0.s, w0  // 00100101-10101010-10001000-00000000
// CHECK: sqdecp  x0, p0.s, w0 // encoding: [0x00,0x88,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-10001000-00000000
SQDECP  X0, P0.S, W0  // 00100101-10101010-10001000-00000000
// CHECK: sqdecp  x0, p0.s, w0 // encoding: [0x00,0x88,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-10001000-00000000
sqdecp  x23, p13.s, w23  // 00100101-10101010-10001001-10110111
// CHECK: sqdecp  x23, p13.s, w23 // encoding: [0xb7,0x89,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-10001001-10110111
SQDECP  X23, P13.S, W23  // 00100101-10101010-10001001-10110111
// CHECK: sqdecp  x23, p13.s, w23 // encoding: [0xb7,0x89,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-10001001-10110111
sqdecp  xzr, p15.s, wzr  // 00100101-10101010-10001001-11111111
// CHECK: sqdecp  xzr, p15.s, wzr // encoding: [0xff,0x89,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-10001001-11111111
SQDECP  XZR, P15.S, WZR  // 00100101-10101010-10001001-11111111
// CHECK: sqdecp  xzr, p15.s, wzr // encoding: [0xff,0x89,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-10001001-11111111
