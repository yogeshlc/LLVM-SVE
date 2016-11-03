// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
zip1    p0.d, p0.d, p0.d  // 00000101-11100000-01000000-00000000
// CHECK: zip1    p0.d, p0.d, p0.d // encoding: [0x00,0x40,0xe0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100000-01000000-00000000
ZIP1    P0.D, P0.D, P0.D  // 00000101-11100000-01000000-00000000
// CHECK: zip1    p0.d, p0.d, p0.d // encoding: [0x00,0x40,0xe0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100000-01000000-00000000
zip1    p7.d, p13.d, p8.d  // 00000101-11101000-01000001-10100111
// CHECK: zip1    p7.d, p13.d, p8.d // encoding: [0xa7,0x41,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-01000001-10100111
ZIP1    P7.D, P13.D, P8.D  // 00000101-11101000-01000001-10100111
// CHECK: zip1    p7.d, p13.d, p8.d // encoding: [0xa7,0x41,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-01000001-10100111
zip1    p15.d, p15.d, p15.d  // 00000101-11101111-01000001-11101111
// CHECK: zip1    p15.d, p15.d, p15.d // encoding: [0xef,0x41,0xef,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101111-01000001-11101111
ZIP1    P15.D, P15.D, P15.D  // 00000101-11101111-01000001-11101111
// CHECK: zip1    p15.d, p15.d, p15.d // encoding: [0xef,0x41,0xef,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101111-01000001-11101111
zip1    p5.d, p10.d, p5.d  // 00000101-11100101-01000001-01000101
// CHECK: zip1    p5.d, p10.d, p5.d // encoding: [0x45,0x41,0xe5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100101-01000001-01000101
ZIP1    P5.D, P10.D, P5.D  // 00000101-11100101-01000001-01000101
// CHECK: zip1    p5.d, p10.d, p5.d // encoding: [0x45,0x41,0xe5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100101-01000001-01000101
