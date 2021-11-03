function R = Compute_The_Rotation_Matrix(a,b,c)
 a1 = cos(a)*cos(c)-sin(a)*sin(b)*sin(c);
 a2 = -cos(a)*sin(c)-sin(a)*sin(b)*sin(c);
 a3 = -sin(a)*cos(b);
 b1 = cos(b)*sin(c);
 b2 = cos(b)*cos(c);
 b3 = -sin(b);
 c1 = sin(a)*cos(c)+cos(a)*sin(b)*sin(c);
 c2 = -sin(a)*sin(c)+cos(a)*sin(b)*cos(c);
 c3 = cos(a)*cos(b);
 R = [a1,a2,a3;b1,b2,b3;c1,c2,c3];
end