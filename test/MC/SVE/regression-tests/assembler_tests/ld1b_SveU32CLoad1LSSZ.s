// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1b    {z5.s}, p3/z, [x17, x16]  // 10100100-01010000-01001110-00100101
// CHECK: ld1b    {z5.s}, p3/z, [x17, x16] // encoding: [0x25,0x4e,0x50,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01010000-01001110-00100101
LD1B    {Z5.S}, P3/Z, [X17, X16]  // 10100100-01010000-01001110-00100101
// CHECK: ld1b    {z5.s}, p3/z, [x17, x16] // encoding: [0x25,0x4e,0x50,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01010000-01001110-00100101
ld1b    {z0.s}, p0/z, [x0, x0]  // 10100100-01000000-01000000-00000000
// CHECK: ld1b    {z0.s}, p0/z, [x0, x0] // encoding: [0x00,0x40,0x40,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01000000-01000000-00000000
LD1B    {Z0.S}, P0/Z, [X0, X0]  // 10100100-01000000-01000000-00000000
// CHECK: ld1b    {z0.s}, p0/z, [x0, x0] // encoding: [0x00,0x40,0x40,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01000000-01000000-00000000
ld1b    {z23.s}, p3/z, [x13, x8]  // 10100100-01001000-01001101-10110111
// CHECK: ld1b    {z23.s}, p3/z, [x13, x8] // encoding: [0xb7,0x4d,0x48,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01001000-01001101-10110111
LD1B    {Z23.S}, P3/Z, [X13, X8]  // 10100100-01001000-01001101-10110111
// CHECK: ld1b    {z23.s}, p3/z, [x13, x8] // encoding: [0xb7,0x4d,0x48,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01001000-01001101-10110111
ld1b    {z21.s}, p5/z, [x10, x21]  // 10100100-01010101-01010101-01010101
// CHECK: ld1b    {z21.s}, p5/z, [x10, x21] // encoding: [0x55,0x55,0x55,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01010101-01010101-01010101
LD1B    {Z21.S}, P5/Z, [X10, X21]  // 10100100-01010101-01010101-01010101
// CHECK: ld1b    {z21.s}, p5/z, [x10, x21] // encoding: [0x55,0x55,0x55,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01010101-01010101-01010101
