Компиляция <br\>    
nvcc -O3 -gencode arch=compute_52,code=sm_52 -gencode arch=compute_60,code=sm_60 cuda1.cu lodepng.cpp <br\>   
Запуск <br\>  
./a.out 1 2 <br\>  
Где вместо 1: Bulr, Blur5, edge_detection <br\>  
2: big, small <br\>
