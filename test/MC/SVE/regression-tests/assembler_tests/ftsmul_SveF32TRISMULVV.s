// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ftsmul  z0.s, z0.s, z0.s  // 01100101-10000000-00001100-00000000
// CHECK: ftsmul  z0.s, z0.s, z0.s // encoding: [0x00,0x0c,0x80,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000000-00001100-00000000
FTSMUL  Z0.S, Z0.S, Z0.S  // 01100101-10000000-00001100-00000000
// CHECK: ftsmul  z0.s, z0.s, z0.s // encoding: [0x00,0x0c,0x80,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000000-00001100-00000000
ftsmul  z31.s, z31.s, z31.s  // 01100101-10011111-00001111-11111111
// CHECK: ftsmul  z31.s, z31.s, z31.s // encoding: [0xff,0x0f,0x9f,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011111-00001111-11111111
FTSMUL  Z31.S, Z31.S, Z31.S  // 01100101-10011111-00001111-11111111
// CHECK: ftsmul  z31.s, z31.s, z31.s // encoding: [0xff,0x0f,0x9f,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10011111-00001111-11111111
ftsmul  z21.s, z10.s, z21.s  // 01100101-10010101-00001101-01010101
// CHECK: ftsmul  z21.s, z10.s, z21.s // encoding: [0x55,0x0d,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-00001101-01010101
FTSMUL  Z21.S, Z10.S, Z21.S  // 01100101-10010101-00001101-01010101
// CHECK: ftsmul  z21.s, z10.s, z21.s // encoding: [0x55,0x0d,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-00001101-01010101
ftsmul  z23.s, z13.s, z8.s  // 01100101-10001000-00001101-10110111
// CHECK: ftsmul  z23.s, z13.s, z8.s // encoding: [0xb7,0x0d,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-00001101-10110111
FTSMUL  Z23.S, Z13.S, Z8.S  // 01100101-10001000-00001101-10110111
// CHECK: ftsmul  z23.s, z13.s, z8.s // encoding: [0xb7,0x0d,0x88,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10001000-00001101-10110111
