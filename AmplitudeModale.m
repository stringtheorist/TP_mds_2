
function [an, bn] = AmplitudeModale(H, L, el, n, kn)
    an = 2 * H ./ (n * pi) .* (L / (L - el)) .* sin(kn * el) ./ (kn * el);
    bn = zeros(size(n));
end
