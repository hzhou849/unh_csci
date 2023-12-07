// L5 - LCS.cpp : This file contains the 'main' function. Program execution begins and ends there.
// CSCI 6632 - Algorithms
// Howard Zhou
//

#include <iostream>
#include <iomanip>
#include <string>
#include <fstream>
#include "Diff.h"


void resetHexFlag() {
    std::cout << std::resetiosflags(std::ios::basefield);
}

size_t getFileBufferSize(std::string file) {
    char buf[256];
    std::ifstream ifs(file);
    ifs.read(buf, 256);
    size_t extracted = ifs.gcount();
    std::cout << "Bytes read: "<<std::dec << extracted << " last: " << std::hex << std::showbase << static_cast<uint16_t>(buf[24] & 0x00FF) << std::endl;
    ifs.close();

    resetHexFlag();
    return extracted;
}


int main() {
    std::string file = "Text1.txt";
    std::string file2 = "Text2.txt";
    std::ifstream textFile1(file);
    std::ifstream textFile2(file2);
    size_t fileSize1;
    size_t fileSize2;
    std::cout << "LCS DEmo!\n";

    resetHexFlag();

    fileSize1 =   getFileBufferSize(file);
    fileSize2 =   getFileBufferSize(file2);

    Lcs lcsObj(textFile1,fileSize1, textFile2, fileSize2);
    textFile1.close();
    textFile2.close();
