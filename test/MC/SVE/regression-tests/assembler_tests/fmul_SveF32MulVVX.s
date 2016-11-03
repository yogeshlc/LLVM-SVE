// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmul    z21.s, z10.s, z21.s  // 01100101-10010101-00001001-01010101
// CHECK: fmul    z21.s, z10.s, z21.s // encoding: [0x55,0x09,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-00001001-01010101
FMUL    Z21.S, Z10.S, Z21.S  // 01100101-10010101-00001001-01010101
// CHECK: fmul    z21.s, z10.s, z21.s // encoding: [0x55,0x09,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-00001001-01010101
fmul    z31.s, z31.s, z31.s  // 01100101-10011111-00001011-11111111
// CHECK: fmul    z31.s, z31.s, z31.s // encoding: [0xff,0x0b,0x9f,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011111-00001011-11111111
FMUL    Z31.S, Z31.S, Z31.S  // 01100101-10011111-00001011-11111111
// CHECK: fmul    z31.s, z31.s, z31.s // encoding: [0xff,0x0b,0x9f,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011111-00001011-11111111
fmul    z23.s, z13.s, z8.s  // 01100101-10001000-00001001-10110111
// CHECK: fmul    z23.s, z13.s, z8.s // encoding: [0xb7,0x09,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-00001001-10110111
FMUL    Z23.S, Z13.S, Z8.S  // 01100101-10001000-00001001-10110111
// CHECK: fmul    z23.s, z13.s, z8.s // encoding: [0xb7,0x09,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-00001001-10110111
fmul    z0.s, z0.s, z0.s  // 01100101-10000000-00001000-00000000
// CHECK: fmul    z0.s, z0.s, z0.s // encoding: [0x00,0x08,0x80,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000000-00001000-00000000
FMUL    Z0.S, Z0.S, Z0.S  // 01100101-10000000-00001000-00000000
// CHECK: fmul    z0.s, z0.s, z0.s // encoding: [0x00,0x08,0x80,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000000-00001000-00000000
