classdef ControlUnit
    
    properties
        ele1
        ele2
        floor1
        floor2
        floor3
    end
    
    methods
        function floor = getEleFloor(obj, ele_num)
            floor = obj.eles(ele_num).current_floor;
        end
        
        function [] = updateOutDisp(obj)
            obj.floor1.updateDisp(obj.ele1.getCurrentFloor(), obj.ele1.getDirection(), ...
                obj.ele2.getCurrentFloor(), obj.ele2.getDirection());
            obj.floor2.updateDisp(obj.ele1.getCurrentFloor(), obj.ele1.getDirection(), ...
                obj.ele2.getCurrentFloor(), obj.ele2.getDirection());
            obj.floor3.updateDisp(obj.ele1.getCurrentFloor(), obj.ele1.getDirection(), ...
                obj.ele2.getCurrentFloor(), obj.ele2.getDirection());
        end
        
        function [] = dispatchEle(obj, floor, direction)
            disp("called");
            if(obj.ele1.getCurrentFloor() == floor && obj.ele1.getDirection() == "Stationary")
                obj.ele1.addDesFloor(floor);
                return;
            elseif(obj.ele2.getCurrentFloor() == floor && obj.ele2.getDirection() == "Stationary")
                obj.ele2.addDesFloor(floor);
                return;
            elseif(obj.ele1.route(floor) == 1 || obj.ele2.route(floor) == 1)
                return;
            else
                obj.ele1.addDesFloor(floor);
            end
        end
    end
end

