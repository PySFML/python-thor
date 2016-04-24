from sfml import sf
from thor import th

try:
    bigtexture = th.BigTexture()
except UserWarning:
    print("Failed to use default constructor")

print("Construct from file")
bigtexture = th.BigTexture.from_file("image.jpg")

print("Construct from bytes")
data = open("image.jpg", "rb").read()
bigtexture = th.BigTexture.from_memory(data)

print("Construct from image")
image = sf.Image.from_file("image.jpg")
bigtexture_2 = th.BigTexture.from_image(image)

print(bigtexture.smooth)
bigtexture.smooth = not bigtexture.smooth
print(bigtexture.smooth)
print(bigtexture.size)

print("Create sprite")
bigsprite = th.BigSprite(bigtexture)

print(bigsprite.texture)
bigsprite.texture = bigtexture_2
print(bigsprite.texture)

print(bigsprite.color)
bigsprite.color = sf.Color.RED
print(bigsprite.color)

print(bigsprite.local_bounds)
print(bigsprite.global_bounds)

window = sf.RenderWindow(sf.VideoMode(640, 480), "")

window.clear()
window.draw(bigsprite)
window.display()

input("Press enter to continue the testing")

color_gradient = th.ColorGradient()
color_gradient[0] = sf.Color.YELLOW
color_gradient[1] = sf.Color.RED
print(color_gradient.sample_color(0.1))
print(color_gradient.sample_color(0.5))
print(color_gradient.sample_color(0.9))
print(color_gradient.sample_color(1.1))

print(th.blend_colors(sf.Color.YELLOW, sf.Color.RED, 0.5))
