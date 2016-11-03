; RUN: opt < %s -loop-vectorize -mtriple=aarch64-none-linux-gnu -mattr=+sve -force-vector-width=4 -force-vector-predication -force-scalable-vectorization -S | FileCheck %s
; RUN: opt < %s -loop-vectorize -mtriple=aarch64-none-linux-gnu -mattr=+sve -force-vector-width=4 -S | FileCheck --check-prefix=FIXED %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64"

@x = global [8 x float] [float 9.000000e+00, float 1.000000e+00, float 2.000000e+00, float 3.000000e+00, float 4.000000e+00, float 5.000000e+00, float 6.000000e+00, float 7.000000e+00], align 4
@.str = private unnamed_addr constant [21 x i8] c"add_const final: %f\0A\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"[%d] = %f\0A\00", align 1
@.str.2 = private unnamed_addr constant [25 x i8] c"add_invariant final: %f\0A\00", align 1
@.str.3 = private unnamed_addr constant [21 x i8] c"sub_const final: %f\0A\00", align 1

; Function Attrs: noinline norecurse nounwind
define float @add_const(i32 %n) #0 {
entry:
; CHECK-LABEL: add_const
; CHECK-LABEL: vector.body:
; CHECK: uitofp i64 %index to float
; CHECK: fmul fast float
; CHECK: %fpiv.offset.idx = fadd fast float %.pre
; CHECK: %broadcast.splatinsert = insertelement <n x 4 x float> undef, float %fpiv.offset.idx, i32 0
; CHECK: %induction = fadd <n x 4 x float>
; FIXED-LABEL: add_const
; FIXED-LABEL: vector.body:
; FIXED: uitofp i64 %index to float
; FIXED: fmul fast float
; FIXED: %fpiv.offset.idx = fadd fast float %.pre
; FIXED: %broadcast.splatinsert = insertelement <4 x float> undef, float %fpiv.offset.idx, i32 0
; FIXED: %induction = fadd <4 x float>
  %cmp.12 = icmp sgt i32 %n, 1
  br i1 %cmp.12, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %.pre = load float, float* getelementptr inbounds ([8 x float], [8 x float]* @x, i64 0, i64 0), align 4, !tbaa !1
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  %sub4 = add nsw i32 %n, -1
  %idxprom5 = sext i32 %sub4 to i64
  %arrayidx6 = getelementptr inbounds [8 x float], [8 x float]* @x, i64 0, i64 %idxprom5
  %0 = load float, float* %arrayidx6, align 4, !tbaa !1
  ret float %0

for.body:                                         ; preds = %for.body, %for.body.preheader
  %1 = phi float [ %.pre, %for.body.preheader ], [ %conv1, %for.body ]
  %indvars.iv = phi i64 [ 1, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %conv1 = fadd fast float %1, 3.000000e+00
  %arrayidx3 = getelementptr inbounds [8 x float], [8 x float]* @x, i64 0, i64 %indvars.iv
  store float %conv1, float* %arrayidx3, align 4, !tbaa !1
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

; Function Attrs: noinline norecurse nounwind
define float @add_invariant(i32 %n, float %inv) #0 {
entry:
; CHECK-LABEL: add_invariant
; CHECK-LABEL: vector.body:
; CHECK: uitofp i64 %index to float
; CHECK: fmul fast float
; CHECK: %fpiv.offset.idx = fadd fast float %.pre
; CHECK: %broadcast.splatinsert = insertelement <n x 4 x float> undef, float %fpiv.offset.idx, i32 0
; CHECK: %induction = fadd <n x 4 x float>
; FIXED-LABEL: add_invariant
; FIXED-LABEL: vector.body:
; FIXED: uitofp i64 %index to float
; FIXED: fmul fast float
; FIXED: %fpiv.offset.idx = fadd fast float %.pre
; FIXED: %broadcast.splatinsert = insertelement <4 x float> undef, float %fpiv.offset.idx, i32 0
; FIXED: %induction = fadd <4 x float>
  %cmp.11 = icmp sgt i32 %n, 1
  br i1 %cmp.11, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %.pre = load float, float* getelementptr inbounds ([8 x float], [8 x float]* @x, i64 0, i64 0), align 4, !tbaa !1
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  %sub3 = add nsw i32 %n, -1
  %idxprom4 = sext i32 %sub3 to i64
  %arrayidx5 = getelementptr inbounds [8 x float], [8 x float]* @x, i64 0, i64 %idxprom4
  %0 = load float, float* %arrayidx5, align 4, !tbaa !1
  ret float %0

for.body:                                         ; preds = %for.body, %for.body.preheader
  %1 = phi float [ %.pre, %for.body.preheader ], [ %add, %for.body ]
  %indvars.iv = phi i64 [ 1, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %add = fadd fast float %1, %inv
  %arrayidx2 = getelementptr inbounds [8 x float], [8 x float]* @x, i64 0, i64 %indvars.iv
  store float %add, float* %arrayidx2, align 4, !tbaa !1
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

; Function Attrs: noinline norecurse nounwind
define float @sub_const(i32 %n) #0 {
entry:
; CHECK-LABEL: sub_const
; CHECK-LABEL: vector.body:
; CHECK: uitofp i64 %index to float
; CHECK: fmul fast float
; CHECK: %fpiv.offset.idx = fadd fast float %.pre
; CHECK: %broadcast.splatinsert = insertelement <n x 4 x float> undef, float %fpiv.offset.idx, i32 0
; CHECK: %induction = fadd <n x 4 x float>
; FIXED-LABEL: sub_const
; FIXED-LABEL: vector.body:
; FIXED: uitofp i64 %index to float
; FIXED: fmul fast float
; FIXED: %fpiv.offset.idx = fadd fast float %.pre
; FIXED: %broadcast.splatinsert = insertelement <4 x float> undef, float %fpiv.offset.idx, i32 0
; FIXED: %induction = fadd <4 x float>
  %cmp.13 = icmp sgt i32 %n, 1
  br i1 %cmp.13, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %.pre = load float, float* getelementptr inbounds ([8 x float], [8 x float]* @x, i64 0, i64 0), align 4, !tbaa !1
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  %sub5 = add nsw i32 %n, -1
  %idxprom6 = sext i32 %sub5 to i64
  %arrayidx7 = getelementptr inbounds [8 x float], [8 x float]* @x, i64 0, i64 %idxprom6
  %0 = load float, float* %arrayidx7, align 4, !tbaa !1
  ret float %0

for.body:                                         ; preds = %for.body, %for.body.preheader
  %1 = phi float [ %.pre, %for.body.preheader ], [ %conv2, %for.body ]
  %indvars.iv = phi i64 [ 1, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %conv2 = fadd fast float %1, -3.000000e+00
  %arrayidx4 = getelementptr inbounds [8 x float], [8 x float]* @x, i64 0, i64 %indvars.iv
  store float %conv2, float* %arrayidx4, align 4, !tbaa !1
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

attributes #0 = { noinline norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"float", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
