; RUN: llc < %s -mtriple aarch64-none-linux-gnu -mattr=+sve | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

declare <n x 2 x i64> @zfun1()
declare i64 @zfun2(<n x 2 x i64> %tmpz0)

define i64 @ztest() {
; Ensure the z0 register is preserved across the inline asm
; CHECK-LABEL: ztest:
; CHECK: mov z[[TMP:[0-9]+]].d, z0.d
; CHECK: ptrue p0.d
; CHECK: mov z0.s, #3
; CHECK: smaxv d{{[0-9]+}}, p0, z0.d
; CHECK: mov z0.d, z[[TMP]].d
entry:
  %tmpz0 = call <n x 2 x i64> @zfun1()
  %0 = call i64 asm sideeffect "ptrue p0.d\0Amov z0.s, #3\0Asmaxv ${0:d}, p0, z0.d\0A", "=w,~{z0},~{p0}"() #1, !srcloc !0
  %tmpx0 = call i64 @zfun2(<n x 2 x i64> %tmpz0)
  %1 = add i64 %0, %tmpx0
  ret i64 %1
}

declare <n x 2 x i1> @pfun1()
declare i64 @pfun2(<n x 2 x i1> %tmpp0)

define i64 @ptest() {
; Ensure the p0 register is preserved across the inline asm
; CHECK-LABEL: ptest:
; CHECK: mov p[[TMP:[0-9]+]].b, p0.b
; CHECK: ptrue p0.d
; CHECK: mov z0.s, #3
; CHECK: smaxv d{{[0-9]+}}, p0, z0.d
; CHECK: mov p0.b, p[[TMP]].b
entry:
  %tmpp0 = call <n x 2 x i1> @pfun1()
  %0 = call i64 asm sideeffect "ptrue p0.d\0Amov z0.s, #3\0Asmaxv ${0:d}, p0, z0.d\0A", "=w,~{z0},~{p0}"() #1, !srcloc !0
  %tmpx0 = call i64 @pfun2(<n x 2 x i1> %tmpp0)
  %1 = add i64 %0, %tmpx0
  ret i64 %1
}

!0 = !{i32 188, i32 210}
