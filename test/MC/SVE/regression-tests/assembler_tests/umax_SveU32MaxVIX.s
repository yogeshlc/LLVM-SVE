// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
umax    z21.s, z21.s, #170  // 00100101-10101001-11010101-01010101
// CHECK: umax    z21.s, z21.s, #170 // encoding: [0x55,0xd5,0xa9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101001-11010101-01010101
UMAX    Z21.S, Z21.S, #170  // 00100101-10101001-11010101-01010101
// CHECK: umax    z21.s, z21.s, #170 // encoding: [0x55,0xd5,0xa9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101001-11010101-01010101
umax    z23.s, z23.s, #109  // 00100101-10101001-11001101-10110111
// CHECK: umax    z23.s, z23.s, #109 // encoding: [0xb7,0xcd,0xa9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101001-11001101-10110111
UMAX    Z23.S, Z23.S, #109  // 00100101-10101001-11001101-10110111
// CHECK: umax    z23.s, z23.s, #109 // encoding: [0xb7,0xcd,0xa9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101001-11001101-10110111
umax    z0.s, z0.s, #0  // 00100101-10101001-11000000-00000000
// CHECK: umax    z0.s, z0.s, #0 // encoding: [0x00,0xc0,0xa9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101001-11000000-00000000
UMAX    Z0.S, Z0.S, #0  // 00100101-10101001-11000000-00000000
// CHECK: umax    z0.s, z0.s, #0 // encoding: [0x00,0xc0,0xa9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101001-11000000-00000000
umax    z31.s, z31.s, #255  // 00100101-10101001-11011111-11111111
// CHECK: umax    z31.s, z31.s, #255 // encoding: [0xff,0xdf,0xa9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101001-11011111-11111111
UMAX    Z31.S, Z31.S, #255  // 00100101-10101001-11011111-11111111
// CHECK: umax    z31.s, z31.s, #255 // encoding: [0xff,0xdf,0xa9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101001-11011111-11111111
