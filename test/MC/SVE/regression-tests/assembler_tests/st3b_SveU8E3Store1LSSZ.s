// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st3b    {z0.b, z1.b, z2.b}, p0, [x0, x0]  // 11100100-01000000-01100000-00000000
// CHECK: st3b    {z0.b, z1.b, z2.b}, p0, [x0, x0] // encoding: [0x00,0x60,0x40,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01000000-01100000-00000000
ST3B    {Z0.B, Z1.B, Z2.B}, P0, [X0, X0]  // 11100100-01000000-01100000-00000000
// CHECK: st3b    {z0.b, z1.b, z2.b}, p0, [x0, x0] // encoding: [0x00,0x60,0x40,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01000000-01100000-00000000
st3b    {z5.b, z6.b, z7.b}, p3, [x17, x16]  // 11100100-01010000-01101110-00100101
// CHECK: st3b    {z5.b, z6.b, z7.b}, p3, [x17, x16] // encoding: [0x25,0x6e,0x50,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01010000-01101110-00100101
ST3B    {Z5.B, Z6.B, Z7.B}, P3, [X17, X16]  // 11100100-01010000-01101110-00100101
// CHECK: st3b    {z5.b, z6.b, z7.b}, p3, [x17, x16] // encoding: [0x25,0x6e,0x50,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01010000-01101110-00100101
st3b    {z23.b, z24.b, z25.b}, p3, [x13, x8]  // 11100100-01001000-01101101-10110111
// CHECK: st3b    {z23.b, z24.b, z25.b}, p3, [x13, x8] // encoding: [0xb7,0x6d,0x48,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01001000-01101101-10110111
ST3B    {Z23.B, Z24.B, Z25.B}, P3, [X13, X8]  // 11100100-01001000-01101101-10110111
// CHECK: st3b    {z23.b, z24.b, z25.b}, p3, [x13, x8] // encoding: [0xb7,0x6d,0x48,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01001000-01101101-10110111
st3b    {z21.b, z22.b, z23.b}, p5, [x10, x21]  // 11100100-01010101-01110101-01010101
// CHECK: st3b    {z21.b, z22.b, z23.b}, p5, [x10, x21] // encoding: [0x55,0x75,0x55,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01010101-01110101-01010101
ST3B    {Z21.B, Z22.B, Z23.B}, P5, [X10, X21]  // 11100100-01010101-01110101-01010101
// CHECK: st3b    {z21.b, z22.b, z23.b}, p5, [x10, x21] // encoding: [0x55,0x75,0x55,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01010101-01110101-01010101
