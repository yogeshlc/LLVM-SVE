; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; FABD
;

define <n x 4 x float> @fabd_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fabd_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fabd z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.abd.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fabd_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fabd_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fabd z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.abd.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FABS
;

define <n x 4 x float> @fabs_s(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fabs_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fabs z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.abs.nxv4f32(<n x 4 x float> %a,
                                                            <n x 4 x i1> %pg,
                                                            <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fabs_d(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fabs_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fabs z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.abs.nxv2f64(<n x 2 x double> %a,
                                                             <n x 2 x i1> %pg,
                                                             <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FADD
;

define <n x 4 x float> @fadd_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fadd_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fadd z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fadd_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fadd_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fadd z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.add.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FDIV
;

define <n x 4 x float> @fdiv_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fdiv_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fdiv z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fdiv_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fdiv_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fdiv z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.div.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FDIVR
;

define <n x 4 x float> @fdivr_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fdivr_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fdivr z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.divr.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %a,
                                                             <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fdivr_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fdivr_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fdivr z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.divr.nxv2f64(<n x 2 x i1> %pg,
                                                              <n x 2 x double> %a,
                                                              <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FMAX
;

define <n x 4 x float> @fmax_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fmax_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fmax z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.max.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmax_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fmax_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fmax z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.max.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FMAXNM
;

define <n x 4 x float> @fmaxnm_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fmaxnm_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fmaxnm z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.maxnm.nxv4f32(<n x 4 x i1> %pg,
                                                              <n x 4 x float> %a,
                                                              <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmaxnm_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fmaxnm_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fmaxnm z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.maxnm.nxv2f64(<n x 2 x i1> %pg,
                                                               <n x 2 x double> %a,
                                                               <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FMIN
;

define <n x 4 x float> @fmin_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fmin_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fmin z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.min.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmin_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fmin_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fmin z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.min.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FMINNM
;

define <n x 4 x float> @fminnm_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fminnm_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fminnm z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.minnm.nxv4f32(<n x 4 x i1> %pg,
                                                              <n x 4 x float> %a,
                                                              <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fminnm_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fminnm_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fminnm z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.minnm.nxv2f64(<n x 2 x i1> %pg,
                                                               <n x 2 x double> %a,
                                                               <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FMUL
;

define <n x 4 x float> @fmul_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fmul_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fmul z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.mul.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmul_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fmul_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fmul z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.mul.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FMULX
;

define <n x 4 x float> @fmulx_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fmulx_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fmulx z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.mulx.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %a,
                                                             <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmulx_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fmulx_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fmulx z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.mulx.nxv2f64(<n x 2 x i1> %pg,
                                                              <n x 2 x double> %a,
                                                              <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FNEG
;

define <n x 4 x float> @fneg_s(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fneg_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fneg z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.neg.nxv4f32(<n x 4 x float> %a,
                                                            <n x 4 x i1> %pg,
                                                            <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fneg_d(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fneg_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fneg z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.neg.nxv2f64(<n x 2 x double> %a,
                                                             <n x 2 x i1> %pg,
                                                             <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FRECPX
;

define <n x 4 x float> @frecpx_s(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: frecpx_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frecpx z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.recpx.nxv4f32(<n x 4 x float> %a,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frecpx_d(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: frecpx_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frecpx z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.recpx.nxv2f64(<n x 2 x double> %a,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FRINTA
;

define <n x 4 x float> @frinta_s(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: frinta_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frinta z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.rinta.nxv4f32(<n x 4 x float> %a,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frinta_d(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: frinta_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frinta z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.rinta.nxv2f64(<n x 2 x double> %a,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FRINTI
;

define <n x 4 x float> @frinti_s(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: frinti_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frinti z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.rinti.nxv4f32(<n x 4 x float> %a,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frinti_d(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: frinti_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frinti z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.rinti.nxv2f64(<n x 2 x double> %a,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FRINTM
;

define <n x 4 x float> @frintm_s(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: frintm_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frintm z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.rintm.nxv4f32(<n x 4 x float> %a,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frintm_d(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: frintm_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frintm z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.rintm.nxv2f64(<n x 2 x double> %a,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FRINTN
;

define <n x 4 x float> @frintn_s(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: frintn_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frintn z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.rintn.nxv4f32(<n x 4 x float> %a,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frintn_d(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: frintn_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frintn z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.rintn.nxv2f64(<n x 2 x double> %a,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FRINTP
;

define <n x 4 x float> @frintp_s(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: frintp_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frintp z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.rintp.nxv4f32(<n x 4 x float> %a,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frintp_d(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: frintp_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frintp z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.rintp.nxv2f64(<n x 2 x double> %a,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FRINTX
;

define <n x 4 x float> @frintx_s(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: frintx_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frintx z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.rintx.nxv4f32(<n x 4 x float> %a,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frintx_d(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: frintx_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frintx z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.rintx.nxv2f64(<n x 2 x double> %a,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FRINTZ
;

define <n x 4 x float> @frintz_s(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: frintz_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frintz z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.rintz.nxv4f32(<n x 4 x float> %a,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frintz_d(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: frintz_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frintz z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.rintz.nxv2f64(<n x 2 x double> %a,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FSCALE
;

define <n x 4 x float> @fscale_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: fscale_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fscale z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.scale.nxv4f32(<n x 4 x i1> %pg,
                                                              <n x 4 x float> %a,
                                                              <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fscale_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: fscale_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fscale z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.scale.nxv2f64(<n x 2 x i1> %pg,
                                                               <n x 2 x double> %a,
                                                               <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FSQRT
;

define <n x 4 x float> @fsqrt_s(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fsqrt_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fsqrt z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.sqrt.nxv4f32(<n x 4 x float> %a,
                                                             <n x 4 x i1> %pg,
                                                             <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fsqrt_d(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fsqrt_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fsqrt z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.sqrt.nxv2f64(<n x 2 x double> %a,
                                                              <n x 2 x i1> %pg,
                                                              <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FSUB
;

define <n x 4 x float> @fsub_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fsub_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fsub z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.sub.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fsub_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fsub_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fsub z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.sub.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FSUBR
;

define <n x 4 x float> @fsubr_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fsubr_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fsubr z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.subr.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %a,
                                                             <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fsubr_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fsubr_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fsubr z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.subr.nxv2f64(<n x 2 x i1> %pg,
                                                              <n x 2 x double> %a,
                                                              <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

declare <n x 4 x float> @llvm.aarch64.sve.abd.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.abd.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.abs.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.abs.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.add.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.div.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.divr.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.divr.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.expa.nxv4f32(<n x 4 x i32>)
declare <n x 2 x double> @llvm.aarch64.sve.expa.nxv2f64(<n x 2 x i64>)

declare <n x 4 x float> @llvm.aarch64.sve.mad.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.mad.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.max.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.max.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.maxnm.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.maxnm.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.min.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.min.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.minnm.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.minnm.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.mla.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.mla.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.mls.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.mls.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.msb.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.msb.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.mul.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.mul.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.mulx.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.mulx.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.neg.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.neg.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.nmad.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.nmad.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.nmla.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.nmla.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.nmls.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.nmls.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.nmsb.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.nmsb.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.recpe.nxv4f32(<n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.recpe.nxv2f64(<n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.recps.nxv4f32(<n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.recps.nxv2f64(<n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.recpx.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.recpx.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.rinta.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rinta.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.rinti.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rinti.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.rintm.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rintm.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.rintn.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rintn.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.rintp.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rintp.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.rintx.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rintx.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.rintz.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rintz.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.rsqrte.nxv4f32(<n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rsqrte.nxv2f64(<n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.rsqrts.nxv4f32(<n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rsqrts.nxv2f64(<n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.scale.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x i32>)
declare <n x 2 x double> @llvm.aarch64.sve.scale.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x i64>)

declare <n x 4 x float> @llvm.aarch64.sve.sqrt.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.sqrt.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.sub.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.sub.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.subr.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.subr.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 4 x float> @llvm.aarch64.sve.tmad.nxv4f32(<n x 4 x float>, <n x 4 x float>, i32)
declare <n x 2 x double> @llvm.aarch64.sve.tmad.nxv2f64(<n x 2 x double>, <n x 2 x double>, i32)

declare <n x 4 x float> @llvm.aarch64.sve.tsmul.nxv4f32(<n x 4 x float>, <n x 4 x i32>)
declare <n x 2 x double> @llvm.aarch64.sve.tsmul.nxv2f64(<n x 2 x double>, <n x 2 x i64>)

declare <n x 4 x float> @llvm.aarch64.sve.tssel.nxv4f32(<n x 4 x float>, <n x 4 x i32>)
declare <n x 2 x double> @llvm.aarch64.sve.tssel.nxv2f64(<n x 2 x double>, <n x 2 x i64>)
