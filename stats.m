img = imread('mdb008.pgm');
p = imhist(img);
p_norm = p./(1024*1024);

mean = 0;
for z=1:256
    mean = mean + (z-1)*p_norm(z);
end
mean

var = 0;
for z=1:256
    var = var + ( ( (z-1) - mean)^2 ) * p_norm(z);
end
std = sqrt(var);
std

R = 1 - (1/(1+ std^2 ));
R

skew = 0;
for z=1:256
    skew = skew + ( ( ( (z-1) - mean)^3 ) * p_norm(z) );
end
skew

U = 0;
for z=1:256
    U = U + (p_norm(z)^2);
end
U

E = entropy(img);
E

% skew = 0
% for i=1:1024
%     for j=1:1024
%         skew = skew + ( img(i,j) -  )

% q = img(:);
% skew = sum((q-mean).^3)/(1024*1024* std^3)
