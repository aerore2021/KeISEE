function [out] = Compare(MFCC, A)
for i=1:8
    res(i) = sum(sum(MFCC{i,1}-A));
end
[M out] = min(res);
end