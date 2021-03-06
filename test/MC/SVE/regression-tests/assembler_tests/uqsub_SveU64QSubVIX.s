// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqsub   z21.d, z21.d, #170  // 00100101-11100111-11010101-01010101
// CHECK: uqsub   z21.d, z21.d, #170 // encoding: [0x55,0xd5,0xe7,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100111-11010101-01010101
UQSUB   Z21.D, Z21.D, #170  // 00100101-11100111-11010101-01010101
// CHECK: uqsub   z21.d, z21.d, #170 // encoding: [0x55,0xd5,0xe7,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100111-11010101-01010101
uqsub   z23.d, z23.d, #109, lsl #8  // 00100101-11100111-11101101-10110111
// CHECK: uqsub   z23.d, z23.d, #27904 // encoding: [0xb7,0xed,0xe7,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100111-11101101-10110111
UQSUB   Z23.D, Z23.D, #109, LSL #8  // 00100101-11100111-11101101-10110111
// CHECK: uqsub   z23.d, z23.d, #27904 // encoding: [0xb7,0xed,0xe7,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100111-11101101-10110111
uqsub   z23.d, z23.d, #27904  // 00100101-11100111-11101101-10110111
// CHECK: uqsub   z23.d, z23.d, #27904 // encoding: [0xb7,0xed,0xe7,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100111-11101101-10110111
UQSUB   Z23.D, Z23.D, #27904  // 00100101-11100111-11101101-10110111
// CHECK: uqsub   z23.d, z23.d, #27904 // encoding: [0xb7,0xed,0xe7,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100111-11101101-10110111
uqsub   z0.d, z0.d, #0  // 00100101-11100111-11000000-00000000
// CHECK: uqsub   z0.d, z0.d, #0 // encoding: [0x00,0xc0,0xe7,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100111-11000000-00000000
UQSUB   Z0.D, Z0.D, #0  // 00100101-11100111-11000000-00000000
// CHECK: uqsub   z0.d, z0.d, #0 // encoding: [0x00,0xc0,0xe7,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100111-11000000-00000000
uqsub   z31.d, z31.d, #255, lsl #8  // 00100101-11100111-11111111-11111111
// CHECK: uqsub   z31.d, z31.d, #65280 // encoding: [0xff,0xff,0xe7,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100111-11111111-11111111
UQSUB   Z31.D, Z31.D, #255, LSL #8  // 00100101-11100111-11111111-11111111
// CHECK: uqsub   z31.d, z31.d, #65280 // encoding: [0xff,0xff,0xe7,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100111-11111111-11111111
uqsub   z31.d, z31.d, #65280  // 00100101-11100111-11111111-11111111
// CHECK: uqsub   z31.d, z31.d, #65280 // encoding: [0xff,0xff,0xe7,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100111-11111111-11111111
UQSUB   Z31.D, Z31.D, #65280  // 00100101-11100111-11111111-11111111
// CHECK: uqsub   z31.d, z31.d, #65280 // encoding: [0xff,0xff,0xe7,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100111-11111111-11111111
