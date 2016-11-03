; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s
define <n x 4 x float> @faddz_s_dop_all_distinct(<n x 4 x i1> %pg, <n x 4 x float> %_, <n x 4 x float> %b, <n x 4 x float> %c) {
entry:
; CHECK-LABEL: faddz_s_dop_all_distinct
; CHECK:     movprfx  z0, z1
; CHECK:     fadd     z0.s, p0/m, z0.s, z2.s
; CHECK-NOT: mov
  %0 = call <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %b,
                                                          <n x 4 x float> %c)
  ret <n x 4 x float> %0
}

define <n x 4 x float> @fdivz_s_dop_1st_arg(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
entry:
; CHECK-LABEL: fdivz_s_dop_1st_arg
; CHECK:     fdiv    z0.s, p0/m, z0.s, z1.s
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %a,
                                                          <n x 4 x float> %b)
  ret <n x 4 x float> %0
}

define <n x 4 x float> @fdivz_s_dop_2nd_arg(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
entry:
; CHECK-LABEL: fdivz_s_dop_2nd_arg
; CHECK: fdivr    z0.s, p0/m, z0.s, z1.s
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %b,
                                                          <n x 4 x float> %a)
  ret <n x 4 x float> %0
}

define <n x 4 x float> @fdivz_s_dop_1st_arg_merge_zero(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
entry:
; CHECK-LABEL: fdivz_s_dop_1st_arg_merge_zero
; CHECK:     movprfx z0.s, p0/z, z0.s
; CHECK:     fdiv    z0.s, p0/m, z0.s, z1.s
; CHECK-NOT: mov     {{z[0-9]+}}.s, #0
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %a,
                                                          <n x 4 x float> %b)
  %1 = select <n x 4 x i1> %pg, <n x 4 x float> %0, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %1
}

define <n x 4 x float> @fdivz_s_dop_2nd_merge_zero(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
entry:
; CHECK-LABEL: fdivz_s_dop_2nd_merge_zero
; CHECK:     movprfx  z0.s, p0/z, z0.s
; CHECK:     fdivr    z0.s, p0/m, z0.s, z1.s
; CHECK-NOT: mov     {{z[0-9]+}}.s, #0
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %b,
                                                          <n x 4 x float> %a)
  %1 = select <n x 4 x i1> %pg, <n x 4 x float> %0, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %1
}

; [Note]
; If the first operand needs to be retained (the operation being
; non-destructive, even though the instruction is), it chooses
; a commutative operation where it selects the other operand to be
; destructive. Here, %a will be in z0 (by definition of PCS), and z1 can
; be clobbered. This is why it chooses the commutative operation (fdivr)
; that clobbers z1.
define <n x 4 x float> @fdivz_s_retain_1st(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float>* %ptr) {
entry:
; CHECK-LABEL: fdivz_s_retain_1st
; CHECK-NOT: movprfx
; CHECK: fdivr z1.s, p0/m, z1.s, z0.s
; CHECK: st1w {z0.s}
; CHECK; mov z0.s, z1.s
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %a,
                                                          <n x 4 x float> %b)
  store <n x 4 x float> %a, <n x 4 x float>* %ptr
  ret <n x 4 x float> %0
}

; [Note]
; In the following case the DUP value (mov z_.s #0) is also used in a store to %ptr.
; The test ensures this mov #0 is not removed when merging with fdiv.
define <n x 4 x float> @fdivz_s_dop_1st_arg_merge_zero_retain_dup(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float>* %ptr) {
entry:
; CHECK-LABEL: fdivz_s_dop_1st_arg_merge_zero_retain_dup
; CHECK-DAG: movprfx [[PRFX:z[0-9]+]].s, p0/z, z0.s
; CHECK-DAG: fdiv    z0.s, p0/m, [[PRFX]].s, z1.s
; CHECK-DAG: mov     [[BLA:z[0-9]+]].s, #0
; CHECK-DAG: st1w    {[[BLA]].s}
  store <n x 4 x float> zeroinitializer, <n x 4 x float>* %ptr
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %a,
                                                          <n x 4 x float> %b)
  %1 = select <n x 4 x i1> %pg, <n x 4 x float> %0, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %1
}

define <n x 4 x float> @fdivz_s_dop_1st_arg_merge_zero_retain_dup2(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float>* %ptr) {
entry:
; CHECK-LABEL: fdivz_s_dop_1st_arg_merge_zero_retain_dup2
; CHECK-DAG: movprfx [[PRFX:z[0-9]+]].s, p0/z, z0.s
; CHECK-DAG: fdiv    z0.s, p0/m, [[PRFX]].s, z1.s
; CHECK-DAG: mov     [[BLA:z[0-9]+]].s, #0
; CHECK-DAG: st1w    {[[BLA]].s}
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %a,
                                                          <n x 4 x float> %b)
  store <n x 4 x float> zeroinitializer, <n x 4 x float>* %ptr
  %1 = select <n x 4 x i1> %pg, <n x 4 x float> %0, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %1
}

; [Note]
; The value resulting from the destructive fdiv operation is reused,
; and can therefore not be merged with the select.
define <n x 4 x float> @fdivz_s_dop_1st_arg_no_merging(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float>* %ptr) {
entry:
; CHECK-LABEL: fdivz_s_dop_1st_arg_no_merging
; CHECK-NOT: movprfx
; CHECK-DAG: fdivr   z1.s, p0/m, z1.s, z0.s
; CHECK-DAG: mov     z0.s, #0
; CHECK-DAG: mov     z0.s, p0/m, z1.s
; CHECK-DAG: st1w    {z1.s}
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %a,
                                                          <n x 4 x float> %b)
  %1 = select <n x 4 x i1> %pg, <n x 4 x float> %0, <n x 4 x float> zeroinitializer
  store <n x 4 x float> %0, <n x 4 x float>* %ptr
  ret <n x 4 x float> %1
}

; Similar to related test for fdiv, but instead of fdivr, fadd is already commutative
define <n x 4 x float> @faddz_s_dop_2nd_merge_zero(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
entry:
; CHECK-LABEL: faddz_s_dop_2nd_merge_zero
; CHECK:     movprfx  z0.s, p0/z, z0.s
; CHECK:     fadd     z0.s, p0/m, z0.s, z1.s
; CHECK-NOT: mov     {{z[0-9]+}}.s, #0
  %0 = call <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %b,
                                                          <n x 4 x float> %a)
  %1 = select <n x 4 x i1> %pg, <n x 4 x float> %0, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %1
}


declare <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 4 x float> @llvm.aarch64.sve.divr.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
