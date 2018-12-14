data xyz;
    do y=-2 to 2 by 0.1;
        do x=-0.5 to 3 by 0.1;
            z=(1-y)**2+100*(x-y**2)**2;
            output;
            end;
        end;
    
proc print;

proc g3d;
    plot y*x=z;

proc gcontour;
    plot y*x=z / autolabel levels=0, 20, 50, 100, 200, 400, 800;


run;

