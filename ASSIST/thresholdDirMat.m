ADJbinary = cell(12,1);

for k = 1:12

    ADJI = zeros(105);
    
    s=k; %change this value from 1-12 (denoting individual segment)
    thresh=1/d; %change the denominator to change threshold (value between 1-2)
    
    %this procedure makes the matrix symmetric by choosing the greatest value
    
    for i = 1:105
        for j = 1:105
            if (ADJArt{s,1}(i,j)>thresh)
                ADJI(i,j)=ADJArt{s,1}(i,j);
            end
        end
    end
    ADJUT = triu(ADJI);
    ADJLT = tril(ADJI)';
    
    ADJHalf = zeros(105);
    
    for i = 1:105
        for j = 1:105
            if (ADJUT(i,j) > ADJLT(i,j))
                ADJLT(i,j)=0;
                ADJUT(i,j)=1;
            end
            if (ADJLT(i,j) > ADJUT(i,j))
                ADJUT(i,j)=0;
                ADJLT(i,j)=1;
            end
        end
    end
    
    ADJDir = ADJUT+ADJLT; %final symmetric matrix
    
    ADJbinary{k,1}=ADJDir;
end

similarity = zeros(12);

for i = 1:12
    for j=1:12
        a=find(ADJbinary{i,1}==1);
        b=find(ADJbinary{j,1}==1);
        if (length(a)<length(b))
           similarity(i,j)=length(find(ADJbinary{i,1}==1 & ADJbinary{j,1}==1))/length(a);
        else
           similarity(i,j)=length(find(ADJbinary{i,1}==1 & ADJbinary{j,1}==1))/length(b);
        end
            
    end
end

similarity(isnan(similarity))=0;
similarity(1:13:end)=0;