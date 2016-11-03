// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fsub    z21.s, p5/m, z21.s, #0.5  // 01100101-10011001-10010100-00010101
// CHECK: fsub    z21.s, p5/m, z21.s, #0.5{{0*}} // encoding: [0x15,0x94,0x99,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011001-10010100-00010101
FSUB    Z21.S, P5/M, Z21.S, #0.5  // 01100101-10011001-10010100-00010101
// CHECK: fsub    z21.s, p5/m, z21.s, #0.5{{0*}} // encoding: [0x15,0x94,0x99,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011001-10010100-00010101
fsub    z0.s, p0/m, z0.s, #0.5  // 01100101-10011001-10000000-00000000
// CHECK: fsub    z0.s, p0/m, z0.s, #0.5{{0*}} // encoding: [0x00,0x80,0x99,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011001-10000000-00000000
FSUB    Z0.S, P0/M, Z0.S, #0.5  // 01100101-10011001-10000000-00000000
// CHECK: fsub    z0.s, p0/m, z0.s, #0.5{{0*}} // encoding: [0x00,0x80,0x99,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011001-10000000-00000000
fsub    z31.s, p7/m, z31.s, #1.0  // 01100101-10011001-10011100-00111111
// CHECK: fsub    z31.s, p7/m, z31.s, #1.0{{0*}} // encoding: [0x3f,0x9c,0x99,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011001-10011100-00111111
FSUB    Z31.S, P7/M, Z31.S, #1.0  // 01100101-10011001-10011100-00111111
// CHECK: fsub    z31.s, p7/m, z31.s, #1.0{{0*}} // encoding: [0x3f,0x9c,0x99,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011001-10011100-00111111
fsub    z23.s, p3/m, z23.s, #1.0  // 01100101-10011001-10001100-00110111
// CHECK: fsub    z23.s, p3/m, z23.s, #1.0{{0*}} // encoding: [0x37,0x8c,0x99,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011001-10001100-00110111
FSUB    Z23.S, P3/M, Z23.S, #1.0  // 01100101-10011001-10001100-00110111
// CHECK: fsub    z23.s, p3/m, z23.s, #1.0{{0*}} // encoding: [0x37,0x8c,0x99,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011001-10001100-00110111
