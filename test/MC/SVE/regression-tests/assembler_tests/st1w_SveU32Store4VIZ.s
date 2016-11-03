// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1w    {z21.s}, p5, [z10.s, #84]  // 11100101-01110101-10110101-01010101
// CHECK: st1w    {z21.s}, p5, [z10.s, #84] // encoding: [0x55,0xb5,0x75,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01110101-10110101-01010101
ST1W    {Z21.S}, P5, [Z10.S, #84]  // 11100101-01110101-10110101-01010101
// CHECK: st1w    {z21.s}, p5, [z10.s, #84] // encoding: [0x55,0xb5,0x75,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01110101-10110101-01010101
st1w    {z23.s}, p3, [z13.s, #32]  // 11100101-01101000-10101101-10110111
// CHECK: st1w    {z23.s}, p3, [z13.s, #32] // encoding: [0xb7,0xad,0x68,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01101000-10101101-10110111
ST1W    {Z23.S}, P3, [Z13.S, #32]  // 11100101-01101000-10101101-10110111
// CHECK: st1w    {z23.s}, p3, [z13.s, #32] // encoding: [0xb7,0xad,0x68,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01101000-10101101-10110111
st1w    {z0.s}, p0, [z0.s]  // 11100101-01100000-10100000-00000000
// CHECK: st1w    {z0.s}, p0, [z0.s] // encoding: [0x00,0xa0,0x60,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01100000-10100000-00000000
ST1W    {Z0.S}, P0, [Z0.S]  // 11100101-01100000-10100000-00000000
// CHECK: st1w    {z0.s}, p0, [z0.s] // encoding: [0x00,0xa0,0x60,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01100000-10100000-00000000
st1w    {z31.s}, p7, [z31.s, #124]  // 11100101-01111111-10111111-11111111
// CHECK: st1w    {z31.s}, p7, [z31.s, #124] // encoding: [0xff,0xbf,0x7f,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01111111-10111111-11111111
ST1W    {Z31.S}, P7, [Z31.S, #124]  // 11100101-01111111-10111111-11111111
// CHECK: st1w    {z31.s}, p7, [z31.s, #124] // encoding: [0xff,0xbf,0x7f,0xe5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100101-01111111-10111111-11111111
