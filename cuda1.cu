#include <iostream>
#include <fstream>
#include <vector>
#include "lodepng.h"
using namespace std;

__global__
void filtr(const unsigned char* dev_input, unsigned char* dev_output, int width, int height, int cern) {
    //Индекс треда внутри текущего блока
    const unsigned int linearX = blockIdx.x * blockDim.x + threadIdx.x;
    const unsigned int linearY = blockIdx.y * blockDim.y + threadIdx.y;
    if (linearX >= width || linearY >= height) {
        return;
    }
    if(cern == 1){
        if(linearY > 1 and linearY < (height - 2) and linearX > 1 and linearX < (width - 2)) {
            dev_output[3 * (linearY * width + linearX)] = 
                    (dev_input[3 * (linearY * width + linearX )] *(36) +
                    dev_input[3 * (linearY * width + linearX - 1)] * 24 +
                    dev_input[3 * ((linearY + 1) * width + linearX)] * 24 +
                    dev_input[3 * ((linearY - 1) * width + linearX)] * 24 +
                    dev_input[3 * (linearY * width + linearX + 1)] * 24 +

                    dev_input[3 * ((linearY - 1) * width + linearX - 1)] * 16 +
                    dev_input[3 * ((linearY + 1) * width + linearX - 1)] * 16 +
                    dev_input[3 * ((linearY - 1) * width + linearX + 1)] * 16 +
                    dev_input[3 * ((linearY + 1) * width + linearX + 1)] * 16 +

                    dev_input[3 * (linearY * width + linearX - 2)] * 6 +
                    dev_input[3 * ((linearY + 2) * width + linearX)] * 6 +
                    dev_input[3 * ((linearY - 2) * width + linearX)] * 6 +
                    dev_input[3 * (linearY * width + linearX + 2)] * 6 +


                    dev_input[3 * ((linearY + 2) * width + linearX - 2)] +
                    dev_input[3 * ((linearY + 2) * width + linearX + 2)] +
                    dev_input[3 * ((linearY - 2) * width + linearX - 2)] +
                    dev_input[3 * ((linearY - 2) * width + linearX + 2)] +


                    dev_input[3 * ((linearY + 2) * width + linearX - 1)] +
                    dev_input[3 * ((linearY + 2) * width + linearX + 1)] +
                    dev_input[3 * ((linearY - 2) * width + linearX - 1)] +
                    dev_input[3 * ((linearY - 2) * width + linearX + 1)] +

                    dev_input[3 * ((linearY + 1) * width + linearX - 2)] +
                    dev_input[3 * ((linearY + 1) * width + linearX + 2)] +
                    dev_input[3 * ((linearY - 1) * width + linearX - 2)] +
                    dev_input[3 * ((linearY - 1) * width + linearX + 2)] ) / 256;




             dev_output[3 * (linearY * width + linearX) + 1] = (
                    dev_input[3 * (linearY * width + linearX ) + 1] * 36 +
                    dev_input[3 * (linearY * width + linearX - 1) + 1] * 24 +
                    dev_input[3 * ((linearY + 1) * width + linearX) + 1] * 24 +
                    dev_input[3 * ((linearY - 1) * width + linearX) + 1] * 24 +
                    dev_input[3 * (linearY * width + linearX + 1) + 1] * 24 +

                    dev_input[3 * ((linearY - 1) * width + linearX - 1) + 1] * 16 +
                    dev_input[3 * ((linearY + 1) * width + linearX - 1) + 1] * 16 +
                    dev_input[3 * ((linearY - 1) * width + linearX + 1) + 1] * 16 +
                    dev_input[3 * ((linearY + 1) * width + linearX + 1) + 1] * 16 +

                    dev_input[3 * (linearY * width + linearX - 2) + 1] * 6 +
                    dev_input[3 * ((linearY + 2) * width + linearX) + 1] * 6 +
                    dev_input[3 * ((linearY - 2) * width + linearX) + 1] * 6 +
                    dev_input[3 * (linearY * width + linearX + 2) + 1] * 6 +


                    dev_input[3 * ((linearY + 2) * width + linearX - 2) + 1] +
                    dev_input[3 * ((linearY + 2) * width + linearX + 2) + 1] +
                    dev_input[3 * ((linearY - 2) * width + linearX - 2) + 1] +
                    dev_input[3 * ((linearY - 2) * width + linearX + 2) + 1] +


                    dev_input[3 * ((linearY + 2) * width + linearX - 1) + 1] * 4 +
                    dev_input[3 * ((linearY + 2) * width + linearX + 1) + 1] * 4 +
                    dev_input[3 * ((linearY - 2) * width + linearX - 1) + 1] * 4 +
                    dev_input[3 * ((linearY - 2) * width + linearX + 1) + 1] * 4 +

                    dev_input[3 * ((linearY + 1) * width + linearX - 2) + 1] * 4 +
                    dev_input[3 * ((linearY + 1) * width + linearX + 2) + 1] * 4 +
                    dev_input[3 * ((linearY - 1) * width + linearX - 2) + 1] * 4 +
                    dev_input[3 * ((linearY - 1) * width + linearX + 2) + 1] * 4) / 256;




            dev_output[3 * (linearY * width + linearX) + 2] = (
                    dev_input[3 * (linearY * width + linearX ) + 2] *(36) +
                    dev_input[3 * (linearY * width + linearX - 1) + 2] * 24 +
                    dev_input[3 * ((linearY + 1) * width + linearX) + 2] * 24 +
                    dev_input[3 * ((linearY - 1) * width + linearX) + 2] * 24 +
                    dev_input[3 * (linearY * width + linearX + 1) + 2] * 24 +

                    dev_input[3 * ((linearY - 1) * width + linearX - 1) + 2] * 16 +
                    dev_input[3 * ((linearY + 1) * width + linearX - 1) + 2] * 16 +
                    dev_input[3 * ((linearY - 1) * width + linearX + 1) + 2] * 16 +
                    dev_input[3 * ((linearY + 1) * width + linearX + 1) + 1] * 16 +

                    dev_input[3 * (linearY * width + linearX - 2) + 2] * 6 +
                    dev_input[3 * ((linearY + 2) * width + linearX) + 2] * 6 +
                    dev_input[3 * ((linearY - 2) * width + linearX) + 2] * 6 +
                    dev_input[3 * (linearY * width + linearX + 2) + 2] * 6 +


                    dev_input[3 * ((linearY + 2) * width + linearX - 2) + 2] +
                    dev_input[3 * ((linearY + 2) * width + linearX + 2) + 2] +
                    dev_input[3 * ((linearY - 2) * width + linearX - 2) + 2] +
                    dev_input[3 * ((linearY - 2) * width + linearX + 2) + 2] +


                    dev_input[3 * ((linearY + 2) * width + linearX - 1) + 2] * 4 +
                    dev_input[3 * ((linearY + 2) * width + linearX + 1) + 2] * 4 +
                    dev_input[3 * ((linearY - 2) * width + linearX - 1) + 2] * 4 +
                    dev_input[3 * ((linearY - 2) * width + linearX + 1) + 2] * 4 +

                    dev_input[3 * ((linearY + 1) * width + linearX - 2) + 2] * 4 +
                    dev_input[3 * ((linearY + 1) * width + linearX + 2) + 2] * 4 +
                    dev_input[3 * ((linearY - 1) * width + linearX - 2) + 2] * 4 +
                    dev_input[3 * ((linearY - 1) * width + linearX + 2) + 2] * 4 ) / 256;
        }
    }
    else if(cern == 2){
        if(linearY > 0 and linearY < (height - 1) and linearX > 0 and linearX < (width - 1)) {
            dev_output[3 * (linearY * width + linearX)] =
                    (dev_input[3 * (linearY * width + linearX)] +
                          dev_input[3 * (linearY * width + linearX + 1)] +
                          dev_input[3 * (linearY * width + linearX - 1)] +
                          dev_input[3 * ((linearY + 1) * width + linearX)] +
                          dev_input[3 * ((linearY - 1) * width + linearX)] +
                          dev_input[3 * ((linearY + 1) * width + linearX - 1)] +
                          dev_input[3 * ((linearY - 1) * width + linearX - 1)] +
                          dev_input[3 * ((linearY + 1) * width + linearX + 1)] +
                          dev_input[3 * ((linearY - 1) * width + linearX + 1)]) / 9;
            dev_output[3 * (linearY * width + linearX) + 1] =
                    (dev_input[3 * (linearY * width + linearX) + 1] +
                          dev_input[3 * (linearY * width + linearX + 1) + 1] +
                          dev_input[3 * (linearY * width + linearX - 1) + 1] +
                          dev_input[3 * ((linearY + 1) * width + linearX) + 1] +
                          dev_input[3 * ((linearY - 1) * width + linearX) + 1] +
                          dev_input[3 * ((linearY + 1) * width + linearX - 1) + 1] +
                          dev_input[3 * ((linearY - 1) * width + linearX - 1) + 1] +
                          dev_input[3 * ((linearY + 1) * width + linearX + 1) + 1] +
                          dev_input[3 * ((linearY - 1) * width + linearX + 1) + 1]) / 9;
            dev_output[3 * (linearY * width + linearX) + 2] =
                    (dev_input[3 * (linearY * width + linearX) + 2] +
                          dev_input[3 * (linearY * width + linearX + 1) + 2] +
                          dev_input[3 * (linearY * width + linearX - 1) + 2] +
                          dev_input[3 * ((linearY + 1) * width + linearX) + 2] +
                          dev_input[3 * ((linearY - 1) * width + linearX) + 2] +
                          dev_input[3 * ((linearY + 1) * width + linearX - 1) + 2] +
                          dev_input[3 * ((linearY - 1) * width + linearX - 1) + 2] +
                          dev_input[3 * ((linearY + 1) * width + linearX + 1) + 2] +
                          dev_input[3 * ((linearY - 1) * width + linearX + 1) + 2]) / 9;
        }
    }
    else if(cern == 3){
        if(linearY > 0 and linearY < (height - 1) and linearX > 0 and linearX < (width - 1)) {
            dev_output[3 * (linearY * width + linearX)] =
                    dev_input[3 * (linearY * width + linearX)] * 8 -
                    dev_input[3 * (linearY * width + linearX + 1)] -
                    dev_input[3 * (linearY * width + linearX - 1)] -
                    dev_input[3 * ((linearY + 1) * width + linearX)] -
                    dev_input[3 * ((linearY - 1) * width + linearX)] -
                    dev_input[3 * ((linearY + 1) * width + linearX - 1)] -
                    dev_input[3 * ((linearY - 1) * width + linearX - 1)] -
                    dev_input[3 * ((linearY + 1) * width + linearX + 1)] -
                    dev_input[3 * ((linearY - 1) * width + linearX + 1)];
            dev_output[3 * (linearY * width + linearX) + 1] =
                    dev_input[3 * (linearY * width + linearX) + 1] * 8 -
                    dev_input[3 * (linearY * width + linearX + 1) + 1] -
                    dev_input[3 * (linearY * width + linearX - 1) + 1] -
                    dev_input[3 * ((linearY + 1) * width + linearX) + 1] -
                    dev_input[3 * ((linearY - 1) * width + linearX) + 1] -
                    dev_input[3 * ((linearY + 1) * width + linearX - 1) + 1] -
                    dev_input[3 * ((linearY - 1) * width + linearX - 1) + 1] -
                    dev_input[3 * ((linearY + 1) * width + linearX + 1) + 1] -
                    dev_input[3 * ((linearY - 1) * width + linearX + 1) + 1];
            dev_output[3 * (linearY * width + linearX) + 2] =
                    dev_input[3 * (linearY * width + linearX) + 2] * 8 -
                    dev_input[3 * (linearY * width + linearX + 1) + 2] -
                    dev_input[3 * (linearY * width + linearX - 1) + 2] -
                    dev_input[3 * ((linearY + 1) * width + linearX) + 2] -
                    dev_input[3 * ((linearY - 1) * width + linearX) + 2] -
                    dev_input[3 * ((linearY + 1) * width + linearX - 1) + 2] -
                    dev_input[3 * ((linearY - 1) * width + linearX - 1) + 2] -
                    dev_input[3 * ((linearY + 1) * width + linearX + 1) + 2] -
                    dev_input[3 * ((linearY - 1) * width + linearX + 1) + 2];
        }
    }
}






void funk(const char* input_file, const char* output_file, int filtr_n){
    vector<unsigned char> in_image;
    unsigned int width, height;

    // Load the data
    unsigned error = lodepng::decode(in_image, width, height, input_file);
    float all_all = 0;
    float caunting_all = 0;
    cudaEvent_t all_start;
    cudaEvent_t all_stop;
    cudaEvent_t start_caunting;
    cudaEvent_t stop_caunting;
    cudaEventCreate(&all_start);
    cudaEventCreate(&all_stop);
    cudaEventCreate(&start_caunting);
    cudaEventCreate(&stop_caunting);


    // Prepare the data
    unsigned char* input_image = new unsigned char[(in_image.size()*3)/4];
    unsigned char* output_image = new unsigned char[(in_image.size()*3)/4];
    int where = 0;
    for(int i = 0; i < in_image.size(); ++i) {
        if((i+1) % 4 != 0) {
            input_image[where] = in_image.at(i);
            output_image[where] = 255;
            where++;
        }
    }

    cudaEventRecord(all_start);
    cudaEventSynchronize(all_start);


    unsigned char* dev_input;
    unsigned char* dev_output;
    cudaMalloc( (void**) &dev_input, width*height*3*sizeof(unsigned char));
    cudaMemcpy( dev_input, input_image, width*height*3*sizeof(unsigned char), cudaMemcpyHostToDevice );
    cudaMalloc( (void**) &dev_output, width*height*3*sizeof(unsigned char));
    cudaDeviceProp prop;
    cudaGetDeviceProperties(&prop, 0);
    int help = floor(sqrt(prop.maxThreadsPerBlock));
    if(help > height){
        help = height;
    }
    if(help > width){
        help = width;
    }  
    dim3 blockDims(help,help,1);
    dim3 gridDims(ceil(width / help), ceil(height / help), 1 );





    cudaEventRecord(start_caunting);
    cudaEventSynchronize(start_caunting);

    filtr<<<gridDims, blockDims>>>(dev_input, dev_output, width, height, filtr_n);
    cudaEventRecord(stop_caunting);
    cudaEventSynchronize(stop_caunting);
    cudaEventElapsedTime(&caunting_all, start_caunting, stop_caunting);

    cudaMemcpy(output_image, dev_output, width*height*3*sizeof(unsigned char), cudaMemcpyDeviceToHost );
    cudaFree(dev_input);
    cudaFree(dev_output);

    cudaEventRecord(all_stop);
    cudaEventSynchronize(all_stop);
    cudaEventElapsedTime(&all_all, all_start, all_stop);


    vector<unsigned char> out_image;
    for(int i = 0; i < in_image.size(); ++i) {
        out_image.push_back(output_image[i]);
        if((i+1) % 3 == 0) {
            out_image.push_back(255);
        }
    }

    error = lodepng::encode(output_file, out_image, width, height);


    cout <<"caunting: " <<caunting_all << endl;
    cout << "all time "<< all_all << endl;

    delete[] input_image;
    delete[] output_image;

}








int main(int argc, char** argv) {
    string cern = argv[1];
    string size = argv[2];
    const char* input_file;
    const char* output_file;
    // Read the arguments
    int filtr_n = 0;
    if(cern == "blur5"){
        filtr_n = 1;
    }
    else if(cern == "blur"){
        filtr_n = 2;
    }
    else if(cern == "edge_detection"){
        filtr_n = 3;
    }
    if(size == "small"){
        input_file = "1.png";
        output_file = "1_out.png";
        funk(input_file, output_file, filtr_n);
        input_file = "1.png";
        output_file = "2_out.png";
        funk(input_file, output_file, filtr_n);
        input_file = "3.png";
        output_file = "3_out.png";
        funk(input_file, output_file, filtr_n);
    }
    else{
        input_file = "big.png";
        output_file = "big_out.png";
        funk(input_file, output_file, filtr_n);
    }
    
    return 0;
}
