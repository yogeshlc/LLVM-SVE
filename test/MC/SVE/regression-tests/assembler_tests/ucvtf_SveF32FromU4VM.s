// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ucvtf   z21.s, p5/m, z10.s  // 01100101-10010101-10110101-01010101
// CHECK: ucvtf   z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-10110101-01010101
UCVTF   Z21.S, P5/M, Z10.S  // 01100101-10010101-10110101-01010101
// CHECK: ucvtf   z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-10110101-01010101
ucvtf   z31.s, p7/m, z31.s  // 01100101-10010101-10111111-11111111
// CHECK: ucvtf   z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-10111111-11111111
UCVTF   Z31.S, P7/M, Z31.S  // 01100101-10010101-10111111-11111111
// CHECK: ucvtf   z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-10111111-11111111
ucvtf   z0.s, p0/m, z0.s  // 01100101-10010101-10100000-00000000
// CHECK: ucvtf   z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-10100000-00000000
UCVTF   Z0.S, P0/M, Z0.S  // 01100101-10010101-10100000-00000000
// CHECK: ucvtf   z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-10100000-00000000
ucvtf   z23.s, p3/m, z13.s  // 01100101-10010101-10101101-10110111
// CHECK: ucvtf   z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-10101101-10110111
UCVTF   Z23.S, P3/M, Z13.S  // 01100101-10010101-10101101-10110111
// CHECK: ucvtf   z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-10101101-10110111
