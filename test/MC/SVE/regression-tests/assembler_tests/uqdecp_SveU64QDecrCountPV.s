// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqdecp  z31.d, p15  // 00100101-11101011-10000001-11111111
// CHECK: uqdecp  z31.d, p15 // encoding: [0xff,0x81,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10000001-11111111
UQDECP  Z31.D, P15  // 00100101-11101011-10000001-11111111
// CHECK: uqdecp  z31.d, p15 // encoding: [0xff,0x81,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10000001-11111111
uqdecp  z21.d, p10  // 00100101-11101011-10000001-01010101
// CHECK: uqdecp  z21.d, p10 // encoding: [0x55,0x81,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10000001-01010101
UQDECP  Z21.D, P10  // 00100101-11101011-10000001-01010101
// CHECK: uqdecp  z21.d, p10 // encoding: [0x55,0x81,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10000001-01010101
uqdecp  z0.d, p0  // 00100101-11101011-10000000-00000000
// CHECK: uqdecp  z0.d, p0 // encoding: [0x00,0x80,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10000000-00000000
UQDECP  Z0.D, P0  // 00100101-11101011-10000000-00000000
// CHECK: uqdecp  z0.d, p0 // encoding: [0x00,0x80,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10000000-00000000
uqdecp  z23.d, p13  // 00100101-11101011-10000001-10110111
// CHECK: uqdecp  z23.d, p13 // encoding: [0xb7,0x81,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10000001-10110111
UQDECP  Z23.D, P13  // 00100101-11101011-10000001-10110111
// CHECK: uqdecp  z23.d, p13 // encoding: [0xb7,0x81,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-10000001-10110111
