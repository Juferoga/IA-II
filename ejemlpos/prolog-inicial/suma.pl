sucesor(1,2).
sucesor(2,3).
sucesor(3,4).
sucesor(4,5).
sucesor(5,6).
sucesor(6,7).
sucesor(7,8).
sucesor(8,9).
sucesor(9,0).
sucesor(0,1).
suma(1,X,Y):- sucesor(X,Y).
suma(N,X,Y):- sucesor(M,N),suma(M,X,R),sucesor(R,Y).
