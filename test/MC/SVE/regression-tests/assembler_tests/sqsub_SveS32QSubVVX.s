// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqsub   z23.s, z13.s, z8.s  // 00000100-10101000-00011001-10110111
// CHECK: sqsub   z23.s, z13.s, z8.s // encoding: [0xb7,0x19,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-00011001-10110111
SQSUB   Z23.S, Z13.S, Z8.S  // 00000100-10101000-00011001-10110111
// CHECK: sqsub   z23.s, z13.s, z8.s // encoding: [0xb7,0x19,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-00011001-10110111
sqsub   z31.s, z31.s, z31.s  // 00000100-10111111-00011011-11111111
// CHECK: sqsub   z31.s, z31.s, z31.s // encoding: [0xff,0x1b,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-00011011-11111111
SQSUB   Z31.S, Z31.S, Z31.S  // 00000100-10111111-00011011-11111111
// CHECK: sqsub   z31.s, z31.s, z31.s // encoding: [0xff,0x1b,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-00011011-11111111
sqsub   z21.s, z10.s, z21.s  // 00000100-10110101-00011001-01010101
// CHECK: sqsub   z21.s, z10.s, z21.s // encoding: [0x55,0x19,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-00011001-01010101
SQSUB   Z21.S, Z10.S, Z21.S  // 00000100-10110101-00011001-01010101
// CHECK: sqsub   z21.s, z10.s, z21.s // encoding: [0x55,0x19,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-00011001-01010101
sqsub   z0.s, z0.s, z0.s  // 00000100-10100000-00011000-00000000
// CHECK: sqsub   z0.s, z0.s, z0.s // encoding: [0x00,0x18,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-00011000-00000000
SQSUB   Z0.S, Z0.S, Z0.S  // 00000100-10100000-00011000-00000000
// CHECK: sqsub   z0.s, z0.s, z0.s // encoding: [0x00,0x18,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-00011000-00000000
