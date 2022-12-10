function [intersect] = lin_intersect_with_zero(p1,p2)
    %p1 = [5 4];
    %p2 = [3 7];

    a = (p2(2) - p1(2))/(p2(1) - p1(1));
    b = p1(2) - a*p1(1);

    intersect = -(b/a);
end