# Python program for Kruskal's minimum spanning tree
# Undirected and weighted graph

# Class to represent a graph
class Graph:
    # Constructor
    def __init__  (self, vertices):
        self.Vertices = vertices
        self.graph = []

    # Function to add edge to graph
    def addEdge(self, u, v, weight):
        self.graph.append( [u,v,weight] )

    # Utility function to find set of an element i
    # (truly uses path compression technique
    '''
    Path compression - While finding nodes, it is efficient to move all nodes along the path
    of the query node to the parent, trickling up to tie directly to root
    If parent[i] = i; then it is a parent. 
    '''
    def find(self, parent, i):
        print("Find parent={}; i:{}, parent[{}]={}".format(parent, i, i, parent[i]))
        if parent[i] != i:
            # Reassignment of node's parent to root node as path compression requires
            parent[i] = self.find(parent, parent[i])
        return parent[i]

    def union(self, parent, rank, x, y):
        """
        A function that does union of two sets x and y (by rank)
        by attaching smaller rank tree under root of higher rank tree
        If parent ranks are same, then make one as root and increment its rank by one
        """
        print("Before - parent:{}, rank:{}, x:{}, y{} | parent[{}]={}, parent[{}]={}, rank[{}]={}, rank[{}]={}".format(parent, rank, x, y,x, parent[x], y, parent[y], x, rank[x], y, rank[y]))
        if rank[x] < rank[y]:
            parent[x] = y
        elif rank[x] > rank[y]:
            parent[y] = x
        else:
            parent[y] = x
            rank[x] += 1
        print("After - parent:{}, rank:{}, x:{}, y{} | parent[{}]={}, parent[{}]={}, rank[{}]={}, rank[{}]={}".format(parent, rank, x, y,x, parent[x], y, parent[y], x, rank[x], y, rank[y]))
        # print("Before - parent:{}, rank:{}, x:{}, y{} | parent[x]={}, parent[y]={}, rank[x]={}, rank[y]={}".format(parent, rank, x, y. parent[x], parent[y], rank[x], rank[y]))

    def KruskalMST(self):
        """
        Kruskal algorithm to construct the Minimal spanning tree
        This is done by creating a parents[] and rank(depth)[] trees
        parents trees are disjoint sets of each vertex, once they are joined, they will
        be combined into the same binary tree and the rank is updated for the parent,
        the number of heirarchy depths that node has.
        Later when checking an edge, if those vertices are in the same vertex tree, that
        means a cycle will occur if that edge will be added -therefore we will discard it.
        ie. vertex tree 2:{2-childre:0, 2, 3} another set (1)
        since set (1) is disjoint, if we want to added edge 0-1 = safe
        if we try to add edge 0,2 = NO! because already part of tree (2) and will result in cycle
        """
        result = []     # Store the resulting tree
        index = 0       # Index for sorted edges
        e = 0           # index for result[]

        # Sort all the edges in non-decreasing order of their weight
        self.graph = sorted(self.graph, key = lambda item: item[2])

        parent = []
        rank = []

        # Create Vertices subsets with single elements

        for node in range(self.Vertices):
            parent.append(node)
            rank.append(0)


        # Number of edges to be taken is less than total Vertices-1
        while e < self.Vertices -1:

            # Pick the smallest edge and increment the index for next iteration
            u, v, weight = self.graph[index]
            index += 1
            x = self.find(parent, u)
            y = self.find(parent, v)

            # If this edge picked doesn't cause a cycle to occur, then include
            # it in the result and increment the index of result for the next edge
            # Else, discard it. If x and y are the same parent, then cycle exist
            if x != y:
                e +=1
                result.append( [u, v, weight] )
                self.union(parent, rank, x, y)
            # Else discard it

        minCost = 0
        print("Edges in the constructed MST: ")
        for u, v, w in result:
            minCost += w
            print("u:{}, v:{}, weight:{} ".format(u,v,w) )
        print ("Minimum Spanning Tree cost: " +  str(minCost))


'''
Driver Code
'''
if __name__=='__main__':
    g = Graph(4)
    g.addEdge(0, 1, 10)
    g.addEdge(0, 2, 6)
    g.addEdge(0, 3, 5)
    g.addEdge(1, 3, 15)
    g.addEdge(2, 3, 4)
    g.KruskalMST()




