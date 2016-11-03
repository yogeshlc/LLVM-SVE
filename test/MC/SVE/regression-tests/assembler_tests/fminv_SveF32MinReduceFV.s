// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fminv   s0, p0, z0.s  // 01100101-10000111-00100000-00000000
// CHECK: fminv   s0, p0, z0.s // encoding: [0x00,0x20,0x87,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000111-00100000-00000000
FMINV   S0, P0, Z0.S  // 01100101-10000111-00100000-00000000
// CHECK: fminv   s0, p0, z0.s // encoding: [0x00,0x20,0x87,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000111-00100000-00000000
fminv   s23, p3, z13.s  // 01100101-10000111-00101101-10110111
// CHECK: fminv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x87,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000111-00101101-10110111
FMINV   S23, P3, Z13.S  // 01100101-10000111-00101101-10110111
// CHECK: fminv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x87,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000111-00101101-10110111
fminv   s31, p7, z31.s  // 01100101-10000111-00111111-11111111
// CHECK: fminv   s31, p7, z31.s // encoding: [0xff,0x3f,0x87,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000111-00111111-11111111
FMINV   S31, P7, Z31.S  // 01100101-10000111-00111111-11111111
// CHECK: fminv   s31, p7, z31.s // encoding: [0xff,0x3f,0x87,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000111-00111111-11111111
fminv   s21, p5, z10.s  // 01100101-10000111-00110101-01010101
// CHECK: fminv   s21, p5, z10.s // encoding: [0x55,0x35,0x87,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000111-00110101-01010101
FMINV   S21, P5, Z10.S  // 01100101-10000111-00110101-01010101
// CHECK: fminv   s21, p5, z10.s // encoding: [0x55,0x35,0x87,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000111-00110101-01010101
