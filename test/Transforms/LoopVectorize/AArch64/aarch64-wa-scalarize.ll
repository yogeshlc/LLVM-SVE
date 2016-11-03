; RUN: opt < %s -loop-vectorize -mtriple=x86_64-none-linux-gnu -mattr=+sve -force-scalable-vectorization -force-vector-width=2 -S | FileCheck %s
; We use the x86_64 target here because the aarch64 target doesn't generate
; this scalarizing loop, instead using a more optimal approach of expanding
; the scalable call to a loop in the back-end.
; XFAIL: *
; It is now expected that every vectorised call that does not have a direct
; mapping for code generation must be scalarized by SVEExpandLibCall.
; This test remains until we can determin whether the original scalarisation
; code (LV::scalarizeInstructionWithSubloop) still offers value.

; This code is generated from the following C:
; #define LEN 1024
; void foo(double * restrict A, double * restrict B, long long n) {
;   for (long long i = 0; i < LEN; ++i) {
;     A[i] = B[i] * sin(B[i]) + 1.0 + cos(B[i]) / pow(A[i], B[i]);
;   }
; }

; Function Attrs: nounwind
define void @foo(double* noalias nocapture %A, double* noalias nocapture readonly %B, i64 %n) #0 {
entry:
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void

for.body:                                         ; preds = %for.body, %entry
  %i.020 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds double, double* %B, i64 %i.020
  %0 = load double, double* %arrayidx, align 8, !tbaa !1
; CHECK: load <n x 2 x double>
  %call = tail call double @sin(double %0) #2
; CHECK: extractelement <n x 2 x double>
; CHECK: tail call double @sin
; CHECK: insertelement <n x 2 x double>
  %mul = fmul fast double %call, %0
  %add = fadd fast double %mul, 1.000000e+00
  %call3 = tail call double @cos(double %0) #2
; CHECK: extractelement <n x 2 x double>
; CHECK: tail call double @cos
; CHECK: insertelement <n x 2 x double>
  %arrayidx4 = getelementptr inbounds double, double* %A, i64 %i.020
  %1 = load double, double* %arrayidx4, align 8, !tbaa !1
  %2 = tail call double @llvm.pow.f64(double %1, double %0)
; CHECK: extractelement <n x 2 x double>
; CHECK: tail call double @llvm.pow.f64
; CHECK: insertelement <n x 2 x double>
  %div = fdiv fast double %call3, %2
  %add6 = fadd fast double %add, %div
  store double %add6, double* %arrayidx4, align 8, !tbaa !1
  %inc = add nuw nsw i64 %i.020, 1
  %exitcond = icmp eq i64 %inc, 1024
  br i1 %exitcond, label %for.cond.cleanup, label %for.body
}

; Function Attrs: nounwind readnone
declare double @sin(double) #1

; Function Attrs: nounwind readnone
declare double @cos(double) #1

; Function Attrs: nounwind readnone
declare double @llvm.pow.f64(double, double) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"double", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
