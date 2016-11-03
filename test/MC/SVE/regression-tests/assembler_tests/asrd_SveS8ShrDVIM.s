// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
asrd    z23.b, p3/m, z23.b, #3  // 00000100-00000100-10001101-10110111
// CHECK: asrd    z23.b, p3/m, z23.b, #3 // encoding: [0xb7,0x8d,0x04,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000100-10001101-10110111
ASRD    Z23.B, P3/M, Z23.B, #3  // 00000100-00000100-10001101-10110111
// CHECK: asrd    z23.b, p3/m, z23.b, #3 // encoding: [0xb7,0x8d,0x04,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000100-10001101-10110111
asrd    z31.b, p7/m, z31.b, #1  // 00000100-00000100-10011101-11111111
// CHECK: asrd    z31.b, p7/m, z31.b, #1 // encoding: [0xff,0x9d,0x04,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000100-10011101-11111111
ASRD    Z31.B, P7/M, Z31.B, #1  // 00000100-00000100-10011101-11111111
// CHECK: asrd    z31.b, p7/m, z31.b, #1 // encoding: [0xff,0x9d,0x04,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000100-10011101-11111111
asrd    z0.b, p0/m, z0.b, #8  // 00000100-00000100-10000001-00000000
// CHECK: asrd    z0.b, p0/m, z0.b, #8 // encoding: [0x00,0x81,0x04,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000100-10000001-00000000
ASRD    Z0.B, P0/M, Z0.B, #8  // 00000100-00000100-10000001-00000000
// CHECK: asrd    z0.b, p0/m, z0.b, #8 // encoding: [0x00,0x81,0x04,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000100-10000001-00000000
asrd    z21.b, p5/m, z21.b, #6  // 00000100-00000100-10010101-01010101
// CHECK: asrd    z21.b, p5/m, z21.b, #6 // encoding: [0x55,0x95,0x04,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000100-10010101-01010101
ASRD    Z21.B, P5/M, Z21.B, #6  // 00000100-00000100-10010101-01010101
// CHECK: asrd    z21.b, p5/m, z21.b, #6 // encoding: [0x55,0x95,0x04,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000100-10010101-01010101
