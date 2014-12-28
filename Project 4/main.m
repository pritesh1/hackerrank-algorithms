a = dlmread('teapot.txt')
lambda = a(1,7);

% To find the distance from the image plane
[W] = a(1,1:3);
[C] = a(1,4:6);
R = sqrt((C(1,1)-W(1,1))^2+(C(1,2)-W(1,2))^2+(C(1,3)-W(1,3))^2);

% To find the pan and tilt angles
theta = atand(-(C(1,1)-W(1,1))/(C(1,2)-W(1,2)));
alpha = acosd((C(1,3)-W(1,3))/R);

% Rotational matrix
Rt = [cos(theta) sin(theta) 0 0;-sin(theta) cos(theta) 0 0;0 0 1 0;0 0 0 1];
Ra = [1 0 0 0;0 cos(alpha) sin(alpha) 0;0 -sin(alpha) cos(alpha) 0;0 0 0 1];
Rot = multiply(Ra,Rt);

% Translation matrix
T= zero(4,4);
for i=1:4
    T(i,4)= -a(1,i) ;
    T(i,i)= 1 ;
end

% Perspective transformation
P= zero(4,4);
for i=1:4
    P(4,3)= -1/lambda;
    P(i,i)= 1 ;
end

% The world point
k= a(2,1);
V= zero(4,k);

for i=1:k
    for j=1:3
    V(j,i)= a(i+2,j) ; 
    V(4,:)=1;
    end
end

% Total transformation on the world point
H1 = multiply(T,V);
H2 = multiply(Rot,H1);
H = multiply(P,H2);

H
for l=1:a(2,1)
    x(l) = H(1,l)/H(4,l);
    y(l) = H(2,l)/H(4,l);
    x(l) = x(l)*128;
    y(l) = y(l)*128;
end
for m=1:a(2,1)
    X(m) = x(m)+128;
    Y(m) = y(m)+128;
end




% new matrix 
new= zero(2,a(2,2));
for i= 1:a(2,2);
new(1,i)= a(2+a(2,1)+i,1);
new(2,i)= a(2+a(2,1)+i,2);
end
new


figure,for i=1:a(2,2)
    line([X(1,new(1,i)),X(1,new(2,i))],[Y(1,new(1,i)),Y(1,new(2,i))])
end

%  figure,line([X(1,4),X(1,6)],[Y(1,4),Y(1,6)])+line([X(1,4),X(1,7)],[Y(1,4),Y(1,7)])+line([X(1,1),X(1,2)],[Y(1,1),Y(1,2)])+line([X(1,1),X(1,3)],[Y(1,1),Y(1,3)])+line([X(1,1),X(1,4)],[Y(1,1),Y(1,4)])+line([X(1,5),X(1,6)],[Y(1,5),Y(1,6)])+line([X(1,5),X(1,7)],[Y(1,5),Y(1,7)])+line([X(1,5),X(1,8)],[Y(1,5),Y(1,8)])+line([X(1,2),X(1,7)],[Y(1,2),Y(1,7)])+line([X(1,2),X(1,8)],[Y(1,2),Y(1,8)])+line([X(1,3),X(1,6)],[Y(1,3),Y(1,6)])+line([X(1,3),X(1,8)],[Y(1,3),Y(1,8)])

% figure,line([X(1,4),X(1,6)],[Y(1,4),Y(1,6)])