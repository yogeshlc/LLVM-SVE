// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
frintm  z21.s, p5/m, z10.s  // 01100101-10000010-10110101-01010101
// CHECK: frintm  z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x82,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000010-10110101-01010101
FRINTM  Z21.S, P5/M, Z10.S  // 01100101-10000010-10110101-01010101
// CHECK: frintm  z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x82,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000010-10110101-01010101
frintm  z0.s, p0/m, z0.s  // 01100101-10000010-10100000-00000000
// CHECK: frintm  z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x82,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000010-10100000-00000000
FRINTM  Z0.S, P0/M, Z0.S  // 01100101-10000010-10100000-00000000
// CHECK: frintm  z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x82,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000010-10100000-00000000
frintm  z23.s, p3/m, z13.s  // 01100101-10000010-10101101-10110111
// CHECK: frintm  z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x82,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000010-10101101-10110111
FRINTM  Z23.S, P3/M, Z13.S  // 01100101-10000010-10101101-10110111
// CHECK: frintm  z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x82,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000010-10101101-10110111
frintm  z31.s, p7/m, z31.s  // 01100101-10000010-10111111-11111111
// CHECK: frintm  z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x82,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000010-10111111-11111111
FRINTM  Z31.S, P7/M, Z31.S  // 01100101-10000010-10111111-11111111
// CHECK: frintm  z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x82,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10000010-10111111-11111111
