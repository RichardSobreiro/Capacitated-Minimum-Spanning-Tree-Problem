import json
import sys
import os
import networkx as nx
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

def plotGraph(mstGraph, numberOfNodes, title, subtitle):
    G = nx.Graph()
    i = 0
    while i < numberOfNodes:
        j = 0
        while j < numberOfNodes:
            if mstGraph[i][j] > 0:
                edge = ([(i + 1), (j + 1)])
                G.add_edge(*edge)
            j += 1
        i += 1
    nx.draw_networkx(G)
    plt.title(title)
    plt.gcf().text(x=0,y=0.4,s=subtitle)
    plt.show()

def main(argv):
    numberOfNodes = 11
    title = 'Obj=212'
    subtitle = ''

    nodesJson = 0
    with open('C:\Trabalho3\Result.json') as data_file:    
        nodesJson = json.load(data_file)
    
    df = pd.DataFrame(nodesJson['nodes'])

    cmst = np.zeros((numberOfNodes, numberOfNodes))

    i = 0
    for index, row in df.iterrows():
        #if i%4 == 0:
        subtitle += '|x[' +  str(int(row['i'])) + '][' + str(int(row['j'])) + ']=' + str(row['xij']) + '|\n'
        #else:
            #subtitle += '|x[' +  str(int(row['i'])) + '][' + str(int(row['j'])) + ']=' + str(row['xij']) + '|'
        cmst[(int(row['i'])-1), (int(row['j'])-1)] = 1
        i += 1

    plotGraph(cmst, numberOfNodes, title, subtitle)

if __name__ == '__main__':
    main(sys.argv[1:])