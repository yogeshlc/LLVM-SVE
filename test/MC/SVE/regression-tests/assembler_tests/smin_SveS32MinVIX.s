// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
smin    z0.s, z0.s, #0  // 00100101-10101010-11000000-00000000
// CHECK: smin    z0.s, z0.s, #0 // encoding: [0x00,0xc0,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-11000000-00000000
SMIN    Z0.S, Z0.S, #0  // 00100101-10101010-11000000-00000000
// CHECK: smin    z0.s, z0.s, #0 // encoding: [0x00,0xc0,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-11000000-00000000
smin    z31.s, z31.s, #-1  // 00100101-10101010-11011111-11111111
// CHECK: smin    z31.s, z31.s, #-1 // encoding: [0xff,0xdf,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-11011111-11111111
SMIN    Z31.S, Z31.S, #-1  // 00100101-10101010-11011111-11111111
// CHECK: smin    z31.s, z31.s, #-1 // encoding: [0xff,0xdf,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-11011111-11111111
smin    z23.s, z23.s, #109  // 00100101-10101010-11001101-10110111
// CHECK: smin    z23.s, z23.s, #109 // encoding: [0xb7,0xcd,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-11001101-10110111
SMIN    Z23.S, Z23.S, #109  // 00100101-10101010-11001101-10110111
// CHECK: smin    z23.s, z23.s, #109 // encoding: [0xb7,0xcd,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-11001101-10110111
smin    z21.s, z21.s, #-86  // 00100101-10101010-11010101-01010101
// CHECK: smin    z21.s, z21.s, #-86 // encoding: [0x55,0xd5,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-11010101-01010101
SMIN    Z21.S, Z21.S, #-86  // 00100101-10101010-11010101-01010101
// CHECK: smin    z21.s, z21.s, #-86 // encoding: [0x55,0xd5,0xaa,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10101010-11010101-01010101
