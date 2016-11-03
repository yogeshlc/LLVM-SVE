// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqsub   z21.s, z10.s, z21.s  // 00000100-10110101-00011101-01010101
// CHECK: uqsub   z21.s, z10.s, z21.s // encoding: [0x55,0x1d,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-00011101-01010101
UQSUB   Z21.S, Z10.S, Z21.S  // 00000100-10110101-00011101-01010101
// CHECK: uqsub   z21.s, z10.s, z21.s // encoding: [0x55,0x1d,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-00011101-01010101
uqsub   z31.s, z31.s, z31.s  // 00000100-10111111-00011111-11111111
// CHECK: uqsub   z31.s, z31.s, z31.s // encoding: [0xff,0x1f,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-00011111-11111111
UQSUB   Z31.S, Z31.S, Z31.S  // 00000100-10111111-00011111-11111111
// CHECK: uqsub   z31.s, z31.s, z31.s // encoding: [0xff,0x1f,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-00011111-11111111
uqsub   z0.s, z0.s, z0.s  // 00000100-10100000-00011100-00000000
// CHECK: uqsub   z0.s, z0.s, z0.s // encoding: [0x00,0x1c,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-00011100-00000000
UQSUB   Z0.S, Z0.S, Z0.S  // 00000100-10100000-00011100-00000000
// CHECK: uqsub   z0.s, z0.s, z0.s // encoding: [0x00,0x1c,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-00011100-00000000
uqsub   z23.s, z13.s, z8.s  // 00000100-10101000-00011101-10110111
// CHECK: uqsub   z23.s, z13.s, z8.s // encoding: [0xb7,0x1d,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-00011101-10110111
UQSUB   Z23.S, Z13.S, Z8.S  // 00000100-10101000-00011101-10110111
// CHECK: uqsub   z23.s, z13.s, z8.s // encoding: [0xb7,0x1d,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-00011101-10110111
