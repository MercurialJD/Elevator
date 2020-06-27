classdef unitTestOutsidePanel < matlab.unittest.TestCase
    methods (Test)
        function testOutsidePanel(testCase) % T1.1
            % State: No InsidePanel yet
            % Input: New InsidePanel
            % Expected Output: Initial value of panel
            ele1_floor = 1;
            ele1_dir = "Stationary";
            ele2_floor = 1;
            ele2_dir = "Stationary";
            % Execute the function
            OP = OutsidePanel;
            % Check expected output
            testCase.verifyEqual(1,OP.ele1_floor);
            testCase.verifyEqual("Stationary",OP.ele1_dir);
            testCase.verifyEqual(1,OP.ele2_floor);
            testCase.verifyEqual("Stationary",OP.ele2_dir);
        end
        
        function testupdateDisp(testCase)
            % Classes
            ele1 = Elevator1;
            ele2 = Elevator2;
            flr1 = Floor1;
            flr2 = Floor2;
            flr3 = Floor3;
            controller = ControlUnit;

            % Apps
            ele1_app = elevator1;
            ele2_app = elevator2;
            ele1_mod = ele1_model;
            ele2_mod = ele2_model;
            flr1_app = floor1;
            flr2_app = floor2;
            flr3_app = floor3;

            % Setups for controller
            controller.ele1 = ele1;
            controller.ele2 = ele2;
            controller.floor1 = flr1;
            controller.floor2 = flr2;
            controller.floor3 = flr3;

            % Setups for ele1
            ele1.app = ele1_app;
            ele1.controller = controller;
            % Setups for ele1_app
            ele1_app.inside_panel = ele1;
            ele1.model = ele1_mod;

            % Setups for ele2
            ele2.app = ele2_app;
            ele2.controller = controller;
            % Setups for ele2_app
            ele2_app.inside_panel = ele2;
            ele2.model = ele2_mod;

            % Setups for flr1
            flr1.app = flr1_app;
            flr1.controller = controller;
            % Setups for flr1_app
            flr1_app.outside_panel = flr1;

            % Setups for flr2
            flr2.app = flr2_app;
            flr2.controller = controller;
            % Setups for flr2_app
            flr2_app.outside_panel = flr2;

            % Setups for flr3
            flr3.app = flr3_app;
            flr3.controller = controller;
            % Setups for flr3_app
            flr3_app.outside_panel = flr3;

            ele1_flr = 1;
            ele2_flr = 2;
            ele1_dir = "Up";
            ele2_dir = "Up";
            
            Ele1FloorValue=mat2str(ele1_flr);
            Ele2FloorValue = mat2str(ele2_flr);
            Ele1DirValue = ele1_dir;
            Ele2DirValue = ele2_dir;
            
            flr1.updateDisp(ele1_flr, ele1_dir, ele2_flr, ele2_dir);
            
            testCase.verifyEqual(flr1.app.Ele1Floor.Value,cellstr('1'));
            testCase.verifyEqual(flr1.app.Ele2Floor.Value,cellstr('2'));
            testCase.verifyEqual(flr1.app.Ele1Dir.Value,cellstr(Ele1DirValue));
            testCase.verifyEqual(flr1.app.Ele2Dir.Value,cellstr(Ele2DirValue));
            
            close(ele1_app.UIFigure);
            close(ele2_app.UIFigure);
            close(ele1_mod.UIFigure);
            close(ele2_mod.UIFigure);
            close(flr1_app.UIFigure);
            close(flr2_app.UIFigure);
            close(flr3_app.UIFigure);
            
        end
        
        
       
        
    end
    
    
end