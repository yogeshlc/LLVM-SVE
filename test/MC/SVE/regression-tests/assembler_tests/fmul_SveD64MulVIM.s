// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmul    z0.d, p0/m, z0.d, #0.5  // 01100101-11011010-10000000-00000000
// CHECK: fmul    z0.d, p0/m, z0.d, #0.5{{0*}} // encoding: [0x00,0x80,0xda,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011010-10000000-00000000
FMUL    Z0.D, P0/M, Z0.D, #0.5  // 01100101-11011010-10000000-00000000
// CHECK: fmul    z0.d, p0/m, z0.d, #0.5{{0*}} // encoding: [0x00,0x80,0xda,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011010-10000000-00000000
fmul    z31.d, p7/m, z31.d, #2.0  // 01100101-11011010-10011100-00111111
// CHECK: fmul    z31.d, p7/m, z31.d, #2.0{{0*}} // encoding: [0x3f,0x9c,0xda,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011010-10011100-00111111
FMUL    Z31.D, P7/M, Z31.D, #2.0  // 01100101-11011010-10011100-00111111
// CHECK: fmul    z31.d, p7/m, z31.d, #2.0{{0*}} // encoding: [0x3f,0x9c,0xda,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011010-10011100-00111111
fmul    z21.d, p5/m, z21.d, #0.5  // 01100101-11011010-10010100-00010101
// CHECK: fmul    z21.d, p5/m, z21.d, #0.5{{0*}} // encoding: [0x15,0x94,0xda,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011010-10010100-00010101
FMUL    Z21.D, P5/M, Z21.D, #0.5  // 01100101-11011010-10010100-00010101
// CHECK: fmul    z21.d, p5/m, z21.d, #0.5{{0*}} // encoding: [0x15,0x94,0xda,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011010-10010100-00010101
fmul    z23.d, p3/m, z23.d, #2.0  // 01100101-11011010-10001100-00110111
// CHECK: fmul    z23.d, p3/m, z23.d, #2.0{{0*}} // encoding: [0x37,0x8c,0xda,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011010-10001100-00110111
FMUL    Z23.D, P3/M, Z23.D, #2.0  // 01100101-11011010-10001100-00110111
// CHECK: fmul    z23.d, p3/m, z23.d, #2.0{{0*}} // encoding: [0x37,0x8c,0xda,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011010-10001100-00110111
