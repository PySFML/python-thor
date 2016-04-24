Graphics
========
There isn't any complete documentation or API reference for the
graphics module of pyThor yet. Everything below is just quick notes. You'll
also find numerous piece of code to understand how to use this module.

In general, features translate trivially into Python and with the absence
of a complete API reference, you should refer to the C++ documentation to
understand how this module work. Indeed, Python and C++ aren't the same
language and several time, features had to be implemented differently or
simply omitted. This is where this incomplete documention comes in handy
because it lists the things you should know to fill that gap.

Below, you'll find various developer notes. Unless you want to hack the
source code, it's unlikely that they are relevant to you. Please, ignore
them; I had to store them somewhere.

Big texture and sprite
----------------------
Nothing much to say about big texture and big sprite. Things work the
same except for `th.BigTexture` that works exactly like `sf.Texture`. ::

    # you cannot create an empty big texture
    bigtexture = th.BigTexture()

    # three ways to construct a big texture
    bigtexture = th.BigTexture.from_file("image.jpg")

    data = open("image.jpg", "rb").read()
    bigtexture = th.BigTexture.from_memory(data)

    image = sf.Image.from_file("image.jpg")
    bigtexture = th.BigTexture.from_image(image)

    # the two properties of big texture
    bigtexture.smooth # boolean
    bigtexture.size   # sf.Vector2f (read-only)

Above was how to deal with `th.BigTexture`, below is how to deal with
`th.BigSprite`. ::

    # create a sprite from a big texture
    bigsprite = th.BigSprite(bigtexture)

    # the four properties available
    bigsprite.texture
    bigsprite.color

    bigsprite.local_bounds
    bigsprite.global_bounds

Color gradient
--------------
Nothing surprising to say about `th.ColorGradient`. ::

    # create a gradient
    color_gradient = th.ColorGradient()
    color_gradient[0] = sf.Color.YELLOW
    color_gradient[1] = sf.Color.RED

    # sample a color
    print(color_gradient.sample_color(0.5))

Here is how to use `th.blend_colors`. ::

    # similar result with blend_colors
    color = th.blend_colors(sf.Color.YELLOW, sf.Color.RED, 0.5)

Developers notes
----------------
1) Passing an invalid position when sampling colors won't raise any
exception. This will silently pass resulting in incorrect return values.

2) You won't find any equivalent of `thor::setColor`, `thor::setAlpha` and
`thor::toString` functions. I don't know how and if I should implement them.
