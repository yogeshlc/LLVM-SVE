// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqsub   z0.b, z0.b, z0.b  // 00000100-00100000-00011000-00000000
// CHECK: sqsub   z0.b, z0.b, z0.b // encoding: [0x00,0x18,0x20,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100000-00011000-00000000
SQSUB   Z0.B, Z0.B, Z0.B  // 00000100-00100000-00011000-00000000
// CHECK: sqsub   z0.b, z0.b, z0.b // encoding: [0x00,0x18,0x20,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100000-00011000-00000000
sqsub   z31.b, z31.b, z31.b  // 00000100-00111111-00011011-11111111
// CHECK: sqsub   z31.b, z31.b, z31.b // encoding: [0xff,0x1b,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-00011011-11111111
SQSUB   Z31.B, Z31.B, Z31.B  // 00000100-00111111-00011011-11111111
// CHECK: sqsub   z31.b, z31.b, z31.b // encoding: [0xff,0x1b,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-00011011-11111111
sqsub   z23.b, z13.b, z8.b  // 00000100-00101000-00011001-10110111
// CHECK: sqsub   z23.b, z13.b, z8.b // encoding: [0xb7,0x19,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-00011001-10110111
SQSUB   Z23.B, Z13.B, Z8.B  // 00000100-00101000-00011001-10110111
// CHECK: sqsub   z23.b, z13.b, z8.b // encoding: [0xb7,0x19,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-00011001-10110111
sqsub   z21.b, z10.b, z21.b  // 00000100-00110101-00011001-01010101
// CHECK: sqsub   z21.b, z10.b, z21.b // encoding: [0x55,0x19,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-00011001-01010101
SQSUB   Z21.B, Z10.B, Z21.B  // 00000100-00110101-00011001-01010101
// CHECK: sqsub   z21.b, z10.b, z21.b // encoding: [0x55,0x19,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-00011001-01010101
