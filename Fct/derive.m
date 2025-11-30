function Du=derive(Y,an,bn,wn,t)
  T1 = (bn+i*an)*exp(i*xn*t);
  Du=Y'*T1;
