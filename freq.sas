data myfreq;
  infile "freq.dat";
  do profession="politician   ","administrator","bellydancer";
    do sex="male  ","female";
      do readtype="scifi","spy";
        input freq @@;
        output;
      end;
    end;
  end;

proc print;

proc catmod;
  weight freq;
  model profession*sex*readtype=_response_;
  loglin profession sex readtype profession*sex;

