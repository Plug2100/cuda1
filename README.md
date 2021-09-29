Компиляция \n
nvcc -O3 -gencode arch=compute_52,code=sm_52 -gencode arch=compute_60,code=sm_60 cuda1.cu lodepng.cpp \n
Запуск \n
./a.out 1 2 \n
Где вместо 1: Bulr, Blur5, edge_detection \n
2: big, small
