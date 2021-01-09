%Aula AI Pratica
%12/11/2020
%Trabalho Prático: Métodos de Pesquisa

%Parte I - SA
clear
close all

qualityf = @(x,y) 3*(1-x).^2.*exp(-(x.^2)-(y+1).^2) ...
    - 10*(x/5-x.^3-y.^5).*exp(-x.^2-y.^2)...
    -1/3*exp(-(x+1).^2-y.^2);

quality2 = @(x,y) -20*exp(-0.2*(sqrt(0.5*(x.^2+y.^2))))-exp(0.5*(cos(2*pi*x)+cos(2*pi*y)))+20+exp(1);
 
quality1 = @(x,y) -4+x.^2+y.^2;

%% Area de Pesquisa
Area = 2;
MaxArea = Area;
MinArea = -Area;
Zmin = -5;
Zmax = 25;

x1 = linspace(MinArea,MaxArea,100);
x2 = linspace(MinArea,MaxArea,100);
%Combinação de pontos entre x1 e x2
[x1,x2]= meshgrid(x1,x2);

%Calculo da qualidade de cada ponto da combinação
fx = quality(x1,x2);

%% Espaço de pesquisa
%2D
subplot(1,2,1)
%figure(1)
contour(x1,x2,fx,20);
axis([MinArea MaxArea MinArea MaxArea])
hold on
%em 3D
subplot(1,2,2)
%figure(2)
contour3(x1,x2,fx,20)
splot=surf(x1,x2,fx,'FaceAlpha',0.25);
splot.EdgeColor = 'none';
hold on


%% Ponto de partida (solucao inicial)
s0 = (rand(2,1)*2-1)*MaxArea;
%plot do ponto inicial
subplot(1,2,1)
%figure(1)
plot(s0(1),s0(2),'ko','MarkerFaceColor','g','MarkerSize',10,'LineWidth',2)
subplot(1,2,2)
%figure(2)
plot3(s0(1),s0(2),quality(s0(1),s0(2)),'ko','MarkerFaceColor','g','MarkerSize',10,'LineWidth',2);
a=quality(s0(1),s0(2));

func = @newSol;

%% Iterações
s=s0;
iter=100;
for i = 0:iter

    news = newSol(s,quality,MinArea,MaxArea);
    s = news;
end

%% Solution found
%Plot do ponto final
subplot(1,2,1)
%figure(1)
plot(s(1),s(2),'kx','MarkerFaceColor','g','MarkerSize',20,'LineWidth',2)
arrow([s0(1),s0(2)],[s(1),s(2)])
hold off
subplot(1,2,2)
%figure(2)
plot3(s(1),s(2),quality(s(1),s(2)),'kx','MarkerFaceColor','g','MarkerSize',20,'LineWidth',2)
%plot3([s0(1),s(1)],[s0(2),s(2)],[quality(s0(1),s0(2)),quality(s(1),s(2))],'--g','LineWidth',4.0)
arrow3([s0(1),s0(2),quality(s0(1),s0(2))],[s(1),s(2),quality(s(1),s(2))])
hold off

%% Funções
function sol = newSol(s,quality,MinArea,MaxArea)
%Encontrar nova solução (função a ser iterada)

new = s + (rand(2,1)*2-1)*MaxArea*0.2;
% para nao passar do maximo minimo
if new(1)>MaxArea
    new(1)=MaxArea;
elseif new(1) < MinArea
    new(1)=MinArea;
end
if new(2)>MaxArea
    new(2)=MaxArea;
elseif new(2) < MinArea
    new(2)=MinArea;
end 

%Avaliar qual o melhor ponto
newQual=quality(new(1),new(2));
sQual=quality(s(1),s(2));


if newQual < sQual
    plotpoint(new(1),new(2),newQual,'go');
    sol = new;
else
    plotpoint(new(1),new(2),newQual,'ro');
    sol = s;
    end
end


function plotpoint(point1,point2,pointQual,linespec)
    %Function to plot the new solucions in the graph
    subplot(1,2,1)
    %figure(1)
    plot(point1,point2,linespec)
    subplot(1,2,2)
    %figure(2)
    plot3(point1,point2,pointQual,linespec)
end