// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmin    z31.d, p7/m, z31.d, #1.0  // 01100101-11011111-10011100-00111111
// CHECK: fmin    z31.d, p7/m, z31.d, #1.0{{0*}} // encoding: [0x3f,0x9c,0xdf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011111-10011100-00111111
FMIN    Z31.D, P7/M, Z31.D, #1.0  // 01100101-11011111-10011100-00111111
// CHECK: fmin    z31.d, p7/m, z31.d, #1.0{{0*}} // encoding: [0x3f,0x9c,0xdf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011111-10011100-00111111
fmin    z21.d, p5/m, z21.d, #0.0  // 01100101-11011111-10010100-00010101
// CHECK: fmin    z21.d, p5/m, z21.d, #0.0{{0*}} // encoding: [0x15,0x94,0xdf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011111-10010100-00010101
FMIN    Z21.D, P5/M, Z21.D, #0.0  // 01100101-11011111-10010100-00010101
// CHECK: fmin    z21.d, p5/m, z21.d, #0.0{{0*}} // encoding: [0x15,0x94,0xdf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011111-10010100-00010101
fmin    z23.d, p3/m, z23.d, #1.0  // 01100101-11011111-10001100-00110111
// CHECK: fmin    z23.d, p3/m, z23.d, #1.0{{0*}} // encoding: [0x37,0x8c,0xdf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011111-10001100-00110111
FMIN    Z23.D, P3/M, Z23.D, #1.0  // 01100101-11011111-10001100-00110111
// CHECK: fmin    z23.d, p3/m, z23.d, #1.0{{0*}} // encoding: [0x37,0x8c,0xdf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011111-10001100-00110111
fmin    z0.d, p0/m, z0.d, #0.0  // 01100101-11011111-10000000-00000000
// CHECK: fmin    z0.d, p0/m, z0.d, #0.0{{0*}} // encoding: [0x00,0x80,0xdf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011111-10000000-00000000
FMIN    Z0.D, P0/M, Z0.D, #0.0  // 01100101-11011111-10000000-00000000
// CHECK: fmin    z0.d, p0/m, z0.d, #0.0{{0*}} // encoding: [0x00,0x80,0xdf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011111-10000000-00000000
