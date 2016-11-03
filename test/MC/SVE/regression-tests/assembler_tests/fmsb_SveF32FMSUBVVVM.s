// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmsb    z31.s, p7/m, z31.s, z31.s  // 01100101-10111111-10111111-11111111
// CHECK: fmsb    z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0xbf,0xbf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10111111-10111111-11111111
FMSB    Z31.S, P7/M, Z31.S, Z31.S  // 01100101-10111111-10111111-11111111
// CHECK: fmsb    z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0xbf,0xbf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10111111-10111111-11111111
fmsb    z0.s, p0/m, z0.s, z0.s  // 01100101-10100000-10100000-00000000
// CHECK: fmsb    z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0xa0,0xa0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10100000-10100000-00000000
FMSB    Z0.S, P0/M, Z0.S, Z0.S  // 01100101-10100000-10100000-00000000
// CHECK: fmsb    z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0xa0,0xa0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10100000-10100000-00000000
fmsb    z23.s, p3/m, z13.s, z8.s  // 01100101-10101000-10101101-10110111
// CHECK: fmsb    z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0xad,0xa8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10101000-10101101-10110111
FMSB    Z23.S, P3/M, Z13.S, Z8.S  // 01100101-10101000-10101101-10110111
// CHECK: fmsb    z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0xad,0xa8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10101000-10101101-10110111
fmsb    z21.s, p5/m, z10.s, z21.s  // 01100101-10110101-10110101-01010101
// CHECK: fmsb    z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0xb5,0xb5,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10110101-10110101-01010101
FMSB    Z21.S, P5/M, Z10.S, Z21.S  // 01100101-10110101-10110101-01010101
// CHECK: fmsb    z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0xb5,0xb5,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10110101-10110101-01010101
