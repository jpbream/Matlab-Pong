classdef Paddle
    properties
        Position
        Size
    end

    methods
        function obj = Paddle(x, y, w, h)
            obj.Position = [x, y];
            obj.Size = [w, h];
        end

        % Return 1 for horizontal collision, -1 for vertical
        % collision, 0 for no collision
        function collision = IntersectBall(obj, ball)
       
            topRight = [obj.Position(1) + obj.Size(1), obj.Position(2)];
            bottomRight = [obj.Position(1) + obj.Size(1), obj.Position(2) ...
                + obj.Size(2)];
            topLeft = [obj.Position(1), obj.Position(2)];
            bottomLeft = [obj.Position(1), obj.Position(2) + obj.Size(2)];

            rightEdge = Paddle.IntersectLine(topRight, bottomRight, ball);
            leftEdge = Paddle.IntersectLine(topLeft, bottomLeft, ball);
            topEdge = Paddle.IntersectLine(topLeft, topRight, ball);
            bottomEdge = Paddle.IntersectLine(bottomLeft, bottomRight, ball);

            if (rightEdge || leftEdge)
                collision = 1;
            elseif (topEdge || bottomEdge)
                collision = -1;
            else
                collision = 0;
            end
        end
    end
    methods (Static)
        function collision = IntersectLine(start, stop, ball)
            lineVector = stop - start;
            lineLen = norm(lineVector);
            lineVector = lineVector / lineLen;

            ballVector = ball.Position - start;
            horizontalDistance = dot(ballVector, lineVector);

            if (horizontalDistance < 0 || ...
                    horizontalDistance > lineLen)
                collision = false;
                return;
            end

            projectionPoint = start + lineVector * horizontalDistance;
            distanceToLine = norm(projectionPoint - ball.Position);

            collision = distanceToLine < ball.Radius;
        end
    end
end