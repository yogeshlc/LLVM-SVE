// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
asrd    z23.d, p3/m, z23.d, #19  // 00000100-11000100-10001101-10110111
// CHECK: asrd    z23.d, p3/m, z23.d, #19 // encoding: [0xb7,0x8d,0xc4,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000100-10001101-10110111
ASRD    Z23.D, P3/M, Z23.D, #19  // 00000100-11000100-10001101-10110111
// CHECK: asrd    z23.d, p3/m, z23.d, #19 // encoding: [0xb7,0x8d,0xc4,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000100-10001101-10110111
asrd    z0.d, p0/m, z0.d, #64  // 00000100-10000100-10000000-00000000
// CHECK: asrd    z0.d, p0/m, z0.d, #64 // encoding: [0x00,0x80,0x84,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000100-10000000-00000000
ASRD    Z0.D, P0/M, Z0.D, #64  // 00000100-10000100-10000000-00000000
// CHECK: asrd    z0.d, p0/m, z0.d, #64 // encoding: [0x00,0x80,0x84,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000100-10000000-00000000
asrd    z31.d, p7/m, z31.d, #1  // 00000100-11000100-10011111-11111111
// CHECK: asrd    z31.d, p7/m, z31.d, #1 // encoding: [0xff,0x9f,0xc4,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000100-10011111-11111111
ASRD    Z31.D, P7/M, Z31.D, #1  // 00000100-11000100-10011111-11111111
// CHECK: asrd    z31.d, p7/m, z31.d, #1 // encoding: [0xff,0x9f,0xc4,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000100-10011111-11111111
asrd    z21.d, p5/m, z21.d, #22  // 00000100-11000100-10010101-01010101
// CHECK: asrd    z21.d, p5/m, z21.d, #22 // encoding: [0x55,0x95,0xc4,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000100-10010101-01010101
ASRD    Z21.D, P5/M, Z21.D, #22  // 00000100-11000100-10010101-01010101
// CHECK: asrd    z21.d, p5/m, z21.d, #22 // encoding: [0x55,0x95,0xc4,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000100-10010101-01010101
