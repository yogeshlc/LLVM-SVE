// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lasta   b23, p3, z13.b  // 00000101-00100010-10001101-10110111
// CHECK: lasta   b23, p3, z13.b // encoding: [0xb7,0x8d,0x22,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100010-10001101-10110111
LASTA   B23, P3, Z13.B  // 00000101-00100010-10001101-10110111
// CHECK: lasta   b23, p3, z13.b // encoding: [0xb7,0x8d,0x22,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100010-10001101-10110111
lasta   b0, p0, z0.b  // 00000101-00100010-10000000-00000000
// CHECK: lasta   b0, p0, z0.b // encoding: [0x00,0x80,0x22,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100010-10000000-00000000
LASTA   B0, P0, Z0.B  // 00000101-00100010-10000000-00000000
// CHECK: lasta   b0, p0, z0.b // encoding: [0x00,0x80,0x22,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100010-10000000-00000000
lasta   b21, p5, z10.b  // 00000101-00100010-10010101-01010101
// CHECK: lasta   b21, p5, z10.b // encoding: [0x55,0x95,0x22,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100010-10010101-01010101
LASTA   B21, P5, Z10.B  // 00000101-00100010-10010101-01010101
// CHECK: lasta   b21, p5, z10.b // encoding: [0x55,0x95,0x22,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100010-10010101-01010101
lasta   b31, p7, z31.b  // 00000101-00100010-10011111-11111111
// CHECK: lasta   b31, p7, z31.b // encoding: [0xff,0x9f,0x22,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100010-10011111-11111111
LASTA   B31, P7, Z31.B  // 00000101-00100010-10011111-11111111
// CHECK: lasta   b31, p7, z31.b // encoding: [0xff,0x9f,0x22,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100010-10011111-11111111
