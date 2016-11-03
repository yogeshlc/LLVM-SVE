// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1d    {z21.d}, p5/z, [z10.d, #168]  // 11000101-10110101-11010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [z10.d, #168] // encoding: [0x55,0xd5,0xb5,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10110101-11010101-01010101
LD1D    {Z21.D}, P5/Z, [Z10.D, #168]  // 11000101-10110101-11010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [z10.d, #168] // encoding: [0x55,0xd5,0xb5,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10110101-11010101-01010101
ld1d    {z0.d}, p0/z, [z0.d]  // 11000101-10100000-11000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xc0,0xa0,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10100000-11000000-00000000
LD1D    {Z0.D}, P0/Z, [Z0.D]  // 11000101-10100000-11000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xc0,0xa0,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10100000-11000000-00000000
ld1d    {z31.d}, p7/z, [z31.d, #248]  // 11000101-10111111-11011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [z31.d, #248] // encoding: [0xff,0xdf,0xbf,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10111111-11011111-11111111
LD1D    {Z31.D}, P7/Z, [Z31.D, #248]  // 11000101-10111111-11011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [z31.d, #248] // encoding: [0xff,0xdf,0xbf,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10111111-11011111-11111111
ld1d    {z23.d}, p3/z, [z13.d, #64]  // 11000101-10101000-11001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [z13.d, #64] // encoding: [0xb7,0xcd,0xa8,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10101000-11001101-10110111
LD1D    {Z23.D}, P3/Z, [Z13.D, #64]  // 11000101-10101000-11001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [z13.d, #64] // encoding: [0xb7,0xcd,0xa8,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10101000-11001101-10110111
