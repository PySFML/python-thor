from copy import copy
from sfml import sf
from thor import th

polar_vector = th.PolarVector2(5, 36)
print(polar_vector.r)   # display 5
print(polar_vector.phi) # display 36

# you can copy polar vectors
copy_polar_vector = copy(polar_vector)

# ... and unpack them
r, phi = copy_polar_vector

## you can transform them into sf.Vector2 this way
#vector2_version = polar_vector.to_vector2()
#vector2_version_bis = th.PolarVector2.to_vector2(polar_vector)


#print(th.length(sf.Vector2(3, 5)))



polar_vector = th.PolarVector2(1, 2)
vector2 = sf.Vector2(1, 2)
vector3 = sf.Vector3(1, 2, 3)


# test length()
print(th.length(polar_vector))
print(th.length(vector2))
print(th.length(vector3))

# test squared_length()
print(th.squared_length(vector2))
print(th.squared_length(vector3))

# test set_length()
print(vector2)
th.set_length(vector2, 50)
print(vector2)

## test unit_vector()
#print(th.unit_vector(vector2)) # FAIL
#print(th.unit_vector(vector3)) # FAIL

# test polar_angle()
print(th.polar_angle(polar_vector))
print(th.polar_angle(vector2))
print(th.polar_angle(vector3))

# test set_polar_angle()
th.set_polar_angle(vector2, 50)
print(vector2)

# test rotate()
th.rotate(vector2, 35)
print(vector2)

## test rotated_vector()
#print(th.rotated_vector(vector2, 35)) # FAIL

## test perpendicular_vector()
#print(th.perpendicular_vector(vector2)) # FAIL

# test signed_angle()
print(th.signed_angle(sf.Vector2(1, 2), sf.Vector2(3, 4)))

# test dot_product()
print(th.dot_product(sf.Vector2(1, 2), sf.Vector2(3, 4)))
print(th.dot_product(sf.Vector3(1, 2, 3), sf.Vector3(4, 5, 6)))

# test cross_product()
print(th.cross_product(sf.Vector2(1, 2), sf.Vector2(3, 4)))
#print(th.cross_product(sf.Vector3(1, 2, 3), sf.Vector3(4, 5, 6))) # FAIL

## test cwise_product()
#print(th.cwise_product(sf.Vector2(1, 2), sf.Vector2(3, 4))) # FAIL
#print(th.cwise_product(sf.Vector3(1, 2, 3), sf.Vector3(4, 5, 6))) # FAIL

## test cwise_quotient()
#print(th.cwise_quotient(sf.Vector2(1, 2), sf.Vector2(3, 4))) # FAIL
#print(th.cwise_quotient(sf.Vector3(1, 2, 3), sf.Vector3(4, 5, 6))) # FAIL

## test projected_vector()
#print(th.projected_vector(sf.Vector2(1, 2), sf.Vector2(3, 4)))

# test elevation_angle()
print(th.elevation_angle(vector3))

# test to_vector3()
#print(th.to_vector3(vector2)) # FAIL

