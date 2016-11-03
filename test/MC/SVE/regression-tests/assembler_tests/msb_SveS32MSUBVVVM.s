// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
msb     z0.s, p0/m, z0.s, z0.s  // 00000100-10000000-11100000-00000000
// CHECK: msb     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0xe0,0x80,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000000-11100000-00000000
MSB     Z0.S, P0/M, Z0.S, Z0.S  // 00000100-10000000-11100000-00000000
// CHECK: msb     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0xe0,0x80,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000000-11100000-00000000
msb     z31.s, p7/m, z31.s, z31.s  // 00000100-10011111-11111111-11111111
// CHECK: msb     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0xff,0x9f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011111-11111111-11111111
MSB     Z31.S, P7/M, Z31.S, Z31.S  // 00000100-10011111-11111111-11111111
// CHECK: msb     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0xff,0x9f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011111-11111111-11111111
msb     z21.s, p5/m, z21.s, z10.s  // 00000100-10010101-11110101-01010101
// CHECK: msb     z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0xf5,0x95,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010101-11110101-01010101
MSB     Z21.S, P5/M, Z21.S, Z10.S  // 00000100-10010101-11110101-01010101
// CHECK: msb     z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0xf5,0x95,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010101-11110101-01010101
msb     z23.s, p3/m, z8.s, z13.s  // 00000100-10001000-11101101-10110111
// CHECK: msb     z23.s, p3/m, z8.s, z13.s // encoding: [0xb7,0xed,0x88,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10001000-11101101-10110111
MSB     Z23.S, P3/M, Z8.S, Z13.S  // 00000100-10001000-11101101-10110111
// CHECK: msb     z23.s, p3/m, z8.s, z13.s // encoding: [0xb7,0xed,0x88,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10001000-11101101-10110111
