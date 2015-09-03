function math.clamp (n, low, high)
  return math.min(math.max(low, n), high)
end

function math.lerp (a, b, t)
  return (1 - t) * a + t * b
end

function math.distance (x1, y1, x2, y2)
  return ((x2-x1)^2+(y2-y1)^2)^0.5
end
