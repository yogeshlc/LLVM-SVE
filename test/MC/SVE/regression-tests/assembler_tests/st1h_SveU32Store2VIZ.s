// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1h    {z31.s}, p7, [z31.s, #62]  // 11100100-11111111-10111111-11111111
// CHECK: st1h    {z31.s}, p7, [z31.s, #62] // encoding: [0xff,0xbf,0xff,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11111111-10111111-11111111
ST1H    {Z31.S}, P7, [Z31.S, #62]  // 11100100-11111111-10111111-11111111
// CHECK: st1h    {z31.s}, p7, [z31.s, #62] // encoding: [0xff,0xbf,0xff,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11111111-10111111-11111111
st1h    {z21.s}, p5, [z10.s, #42]  // 11100100-11110101-10110101-01010101
// CHECK: st1h    {z21.s}, p5, [z10.s, #42] // encoding: [0x55,0xb5,0xf5,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11110101-10110101-01010101
ST1H    {Z21.S}, P5, [Z10.S, #42]  // 11100100-11110101-10110101-01010101
// CHECK: st1h    {z21.s}, p5, [z10.s, #42] // encoding: [0x55,0xb5,0xf5,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11110101-10110101-01010101
st1h    {z23.s}, p3, [z13.s, #16]  // 11100100-11101000-10101101-10110111
// CHECK: st1h    {z23.s}, p3, [z13.s, #16] // encoding: [0xb7,0xad,0xe8,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11101000-10101101-10110111
ST1H    {Z23.S}, P3, [Z13.S, #16]  // 11100100-11101000-10101101-10110111
// CHECK: st1h    {z23.s}, p3, [z13.s, #16] // encoding: [0xb7,0xad,0xe8,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11101000-10101101-10110111
st1h    {z0.s}, p0, [z0.s]  // 11100100-11100000-10100000-00000000
// CHECK: st1h    {z0.s}, p0, [z0.s] // encoding: [0x00,0xa0,0xe0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11100000-10100000-00000000
ST1H    {Z0.S}, P0, [Z0.S]  // 11100100-11100000-10100000-00000000
// CHECK: st1h    {z0.s}, p0, [z0.s] // encoding: [0x00,0xa0,0xe0,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-11100000-10100000-00000000
