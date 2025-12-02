function y = f(t,C)
  y = 0;
  for j=1:1:length(C)
    y = C(j)+y.*t;
  end

