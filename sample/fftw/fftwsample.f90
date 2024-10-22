program fftw_example
  use fftw3
  implicit none

  integer, parameter :: N = 16
  real(8) :: in(N)
  complex(8) :: out(N/2 + 1)
  type(fftw_plan) :: plan
  integer :: i

  ! 入力データの初期化
  do i = 1, N
     in(i) = dble(i)
  end do

  ! FFTの計画を作成
  plan = fftw_plan_dft_r2c_1d(N, in, out, FFTW_ESTIMATE)

  ! FFTの実行
  call fftw_execute(plan)

  ! 結果を表示
  print *, "FFT output:"
  do i = 1, N/2 + 1
     print *, "out(", i, ") = ", out(i)
  end do

  ! メモリを解放
  call fftw_destroy_plan(plan)
  call fftw_cleanup()

end program fftw_example
