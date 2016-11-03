// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqsub   z31.h, z31.h, z31.h  // 00000100-01111111-00011011-11111111
// CHECK: sqsub   z31.h, z31.h, z31.h // encoding: [0xff,0x1b,0x7f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01111111-00011011-11111111
SQSUB   Z31.H, Z31.H, Z31.H  // 00000100-01111111-00011011-11111111
// CHECK: sqsub   z31.h, z31.h, z31.h // encoding: [0xff,0x1b,0x7f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01111111-00011011-11111111
sqsub   z21.h, z10.h, z21.h  // 00000100-01110101-00011001-01010101
// CHECK: sqsub   z21.h, z10.h, z21.h // encoding: [0x55,0x19,0x75,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01110101-00011001-01010101
SQSUB   Z21.H, Z10.H, Z21.H  // 00000100-01110101-00011001-01010101
// CHECK: sqsub   z21.h, z10.h, z21.h // encoding: [0x55,0x19,0x75,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01110101-00011001-01010101
sqsub   z23.h, z13.h, z8.h  // 00000100-01101000-00011001-10110111
// CHECK: sqsub   z23.h, z13.h, z8.h // encoding: [0xb7,0x19,0x68,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101000-00011001-10110111
SQSUB   Z23.H, Z13.H, Z8.H  // 00000100-01101000-00011001-10110111
// CHECK: sqsub   z23.h, z13.h, z8.h // encoding: [0xb7,0x19,0x68,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101000-00011001-10110111
sqsub   z0.h, z0.h, z0.h  // 00000100-01100000-00011000-00000000
// CHECK: sqsub   z0.h, z0.h, z0.h // encoding: [0x00,0x18,0x60,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100000-00011000-00000000
SQSUB   Z0.H, Z0.H, Z0.H  // 00000100-01100000-00011000-00000000
// CHECK: sqsub   z0.h, z0.h, z0.h // encoding: [0x00,0x18,0x60,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100000-00011000-00000000
