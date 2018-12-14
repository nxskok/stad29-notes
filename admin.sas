options ls=70;

data admin;
    infile "admin.dat";
    input x @@;
    y=(x<8); /* for sign test */

proc rank;
    var x;
    ranks rx;

proc print;

proc ttest H0=6;
    var rx;

proc ttest H0=8;
    var x;

    
