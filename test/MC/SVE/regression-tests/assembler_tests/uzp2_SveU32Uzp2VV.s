// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uzp2    z0.s, z0.s, z0.s  // 00000101-10100000-01101100-00000000
// CHECK: uzp2    z0.s, z0.s, z0.s // encoding: [0x00,0x6c,0xa0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100000-01101100-00000000
UZP2    Z0.S, Z0.S, Z0.S  // 00000101-10100000-01101100-00000000
// CHECK: uzp2    z0.s, z0.s, z0.s // encoding: [0x00,0x6c,0xa0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100000-01101100-00000000
uzp2    z23.s, z13.s, z8.s  // 00000101-10101000-01101101-10110111
// CHECK: uzp2    z23.s, z13.s, z8.s // encoding: [0xb7,0x6d,0xa8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101000-01101101-10110111
UZP2    Z23.S, Z13.S, Z8.S  // 00000101-10101000-01101101-10110111
// CHECK: uzp2    z23.s, z13.s, z8.s // encoding: [0xb7,0x6d,0xa8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101000-01101101-10110111
uzp2    z21.s, z10.s, z21.s  // 00000101-10110101-01101101-01010101
// CHECK: uzp2    z21.s, z10.s, z21.s // encoding: [0x55,0x6d,0xb5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110101-01101101-01010101
UZP2    Z21.S, Z10.S, Z21.S  // 00000101-10110101-01101101-01010101
// CHECK: uzp2    z21.s, z10.s, z21.s // encoding: [0x55,0x6d,0xb5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110101-01101101-01010101
uzp2    z31.s, z31.s, z31.s  // 00000101-10111111-01101111-11111111
// CHECK: uzp2    z31.s, z31.s, z31.s // encoding: [0xff,0x6f,0xbf,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10111111-01101111-11111111
UZP2    Z31.S, Z31.S, Z31.S  // 00000101-10111111-01101111-11111111
// CHECK: uzp2    z31.s, z31.s, z31.s // encoding: [0xff,0x6f,0xbf,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10111111-01101111-11111111
