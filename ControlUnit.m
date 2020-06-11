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
            switch ele_num
                case 1
                    floor = obj.ele1.getCurrentFloor();
                case 2
                    floor = obj.ele2.getCurrentFloor();
            end
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
            % Ele1 currently stops at the floor, call ele1
            if(obj.ele1.getCurrentFloor() == floor && obj.ele1.getDirection() == "Stationary")
                obj.ele1.addDesFloor(floor);
                return;
            % Ele2 currently stops at floor, call ele2
            elseif(obj.ele2.getCurrentFloor() == floor && obj.ele2.getDirection() == "Stationary")
                obj.ele2.addDesFloor(floor);
                return;
            % Already in (at least) one ele's route, do nothing, just wait
            % for the ele to arrive
            elseif(obj.ele1.route(floor) == 1 || obj.ele2.route(floor) == 1)
                return;
            % ele1 is under the floor and it was going up, call ele1
            elseif(obj.ele1.getCurrentFloor() < floor && obj.ele1.getPreDirection() == "Up")
                obj.ele1.addDesFloor(floor);
                return;
            % ele2 is under the floor and it was going up, call ele2
            elseif(obj.ele2.getCurrentFloor() < floor && obj.ele2.getPreDirection() == "Up")
                obj.ele2.addDesFloor(floor);
                return;
            % ele1 is over the floor and it was going down, call ele1
            elseif(obj.ele1.getCurrentFloor() > floor && obj.ele1.getPreDirection() == "Down")
                obj.ele1.addDesFloor(floor);
                return;
            % ele2 is over the floor and it was going down, call ele2
            elseif(obj.ele2.getCurrentFloor() > floor && obj.ele2.getPreDirection() == "Down")
                obj.ele2.addDesFloor(floor);
                return;
            % choose the closer one 
            elseif((abs(obj.ele2.getCurrentFloor()-floor)<abs(obj.ele1.getCurrentFloor()-floor)) &&...
                   (obj.ele2.getPreDirection()~=direction))
                obj.ele2.addDesFloor(floor);
                return;
            else
                obj.ele1.addDesFloor(floor);
            end
        end
    end
end

