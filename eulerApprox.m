function [] = eulerApprox()
close all;
    global gui;
    gui.graph = figure();
    hold on;
    gui.plot = plot((0:.001:3),exp(0:.001:3),'r');
    gui.plot.Parent.Position = [.05 0.25 .9 0.7];
    %This establishes the initial graph of e^x and also adds the plot to
    %the gui interface.
    
    gui.btn = uicontrol('style','pushbutton','units','normalized','position',[.75 .07 .2 .1],'string','Step Size','callback',{@learnEuler});   
    %Creates a button that calls the learnEuler function
    
    gui.scrollBar = uicontrol('style','slider','units','normalized','position',[0.3 0.1 .4 0.05],'value',1,'min',1,'max',5,'sliderstep',[1/4 1/4],'callback',{@scrollBar});
    %Creates an interactive scroll bar that shows the five different graphs
    
    gui.animateButton = uicontrol('style','pushbutton','units','normalized','position',[0.05 0.07 0.2 0.1],'string','Play Animation','callback',{@animate});
    %Calls the function animate, which goes through the different graphs
    %automatically
    
end

function [] = learnEuler(~,~)
    msgbox("The step size of the graph is an approximation for an Ordinary Differential Equation. As the step size decreases, the approximation becomes closer and closer to the solution to the ODE. Every ODE requires an initial condition, and this ODE's initial condition is y(0) = 1. As the animation progresses, you can see the functions get closer and closer to the actual graph. The actual graph is e^x which is the solution to the differential equation dy/dx = y. The command window will display the step size of Euler's method as the animation progresses. (Note the step size is only displayed if the animate button is pressed).",'What is the step size?');
end

function [] = animate(~,~)
    global gui;
    for i = 1:5
        gui.scrollBar.Value = i;
        scrollBar();
        pause(3);
        %This for loop runs through each iteration of the scroll bar
    end
end

function [] = scrollBar(~,~)
    global gui;
    gui.scrollBar.Value = round(gui.scrollBar.Value);
    plotData(gui.scrollBar.Value)
    %Calls the plotData function every time the bar scrolls.
        if gui.scrollBar.Value == 1
            disp('Step size: 1')
        elseif gui.scrollBar.Value == 2
            disp('Step size: .5')
        elseif gui.scrollBar.Value == 3
            disp('Step size: .25')
        elseif gui.scrollBar.Value == 4
            disp('Step size: .1')
        elseif gui.scrollBar.Value == 5
            disp('Step size: .01')
        end
        %These if-statements are intended to notify the user of the step
        %size of the approximation when the scroll bar moves, both manually
        %and automatically.
end

function [] = plotData(scroll)
    global gui;
    data = readmatrix('eulerData.csv');
    %This line reads the eulerData.csv file, which contains calculated
    %numbers from Euler's Method.
    if scroll == 1
        xVals = (0:1:3);
        yVals = data(1:4,1);
        gui.plot = plot(xVals,yVals,'b',(0:.001:3),exp(0:.001:3),'r');
        hold off;
        %The second plot is the red line showing the actual equation and
        %this is shown for each graph to display the approximation coming
        %closer to the real function.
    elseif scroll == 2
        xVals = (0:(3/8):3);
        yVals = [1 (data(1:8,2))'];
        gui.plot = plot(xVals,yVals,'b',(0:.001:3),exp(0:.001:3),'r'); 
        hold off;
        %hold off; clears the blue graph every time the bar scrolls.
    elseif scroll == 3
        xVals = (0:(3/14):3);
        yVals = [1 (data(1:14,3))'];
        gui.plot = plot(xVals,yVals,'b',(0:.001:3),exp(0:.001:3),'r');
        hold off;
    elseif scroll == 4
        xVals = (0:(3/32):3);
        yVals = [1 (data(1:32,4))'];
        gui.plot = plot(xVals,yVals,'b',(0:.001:3),exp(0:.001:3),'r'); 
        hold off;
    elseif scroll == 5
        xVals = (0:(3/62):3);
        yVals = [1 (data(1:62,5))'];
        gui.plot = plot(xVals,yVals,'b',(0:.001:3),exp(0:.001:3),'r'); 
        hold off;
        %These if-statements are run to graph each iteration of
        %Euler's Method.
    end
end