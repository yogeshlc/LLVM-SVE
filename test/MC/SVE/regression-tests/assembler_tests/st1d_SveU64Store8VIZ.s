// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1d    {z31.d}, p7, [z31.d, #248]  // 11100101-11011111-10111111-11111111
// CHECK: st1d    {z31.d}, p7, [z31.d, #248] // encoding: [0xff,0xbf,0xdf,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11011111-10111111-11111111
ST1D    {Z31.D}, P7, [Z31.D, #248]  // 11100101-11011111-10111111-11111111
// CHECK: st1d    {z31.d}, p7, [z31.d, #248] // encoding: [0xff,0xbf,0xdf,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11011111-10111111-11111111
st1d    {z21.d}, p5, [z10.d, #168]  // 11100101-11010101-10110101-01010101
// CHECK: st1d    {z21.d}, p5, [z10.d, #168] // encoding: [0x55,0xb5,0xd5,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11010101-10110101-01010101
ST1D    {Z21.D}, P5, [Z10.D, #168]  // 11100101-11010101-10110101-01010101
// CHECK: st1d    {z21.d}, p5, [z10.d, #168] // encoding: [0x55,0xb5,0xd5,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11010101-10110101-01010101
st1d    {z23.d}, p3, [z13.d, #64]  // 11100101-11001000-10101101-10110111
// CHECK: st1d    {z23.d}, p3, [z13.d, #64] // encoding: [0xb7,0xad,0xc8,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11001000-10101101-10110111
ST1D    {Z23.D}, P3, [Z13.D, #64]  // 11100101-11001000-10101101-10110111
// CHECK: st1d    {z23.d}, p3, [z13.d, #64] // encoding: [0xb7,0xad,0xc8,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11001000-10101101-10110111
st1d    {z0.d}, p0, [z0.d]  // 11100101-11000000-10100000-00000000
// CHECK: st1d    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0xc0,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11000000-10100000-00000000
ST1D    {Z0.D}, P0, [Z0.D]  // 11100101-11000000-10100000-00000000
// CHECK: st1d    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0xc0,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-11000000-10100000-00000000
