classdef OutsidePanel < handle
    
    properties
        app
        controller
        ele1_floor
        ele1_dir
        ele2_floor
        ele2_dir
    end
    
    methods
        function obj = OutsidePanel()
            obj.ele1_floor = 1;
            obj.ele1_dir = "Stationary";
            obj.ele2_floor = 1;
            obj.ele2_dir = "Stationary";
        end
        
        function [] = updateDisp(obj, ele1_flr, ele1_dir, ele2_flr, ele2_dir)
            obj.app.Ele1Floor.Value = mat2str(ele1_flr);
            obj.app.Ele2Floor.Value = mat2str(ele2_flr);
            obj.app.Ele1Dir.Value = ele1_dir;
            obj.app.Ele2Dir.Value = ele2_dir;
        end
        
        function [] = callEle(obj, floor, direction)
            obj.controller.dispatchEle(floor, direction);
        end
    end
end

