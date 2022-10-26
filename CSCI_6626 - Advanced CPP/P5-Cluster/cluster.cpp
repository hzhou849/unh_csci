#include "cluster.hpp"
// // Implementation


Cluster::Cluster( ClusterT cType, Square* arrPtr[]) 
    : cType_m(clist[static_cast<int>(cType)])           // As per instructions to take in ClusterT to char*
    {

        
        arrPt_m = new Square[9];

        for (int i=0; i < 9; i++) {
            arrPt_m[i] = *arrPtr[i];
            cout << cType_m<<": "<< i << ") " << *arrPtr[i]  << endl;
        }


}

ostream& Cluster::print(ostream& os) {
    os << "Cluster print: "<< cType_m << "; " << endl;
        for (int i=0; i<9; ++i) {
            os << (arrPt_m[i])  << "+" << endl;
        }
        
        return os;
    
}
