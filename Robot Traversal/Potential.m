classdef Potential < handle
    %Class that handles the symbolic functions for the potential field.
    properties
        x, y,
        u, v, field, dfdu, dfdv
        attractor, repulsor, goal,
        num_goals = 0;
    end
    methods
        function obj = Potential(X, Y)
            % Constructor
            %   Initializes a potential field of the size X by Y
            %   and defines the function calls to create attractors,
            %   repulsors, and goals.
            if nargin > 0
                step = 2;
                [obj.y, obj.x] = meshgrid(0:step:Y, 0:step:X);
                u = sym('u'); v = sym('v'); field(u, v) = u*0;
                obj.u = u; obj.v = v; obj.field = field;
                gauss = @(width) (1/(det(width)*2*pi))*exp(-(1/2)...,
                                    .* [0; 0]'*pinv(width)...,
                                    *[0; 0]);
                obj.attractor = @(loc, width) -(1/(det(width)*2*pi))*exp(-(1/2)...,
                                    .* [(obj.u-loc(1)); (obj.v-loc(2))]'*pinv(width)...,
                                    *[(obj.u-loc(1)); (obj.v-loc(2))])/gauss(width);
                obj.repulsor = @(loc, width, u, v) (1/(det(width)*2*pi))*exp(-(1/2)...,
                                    .* [(obj.u-loc(1)); (obj.v-loc(2))]'*pinv(width)...,
                                    *[(obj.u-loc(1)); (obj.v-loc(2))])/gauss(width);
                obj.goal = @(loc) (((loc(1)-obj.u).^2 + (loc(2)-obj.v).^2)/(X*Y));
            end
        end
        function obj = addAttractor(obj, loc, intensity, width)
            % Parameters:
            %   loc: Location to center the attractor
            %   intensity (optional): how strong the attractor is
            %   width (optional): the width in the x direction and y directio.
            %       If only one width is input, then it is symmetrical.
            switch nargin
                case 2
                    intensity = 1;
                    width = 100;
                case 3
                    width = 100;
                otherwise
                    assert(numel(width)<=2);
                    if numel(width) == 1
                        width = [width, 0; 0, width];
                    elseif numel(width) == 2
                        width = [width(1), 0; 0, width(2)];
                    end
            end
            obj.field = obj.field + intensity*obj.attractor(loc, width);
        end
        function obj = addRepulsor(obj, loc, intensity, width)
            % Parameters:
            %   loc: Location to center the repulsor
            %   intensity (optional): how strong the attractor is
            %   width (optional): the width in the x direction and y direction.
            %       If only one width is input, then it is symmetrical.
            switch nargin
                case 2
                    intensity = 1;
                    width = 100;
                case 3
                    width = 100;
                otherwise
                    assert(numel(width)<=2);
                    if numel(width) == 1
                        width = [width, 0; 0, width];
                    elseif numel(width) == 2
                        width = [width(1), 0; 0, width(2)];
                    end
            end
            obj.field = obj.field + intensity*obj.repulsor(loc, width);
        end
        function obj = addGoal(obj, loc)
            % Parameters:
            %   loc: Location of the goal
            assert(obj.num_goals == 0, 'Too many goals specified. Only one allowed. Try adding attractor');
            obj.num_goals = 1;
            obj.field = obj.field + obj.goal(loc);
        end
        function dx = getdx(obj)
            dx = matlabFunction(diff(obj.field, obj.u));
        end
        function dy = getdy(obj)
            dy = matlabFunction(diff(obj.field, obj.v));
        end
        function field = getField(obj)
            assert(obj.num_goals == 1, 'You must have a single goal');
            field = matlabFunction(obj.field);
        end
    end
end
