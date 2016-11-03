// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1sh   {z0.d}, p0/z, [x0, z0.d, lsl #1]  // 11000100-11100000-10000000-00000000
// CHECK: ld1sh   {z0.d}, p0/z, [x0, z0.d, lsl #1] // encoding: [0x00,0x80,0xe0,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11100000-10000000-00000000
LD1SH   {Z0.D}, P0/Z, [X0, Z0.D, LSL #1]  // 11000100-11100000-10000000-00000000
// CHECK: ld1sh   {z0.d}, p0/z, [x0, z0.d, lsl #1] // encoding: [0x00,0x80,0xe0,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11100000-10000000-00000000
ld1sh   {z23.d}, p3/z, [x13, z8.d, lsl #1]  // 11000100-11101000-10001101-10110111
// CHECK: ld1sh   {z23.d}, p3/z, [x13, z8.d, lsl #1] // encoding: [0xb7,0x8d,0xe8,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11101000-10001101-10110111
LD1SH   {Z23.D}, P3/Z, [X13, Z8.D, LSL #1]  // 11000100-11101000-10001101-10110111
// CHECK: ld1sh   {z23.d}, p3/z, [x13, z8.d, lsl #1] // encoding: [0xb7,0x8d,0xe8,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11101000-10001101-10110111
ld1sh   {z21.d}, p5/z, [x10, z21.d, lsl #1]  // 11000100-11110101-10010101-01010101
// CHECK: ld1sh   {z21.d}, p5/z, [x10, z21.d, lsl #1] // encoding: [0x55,0x95,0xf5,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11110101-10010101-01010101
LD1SH   {Z21.D}, P5/Z, [X10, Z21.D, LSL #1]  // 11000100-11110101-10010101-01010101
// CHECK: ld1sh   {z21.d}, p5/z, [x10, z21.d, lsl #1] // encoding: [0x55,0x95,0xf5,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11110101-10010101-01010101
ld1sh   {z31.d}, p7/z, [sp, z31.d, lsl #1]  // 11000100-11111111-10011111-11111111
// CHECK: ld1sh   {z31.d}, p7/z, [sp, z31.d, lsl #1] // encoding: [0xff,0x9f,0xff,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11111111-10011111-11111111
LD1SH   {Z31.D}, P7/Z, [SP, Z31.D, LSL #1]  // 11000100-11111111-10011111-11111111
// CHECK: ld1sh   {z31.d}, p7/z, [sp, z31.d, lsl #1] // encoding: [0xff,0x9f,0xff,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-11111111-10011111-11111111
