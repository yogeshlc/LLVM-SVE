// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
not     z23.s, p3/m, z13.s  // 00000100-10011110-10101101-10110111
// CHECK: not     z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x9e,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011110-10101101-10110111
NOT     Z23.S, P3/M, Z13.S  // 00000100-10011110-10101101-10110111
// CHECK: not     z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x9e,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011110-10101101-10110111
not     z31.s, p7/m, z31.s  // 00000100-10011110-10111111-11111111
// CHECK: not     z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x9e,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011110-10111111-11111111
NOT     Z31.S, P7/M, Z31.S  // 00000100-10011110-10111111-11111111
// CHECK: not     z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x9e,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011110-10111111-11111111
not     z0.s, p0/m, z0.s  // 00000100-10011110-10100000-00000000
// CHECK: not     z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x9e,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011110-10100000-00000000
NOT     Z0.S, P0/M, Z0.S  // 00000100-10011110-10100000-00000000
// CHECK: not     z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x9e,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011110-10100000-00000000
not     z21.s, p5/m, z10.s  // 00000100-10011110-10110101-01010101
// CHECK: not     z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x9e,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011110-10110101-01010101
NOT     Z21.S, P5/M, Z10.S  // 00000100-10011110-10110101-01010101
// CHECK: not     z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x9e,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011110-10110101-01010101
