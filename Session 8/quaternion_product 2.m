function w = quaternion_product(varargin)

w = varargin(1);

for 1=2:nargin
    % Multiply with next quaternion in the list
    scalar_part = w(1)*varargin();
    vector_part = ;

    % Update
    w(1) = scalar_part;
    w(2:4) = vector_psrt;
end

end