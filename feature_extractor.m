
files = dir('*.pgm');

for file = files'
    img = imread(file.name);
    p = imhist(img);
    p_norm = p./(1024*1024);

    mean = 0;
    for z=1:256
        mean = mean + (z-1)*p_norm(z);
    end

    var = 0;
    for z=1:256
        var = var + ( ( (z-1) - mean)^2 ) * p_norm(z);
    end
    std = sqrt(var);

    R = 1 - (1/(1+ std^2 ));

    skew = 0;
    for z=1:256
        skew = skew + ( ( ( (z-1) - mean)^3 ) * p_norm(z) );
    end

    U = 0;
    for z=1:256
        U = U + (p_norm(z)^2);
    end

    E = entropy(img);
    
    feature_vec = [mean std R skew U E];
    
    fid = fopen('features_preproc.txt','a');
    fprintf(fid,'%f ',feature_vec);
    fprintf(fid,'\n');
    fclose(fid);
end
