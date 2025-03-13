function leg = helperPlotTDOAPositions(rngDiffEst,tgtPosEst,anchorPos)
%plotTDOA2DPositions Plots estimated 2D positions of devices, and hyperbola
%curves

%   Copyright 2021-2024 The MathWorks, Inc. 

% Plot device location estimate
plot(tgtPosEst(1),tgtPosEst(2),'o','LineWidth',1.5,'MarkerSize',10), hold on

% Plot hyperbola curves
plotStr = {'r--','b--','g--','c--','m--','y--'};
numColor = numel(plotStr);
numAnchorpair = length(rngDiffEst);
for anchorPairIdx = 1:numAnchorpair
    % Get hyperbolic curve for the TDOA between an anchor
    % and anchor 1
    [x, y] = get2DHyperbolicSurface( ...
        anchorPos(:,1), ...
        anchorPos(:,anchorPairIdx+1), ...
        rngDiffEst(anchorPairIdx));
    if isreal(x) && isreal(y)
        plot(x,y,plotStr{mod(anchorPairIdx-1,numColor)+1},'LineWidth',1.5)
    end
    hold on
end
leg = legend({'Device','Synchronized Nodes','Device Estimate','Hyperbola Curves'},'Location', 'NorthWest');
end

function [x, y] = get2DHyperbolicSurface(anchorRefPos,anchorPos,rngDiffEst)
%get2DHyperbolicSurface Get 2D hyperbolic surface for a given pair of anchors
%
%   [X,Y] = get2DHyperbolicSurface(ANCHORREFPOS,ANCHORPOS,RNGDIFFEST) finds
%   a 2D hyperbolic surface between two anchors, in a manner that all
%   points of the surface correspond to the same TDOA. The input
%   ANCHORREFPOS is the reference anchor postion, ANCHORPOS is another
%   anchor position, and RNGDIFFEST is the Difference of target ranges
%   between the anchor pair and the target. The output X and Y are x-y
%   coordinates of the hyperbolic surface.

% Calculate vector between two anchors
delta = anchorPos-anchorRefPos;

% Express the distance vector in polar form
[phi,r] = cart2pol(delta(1),delta(2));
rd = (r+rngDiffEst)/2;

% Compute the hyperbola parameters
a = (r/2)-rd;      % Vertex
c = r/2;           % Focus
b = sqrt(c^2-a^2); % Co-vertex
hk = (anchorRefPos + anchorPos)/2;
maxMu = 10;
step = 1e-3;
mu = -maxMu:step:maxMu;

% Get the x-y coordinates of hyperbola equation
x = (a*cosh(mu)*cos(phi) - b*sinh(mu)*sin(phi)) + hk(1);
y = (a*cosh(mu)*sin(phi) + b*sinh(mu)*cos(phi)) + hk(2);
end