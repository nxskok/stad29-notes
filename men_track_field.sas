options linesize=70;

data track;
    infile "men_track_field.dat";
    input m100 m200 m400 m800 m1500 m5000 m10000 marathon
        country $;
    
proc princomp out=PC;
    
proc print;
    var country Prin1 Prin2;

symbol1 pointlabel=('#country');

proc gplot;
    plot Prin2*Prin1;

    
run;
