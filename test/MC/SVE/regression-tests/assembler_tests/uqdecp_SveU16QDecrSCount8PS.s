// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqdecp  x0, p0.h  // 00100101-01101011-10001100-00000000
// CHECK: uqdecp  x0, p0.h // encoding: [0x00,0x8c,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001100-00000000
UQDECP  X0, P0.H  // 00100101-01101011-10001100-00000000
// CHECK: uqdecp  x0, p0.h // encoding: [0x00,0x8c,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001100-00000000
uqdecp  x21, p10.h  // 00100101-01101011-10001101-01010101
// CHECK: uqdecp  x21, p10.h // encoding: [0x55,0x8d,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001101-01010101
UQDECP  X21, P10.H  // 00100101-01101011-10001101-01010101
// CHECK: uqdecp  x21, p10.h // encoding: [0x55,0x8d,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001101-01010101
uqdecp  xzr, p15.h  // 00100101-01101011-10001101-11111111
// CHECK: uqdecp  xzr, p15.h // encoding: [0xff,0x8d,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001101-11111111
UQDECP  XZR, P15.H  // 00100101-01101011-10001101-11111111
// CHECK: uqdecp  xzr, p15.h // encoding: [0xff,0x8d,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001101-11111111
uqdecp  x23, p13.h  // 00100101-01101011-10001101-10110111
// CHECK: uqdecp  x23, p13.h // encoding: [0xb7,0x8d,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001101-10110111
UQDECP  X23, P13.H  // 00100101-01101011-10001101-10110111
// CHECK: uqdecp  x23, p13.h // encoding: [0xb7,0x8d,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-10001101-10110111
