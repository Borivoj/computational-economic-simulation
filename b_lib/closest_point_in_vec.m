function [ closest_point ] = closest_point_in_vec( old_val,  vec_of_vals )
    [value,index] =min(abs(vec_of_vals-old_val));
    closest_point = vec_of_vals(index);
end

