// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1h    {z23.d}, p3, [z13.d, #16]  // 11100100-11001000-10101101-10110111
// CHECK: st1h    {z23.d}, p3, [z13.d, #16] // encoding: [0xb7,0xad,0xc8,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11001000-10101101-10110111
ST1H    {Z23.D}, P3, [Z13.D, #16]  // 11100100-11001000-10101101-10110111
// CHECK: st1h    {z23.d}, p3, [z13.d, #16] // encoding: [0xb7,0xad,0xc8,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11001000-10101101-10110111
st1h    {z31.d}, p7, [z31.d, #62]  // 11100100-11011111-10111111-11111111
// CHECK: st1h    {z31.d}, p7, [z31.d, #62] // encoding: [0xff,0xbf,0xdf,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11011111-10111111-11111111
ST1H    {Z31.D}, P7, [Z31.D, #62]  // 11100100-11011111-10111111-11111111
// CHECK: st1h    {z31.d}, p7, [z31.d, #62] // encoding: [0xff,0xbf,0xdf,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11011111-10111111-11111111
st1h    {z0.d}, p0, [z0.d]  // 11100100-11000000-10100000-00000000
// CHECK: st1h    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0xc0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11000000-10100000-00000000
ST1H    {Z0.D}, P0, [Z0.D]  // 11100100-11000000-10100000-00000000
// CHECK: st1h    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0xc0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11000000-10100000-00000000
st1h    {z21.d}, p5, [z10.d, #42]  // 11100100-11010101-10110101-01010101
// CHECK: st1h    {z21.d}, p5, [z10.d, #42] // encoding: [0x55,0xb5,0xd5,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11010101-10110101-01010101
ST1H    {Z21.D}, P5, [Z10.D, #42]  // 11100100-11010101-10110101-01010101
// CHECK: st1h    {z21.d}, p5, [z10.d, #42] // encoding: [0x55,0xb5,0xd5,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11010101-10110101-01010101
