// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
smin    z21.b, z21.b, #-86  // 00100101-00101010-11010101-01010101
// CHECK: smin    z21.b, z21.b, #-86 // encoding: [0x55,0xd5,0x2a,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101010-11010101-01010101
SMIN    Z21.B, Z21.B, #-86  // 00100101-00101010-11010101-01010101
// CHECK: smin    z21.b, z21.b, #-86 // encoding: [0x55,0xd5,0x2a,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101010-11010101-01010101
smin    z31.b, z31.b, #-1  // 00100101-00101010-11011111-11111111
// CHECK: smin    z31.b, z31.b, #-1 // encoding: [0xff,0xdf,0x2a,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101010-11011111-11111111
SMIN    Z31.B, Z31.B, #-1  // 00100101-00101010-11011111-11111111
// CHECK: smin    z31.b, z31.b, #-1 // encoding: [0xff,0xdf,0x2a,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101010-11011111-11111111
smin    z0.b, z0.b, #0  // 00100101-00101010-11000000-00000000
// CHECK: smin    z0.b, z0.b, #0 // encoding: [0x00,0xc0,0x2a,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101010-11000000-00000000
SMIN    Z0.B, Z0.B, #0  // 00100101-00101010-11000000-00000000
// CHECK: smin    z0.b, z0.b, #0 // encoding: [0x00,0xc0,0x2a,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101010-11000000-00000000
smin    z23.b, z23.b, #109  // 00100101-00101010-11001101-10110111
// CHECK: smin    z23.b, z23.b, #109 // encoding: [0xb7,0xcd,0x2a,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101010-11001101-10110111
SMIN    Z23.B, Z23.B, #109  // 00100101-00101010-11001101-10110111
// CHECK: smin    z23.b, z23.b, #109 // encoding: [0xb7,0xcd,0x2a,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101010-11001101-10110111
