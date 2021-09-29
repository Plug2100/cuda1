Компиляция
nvcc -O3 -gencode arch=compute_52,code=sm_52 -gencode arch=compute_60,code=sm_60 cuda1.cu lodepng.cpp
Запуск
./a.out 1 2
Где вместо 1: Bulr, Blur5, edge_detection
2: big, small
