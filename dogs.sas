options linesize=75;

   data dogs; 
      infile "dogs.dat";
      input Drug $ Depleted $ Histamine0 Histamine1 
            Histamine3 Histamine5; 
      LogHistamine0=log(Histamine0); 
      LogHistamine1=log(Histamine1); 
      LogHistamine3=log(Histamine3); 
      LogHistamine5=log(Histamine5); 

   proc glm; 
      class Drug Depleted; 
      model LogHistamine0--LogHistamine5 = 
            Drug Depleted Drug*Depleted / nouni; 
      repeated Time 4 (0 1 3 5); 
