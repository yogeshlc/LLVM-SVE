// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uzp2    p7.d, p13.d, p8.d  // 00000101-11101000-01001101-10100111
// CHECK: uzp2    p7.d, p13.d, p8.d // encoding: [0xa7,0x4d,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-01001101-10100111
UZP2    P7.D, P13.D, P8.D  // 00000101-11101000-01001101-10100111
// CHECK: uzp2    p7.d, p13.d, p8.d // encoding: [0xa7,0x4d,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-01001101-10100111
uzp2    p15.d, p15.d, p15.d  // 00000101-11101111-01001101-11101111
// CHECK: uzp2    p15.d, p15.d, p15.d // encoding: [0xef,0x4d,0xef,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101111-01001101-11101111
UZP2    P15.D, P15.D, P15.D  // 00000101-11101111-01001101-11101111
// CHECK: uzp2    p15.d, p15.d, p15.d // encoding: [0xef,0x4d,0xef,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101111-01001101-11101111
uzp2    p0.d, p0.d, p0.d  // 00000101-11100000-01001100-00000000
// CHECK: uzp2    p0.d, p0.d, p0.d // encoding: [0x00,0x4c,0xe0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100000-01001100-00000000
UZP2    P0.D, P0.D, P0.D  // 00000101-11100000-01001100-00000000
// CHECK: uzp2    p0.d, p0.d, p0.d // encoding: [0x00,0x4c,0xe0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100000-01001100-00000000
uzp2    p5.d, p10.d, p5.d  // 00000101-11100101-01001101-01000101
// CHECK: uzp2    p5.d, p10.d, p5.d // encoding: [0x45,0x4d,0xe5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100101-01001101-01000101
UZP2    P5.D, P10.D, P5.D  // 00000101-11100101-01001101-01000101
// CHECK: uzp2    p5.d, p10.d, p5.d // encoding: [0x45,0x4d,0xe5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100101-01001101-01000101
