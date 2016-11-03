// RUN: llvm-mc -triple=aarch64-none-linux-gnu -mattr=+sve -show-encoding < %s 2>&1 | FileCheck %s

bar:
        beetroot .req p5
// CHECK-NOT: ignoring redefinition of register alias 'beetroot'
        beetroot .req p5
        mov beetroot.b, p11.b
        .unreq beetroot
        beetroot .req p6
        mov p1.b, beetroot.b

        onion   .req beetroot
        cabbage .req p1
        mov cabbage.b, onion.b
        .unreq onion
        .unreq beetroot
        .unreq cabbage
// CHECK: mov      p5.b, p11.b    // encoding: [0x65,0x6d,0x8b,0x25]
// CHECK: mov      p1.b, p6.b     // encoding: [0xc1,0x58,0x86,0x25]
// CHECK: mov      p1.b, p6.b     // encoding: [0xc1,0x58,0x86,0x25]

        tomato   .req d6
        broccoli .req h5
        celery   .req z2
        potato   .req z1
        carrot   .req p7
        saddv tomato,   carrot, z0.b
        lastb broccoli, carrot, z4.h
        ldr   celery,   [sp]
        mov   z0.d,     potato.d
// CHECK: saddv   d6,   p7,  z0.b   // encoding: [0x06,0x3c,0x00,0x04]
// CHECK: lastb   h5,   p7,  z4.h   // encoding: [0x85,0x9c,0x63,0x05]
// CHECK: ldr     z2,   [sp]        // encoding: [0xe2,0x43,0x80,0x85]
// CHECK: mov     z0.d, z1.d        // encoding: [0x20,0x30,0x61,0x04]
