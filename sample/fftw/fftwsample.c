#include <stdio.h>
#include <fftw3.h>

int main() {
    int N = 16;
    double in[N];
    fftw_complex out[N/2 + 1];
    fftw_plan p;

    // 入力データを初期化
    for (int i = 0; i < N; i++) {
        in[i] = i + 1.0;
    }

    // FFTの計画を作成
    p = fftw_plan_dft_r2c_1d(N, in, out, FFTW_ESTIMATE);

    // FFTの実行
    fftw_execute(p);

    // 出力結果を表示
    printf("FFT output:\n");
    for (int i = 0; i < N/2 + 1; i++) {
        printf("out[%d] = %2.2f + %2.2fi\n", i, out[i][0], out[i][1]);
    }

    // メモリを解放
    fftw_destroy_plan(p);
    fftw_cleanup();

    return 0;
}
