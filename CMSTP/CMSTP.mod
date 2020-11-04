int n = ...;
int Q = ...;

range N = 1..n;
range V = 1..n;

int S = 2;

float c[N][N] = ...;

dvar boolean x[N][N];

minimize sum(i in N, j in N: i != 1 && i != j)(x[i][j] * c[i][j]);

subject to {
	r0:
	sum(i in V, j in V: i != 1 && j != i)(x[i][j]) == 10;	
	r1:
	forall(i in V: i != 1){
		sum(j in V: j != i)(x[i][j]) == 1;	
	}
	r2:
	forall(i in V, j in V: i != 1 && j != 1 && i != j){
		x[i][j] + x[j][i] <= 1;	
	}
	Iteracao2_Packing:
	x[2][9] + x[3][5] + x[5][9] + x[9][11] + x[11][2] <= 3;
	Iteracao3_Packing:
	x[2][11] + x[3][5] + x[5][9] + x[9][2] + x[11][9] <= 3;
	Iteracao4_Packing:
	//3 - 3/3 = 2
	x[4][6] + x[6][8] + x[8][4] <= 2;
	Iteracao5_Packing:
	//3 - 3/3 = 2
	x[4][8] + x[6][4] + x[8][6] <= 2;
	Iteracao6_Packing:
	//9-9/3  
	//x[2][9] + x[2][11] + x[3][5] + x[3][11] + x[9][2] + x[9][11] + x[11][2] + x[11][9] + x[5][9] <= 6;
	Iteracao7_Packing:
	// 5-5/3=3
	x[2][5] + x[3][5] + x[5][9] + x[9][2] + x[11][2] <= 3; 
	
	forall(i in V, j in V){
		x[i][j] >= 0;	
	}
}

tuple Node 
{
	float xij;
	int i;
	int j;
};

sorted {Node} Nodes = {};

execute {

	for(var i in V) 
	{
		for(var j in V)
		{
			if(x[i][j] > 0)
			{
				Nodes.add(x[i][j], i, j);						
			}				
		}			
	}

	var f = new IloOplOutputFile("C:\\Trabalho3\\Result.json");
	f.writeln("{");
	f.writeln("	\"nodes\": [");
	var i = 1;
	for(var node in Nodes){
		f.writeln("	{");
		f.writeln("		\"xij\": ", node.xij, ",");
		f.writeln("		\"i\": ", node.i, ",");
		f.writeln("		\"j\": ", node.j, "");
		if ((i+1) == n) {
			f.writeln("	}");				
		}
		else{
			f.writeln("	},");	
		}
		i = i + 1;
	}
	f.writeln("]");
	f.writeln("}");	
	f.close();
}