// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1b    {z31.d}, p7, [z31.d, #31]  // 11100100-01011111-10111111-11111111
// CHECK: st1b    {z31.d}, p7, [z31.d, #31] // encoding: [0xff,0xbf,0x5f,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01011111-10111111-11111111
ST1B    {Z31.D}, P7, [Z31.D, #31]  // 11100100-01011111-10111111-11111111
// CHECK: st1b    {z31.d}, p7, [z31.d, #31] // encoding: [0xff,0xbf,0x5f,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01011111-10111111-11111111
st1b    {z23.d}, p3, [z13.d, #8]  // 11100100-01001000-10101101-10110111
// CHECK: st1b    {z23.d}, p3, [z13.d, #8] // encoding: [0xb7,0xad,0x48,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01001000-10101101-10110111
ST1B    {Z23.D}, P3, [Z13.D, #8]  // 11100100-01001000-10101101-10110111
// CHECK: st1b    {z23.d}, p3, [z13.d, #8] // encoding: [0xb7,0xad,0x48,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01001000-10101101-10110111
st1b    {z0.d}, p0, [z0.d]  // 11100100-01000000-10100000-00000000
// CHECK: st1b    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0x40,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01000000-10100000-00000000
ST1B    {Z0.D}, P0, [Z0.D]  // 11100100-01000000-10100000-00000000
// CHECK: st1b    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0x40,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01000000-10100000-00000000
st1b    {z21.d}, p5, [z10.d, #21]  // 11100100-01010101-10110101-01010101
// CHECK: st1b    {z21.d}, p5, [z10.d, #21] // encoding: [0x55,0xb5,0x55,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01010101-10110101-01010101
ST1B    {Z21.D}, P5, [Z10.D, #21]  // 11100100-01010101-10110101-01010101
// CHECK: st1b    {z21.d}, p5, [z10.d, #21] // encoding: [0x55,0xb5,0x55,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01010101-10110101-01010101
