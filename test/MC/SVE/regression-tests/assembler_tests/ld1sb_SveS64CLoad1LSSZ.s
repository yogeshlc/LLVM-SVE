// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1sb   {z23.d}, p3/z, [x13, x8]  // 10100101-10001000-01001101-10110111
// CHECK: ld1sb   {z23.d}, p3/z, [x13, x8] // encoding: [0xb7,0x4d,0x88,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10001000-01001101-10110111
LD1SB   {Z23.D}, P3/Z, [X13, X8]  // 10100101-10001000-01001101-10110111
// CHECK: ld1sb   {z23.d}, p3/z, [x13, x8] // encoding: [0xb7,0x4d,0x88,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10001000-01001101-10110111
ld1sb   {z5.d}, p3/z, [x17, x16]  // 10100101-10010000-01001110-00100101
// CHECK: ld1sb   {z5.d}, p3/z, [x17, x16] // encoding: [0x25,0x4e,0x90,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10010000-01001110-00100101
LD1SB   {Z5.D}, P3/Z, [X17, X16]  // 10100101-10010000-01001110-00100101
// CHECK: ld1sb   {z5.d}, p3/z, [x17, x16] // encoding: [0x25,0x4e,0x90,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10010000-01001110-00100101
ld1sb   {z21.d}, p5/z, [x10, x21]  // 10100101-10010101-01010101-01010101
// CHECK: ld1sb   {z21.d}, p5/z, [x10, x21] // encoding: [0x55,0x55,0x95,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10010101-01010101-01010101
LD1SB   {Z21.D}, P5/Z, [X10, X21]  // 10100101-10010101-01010101-01010101
// CHECK: ld1sb   {z21.d}, p5/z, [x10, x21] // encoding: [0x55,0x55,0x95,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10010101-01010101-01010101
ld1sb   {z0.d}, p0/z, [x0, x0]  // 10100101-10000000-01000000-00000000
// CHECK: ld1sb   {z0.d}, p0/z, [x0, x0] // encoding: [0x00,0x40,0x80,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10000000-01000000-00000000
LD1SB   {Z0.D}, P0/Z, [X0, X0]  // 10100101-10000000-01000000-00000000
// CHECK: ld1sb   {z0.d}, p0/z, [x0, x0] // encoding: [0x00,0x40,0x80,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-10000000-01000000-00000000
