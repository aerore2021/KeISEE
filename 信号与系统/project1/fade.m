function [ y ] = fade(x, level)
%
% fade(X): this function fades the audio vector X.
%
% fade(X, LEVEL): fades the audio vector X from 100% down to LEVEL.  
%                 fade(X) = fade(X, 0).
%                 LEVEL must be >= 0 and <= 1 
%                 otherwise LEVEL will be 0 by default
%
% Examples:  
% Y = fade(X);
% Y = face(X, LEVEL); 

% create the ramp vector
switch(nargin)
    case 2
        if(level<=1&&level>=0)
            t = linspace(1, level, length(x));
        else
            t = linspace(1,0,length(x));
        end
    case 1
        t = linspace(1, 0, length(x));
end
% multiply the audio vector with the ramp vector to fade
y = t .* x;


% written by: 3210104064 Huang Qibin
% 2023/4/29
