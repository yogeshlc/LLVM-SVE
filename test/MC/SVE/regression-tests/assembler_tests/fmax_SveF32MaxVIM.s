// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmax    z31.s, p7/m, z31.s, #1.0  // 01100101-10011110-10011100-00111111
// CHECK: fmax    z31.s, p7/m, z31.s, #1.0{{0*}} // encoding: [0x3f,0x9c,0x9e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011110-10011100-00111111
FMAX    Z31.S, P7/M, Z31.S, #1.0  // 01100101-10011110-10011100-00111111
// CHECK: fmax    z31.s, p7/m, z31.s, #1.0{{0*}} // encoding: [0x3f,0x9c,0x9e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011110-10011100-00111111
fmax    z0.s, p0/m, z0.s, #0.0  // 01100101-10011110-10000000-00000000
// CHECK: fmax    z0.s, p0/m, z0.s, #0.0{{0*}} // encoding: [0x00,0x80,0x9e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011110-10000000-00000000
FMAX    Z0.S, P0/M, Z0.S, #0.0  // 01100101-10011110-10000000-00000000
// CHECK: fmax    z0.s, p0/m, z0.s, #0.0{{0*}} // encoding: [0x00,0x80,0x9e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011110-10000000-00000000
fmax    z21.s, p5/m, z21.s, #0.0  // 01100101-10011110-10010100-00010101
// CHECK: fmax    z21.s, p5/m, z21.s, #0.0{{0*}} // encoding: [0x15,0x94,0x9e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011110-10010100-00010101
FMAX    Z21.S, P5/M, Z21.S, #0.0  // 01100101-10011110-10010100-00010101
// CHECK: fmax    z21.s, p5/m, z21.s, #0.0{{0*}} // encoding: [0x15,0x94,0x9e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011110-10010100-00010101
fmax    z23.s, p3/m, z23.s, #1.0  // 01100101-10011110-10001100-00110111
// CHECK: fmax    z23.s, p3/m, z23.s, #1.0{{0*}} // encoding: [0x37,0x8c,0x9e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011110-10001100-00110111
FMAX    Z23.S, P3/M, Z23.S, #1.0  // 01100101-10011110-10001100-00110111
// CHECK: fmax    z23.s, p3/m, z23.s, #1.0{{0*}} // encoding: [0x37,0x8c,0x9e,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011110-10001100-00110111
