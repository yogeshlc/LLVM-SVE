// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
revb    z23.h, p3/m, z13.h  // 00000101-01100100-10001101-10110111
// CHECK: revb    z23.h, p3/m, z13.h // encoding: [0xb7,0x8d,0x64,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100100-10001101-10110111
REVB    Z23.H, P3/M, Z13.H  // 00000101-01100100-10001101-10110111
// CHECK: revb    z23.h, p3/m, z13.h // encoding: [0xb7,0x8d,0x64,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100100-10001101-10110111
revb    z31.h, p7/m, z31.h  // 00000101-01100100-10011111-11111111
// CHECK: revb    z31.h, p7/m, z31.h // encoding: [0xff,0x9f,0x64,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100100-10011111-11111111
REVB    Z31.H, P7/M, Z31.H  // 00000101-01100100-10011111-11111111
// CHECK: revb    z31.h, p7/m, z31.h // encoding: [0xff,0x9f,0x64,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100100-10011111-11111111
revb    z0.h, p0/m, z0.h  // 00000101-01100100-10000000-00000000
// CHECK: revb    z0.h, p0/m, z0.h // encoding: [0x00,0x80,0x64,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100100-10000000-00000000
REVB    Z0.H, P0/M, Z0.H  // 00000101-01100100-10000000-00000000
// CHECK: revb    z0.h, p0/m, z0.h // encoding: [0x00,0x80,0x64,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100100-10000000-00000000
revb    z21.h, p5/m, z10.h  // 00000101-01100100-10010101-01010101
// CHECK: revb    z21.h, p5/m, z10.h // encoding: [0x55,0x95,0x64,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100100-10010101-01010101
REVB    Z21.H, P5/M, Z10.H  // 00000101-01100100-10010101-01010101
// CHECK: revb    z21.h, p5/m, z10.h // encoding: [0x55,0x95,0x64,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100100-10010101-01010101
