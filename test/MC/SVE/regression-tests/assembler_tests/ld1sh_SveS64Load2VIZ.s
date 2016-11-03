// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1sh   {z23.d}, p3/z, [z13.d, #16]  // 11000100-10101000-10001101-10110111
// CHECK: ld1sh   {z23.d}, p3/z, [z13.d, #16] // encoding: [0xb7,0x8d,0xa8,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-10101000-10001101-10110111
LD1SH   {Z23.D}, P3/Z, [Z13.D, #16]  // 11000100-10101000-10001101-10110111
// CHECK: ld1sh   {z23.d}, p3/z, [z13.d, #16] // encoding: [0xb7,0x8d,0xa8,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-10101000-10001101-10110111
ld1sh   {z21.d}, p5/z, [z10.d, #42]  // 11000100-10110101-10010101-01010101
// CHECK: ld1sh   {z21.d}, p5/z, [z10.d, #42] // encoding: [0x55,0x95,0xb5,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-10110101-10010101-01010101
LD1SH   {Z21.D}, P5/Z, [Z10.D, #42]  // 11000100-10110101-10010101-01010101
// CHECK: ld1sh   {z21.d}, p5/z, [z10.d, #42] // encoding: [0x55,0x95,0xb5,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-10110101-10010101-01010101
ld1sh   {z31.d}, p7/z, [z31.d, #62]  // 11000100-10111111-10011111-11111111
// CHECK: ld1sh   {z31.d}, p7/z, [z31.d, #62] // encoding: [0xff,0x9f,0xbf,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-10111111-10011111-11111111
LD1SH   {Z31.D}, P7/Z, [Z31.D, #62]  // 11000100-10111111-10011111-11111111
// CHECK: ld1sh   {z31.d}, p7/z, [z31.d, #62] // encoding: [0xff,0x9f,0xbf,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-10111111-10011111-11111111
ld1sh   {z0.d}, p0/z, [z0.d]  // 11000100-10100000-10000000-00000000
// CHECK: ld1sh   {z0.d}, p0/z, [z0.d] // encoding: [0x00,0x80,0xa0,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-10100000-10000000-00000000
LD1SH   {Z0.D}, P0/Z, [Z0.D]  // 11000100-10100000-10000000-00000000
// CHECK: ld1sh   {z0.d}, p0/z, [z0.d] // encoding: [0x00,0x80,0xa0,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-10100000-10000000-00000000
