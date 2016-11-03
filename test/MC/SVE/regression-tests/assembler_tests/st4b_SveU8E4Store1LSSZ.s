// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st4b    {z23.b, z24.b, z25.b, z26.b}, p3, [x13, x8]  // 11100100-01101000-01101101-10110111
// CHECK: st4b    {z23.b, z24.b, z25.b, z26.b}, p3, [x13, x8] // encoding: [0xb7,0x6d,0x68,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01101000-01101101-10110111
ST4B    {Z23.B, Z24.B, Z25.B, Z26.B}, P3, [X13, X8]  // 11100100-01101000-01101101-10110111
// CHECK: st4b    {z23.b, z24.b, z25.b, z26.b}, p3, [x13, x8] // encoding: [0xb7,0x6d,0x68,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01101000-01101101-10110111
st4b    {z0.b, z1.b, z2.b, z3.b}, p0, [x0, x0]  // 11100100-01100000-01100000-00000000
// CHECK: st4b    {z0.b, z1.b, z2.b, z3.b}, p0, [x0, x0] // encoding: [0x00,0x60,0x60,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01100000-01100000-00000000
ST4B    {Z0.B, Z1.B, Z2.B, Z3.B}, P0, [X0, X0]  // 11100100-01100000-01100000-00000000
// CHECK: st4b    {z0.b, z1.b, z2.b, z3.b}, p0, [x0, x0] // encoding: [0x00,0x60,0x60,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01100000-01100000-00000000
st4b    {z5.b, z6.b, z7.b, z8.b}, p3, [x17, x16]  // 11100100-01110000-01101110-00100101
// CHECK: st4b    {z5.b, z6.b, z7.b, z8.b}, p3, [x17, x16] // encoding: [0x25,0x6e,0x70,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01110000-01101110-00100101
ST4B    {Z5.B, Z6.B, Z7.B, Z8.B}, P3, [X17, X16]  // 11100100-01110000-01101110-00100101
// CHECK: st4b    {z5.b, z6.b, z7.b, z8.b}, p3, [x17, x16] // encoding: [0x25,0x6e,0x70,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01110000-01101110-00100101
st4b    {z21.b, z22.b, z23.b, z24.b}, p5, [x10, x21]  // 11100100-01110101-01110101-01010101
// CHECK: st4b    {z21.b, z22.b, z23.b, z24.b}, p5, [x10, x21] // encoding: [0x55,0x75,0x75,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01110101-01110101-01010101
ST4B    {Z21.B, Z22.B, Z23.B, Z24.B}, P5, [X10, X21]  // 11100100-01110101-01110101-01010101
// CHECK: st4b    {z21.b, z22.b, z23.b, z24.b}, p5, [x10, x21] // encoding: [0x55,0x75,0x75,0xe4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11100100-01110101-01110101-01010101
