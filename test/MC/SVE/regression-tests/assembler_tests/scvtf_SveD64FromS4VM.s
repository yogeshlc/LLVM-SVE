// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
scvtf   z31.d, p7/m, z31.s  // 01100101-11010000-10111111-11111111
// CHECK: scvtf   z31.d, p7/m, z31.s // encoding: [0xff,0xbf,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-10111111-11111111
SCVTF   Z31.D, P7/M, Z31.S  // 01100101-11010000-10111111-11111111
// CHECK: scvtf   z31.d, p7/m, z31.s // encoding: [0xff,0xbf,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-10111111-11111111
scvtf   z21.d, p5/m, z10.s  // 01100101-11010000-10110101-01010101
// CHECK: scvtf   z21.d, p5/m, z10.s // encoding: [0x55,0xb5,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-10110101-01010101
SCVTF   Z21.D, P5/M, Z10.S  // 01100101-11010000-10110101-01010101
// CHECK: scvtf   z21.d, p5/m, z10.s // encoding: [0x55,0xb5,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-10110101-01010101
scvtf   z0.d, p0/m, z0.s  // 01100101-11010000-10100000-00000000
// CHECK: scvtf   z0.d, p0/m, z0.s // encoding: [0x00,0xa0,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-10100000-00000000
SCVTF   Z0.D, P0/M, Z0.S  // 01100101-11010000-10100000-00000000
// CHECK: scvtf   z0.d, p0/m, z0.s // encoding: [0x00,0xa0,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-10100000-00000000
scvtf   z23.d, p3/m, z13.s  // 01100101-11010000-10101101-10110111
// CHECK: scvtf   z23.d, p3/m, z13.s // encoding: [0xb7,0xad,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-10101101-10110111
SCVTF   Z23.D, P3/M, Z13.S  // 01100101-11010000-10101101-10110111
// CHECK: scvtf   z23.d, p3/m, z13.s // encoding: [0xb7,0xad,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-10101101-10110111
