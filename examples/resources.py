from sfml import sf
from thor import th

#from enum import Enum

#Textures = Enum('Textures', 'ThorLogo BrownRectangle')
#Sounds = Enum('Sounds', 'Click')

# use enum to differentiate between textures/sounds, use string to differentiate between fonts
thor::ResourceHolder<sf::Texture,     Textures::Type> textures;
thor::ResourceHolder<sf::SoundBuffer, Sounds::Type>   sounds;
thor::ResourceHolder<sf::Font,        std::string>    fonts;

# create sf.Image to load one texture from
image = sf.Image()
image.create(872, 100, sf.Color(130, 70, 0));


# load resources, store them in resource pointers and react to loading errors
try:
    textures.acquire(Textures.BrownRectangle, th.Resources.fromImage(sf.Texture, image))
    textures.acquire(Textures.ThorLogo, th.Resources.fromFile(sf.Texture, "Media/thor.png"))
    sounds.acquire(Sounds.Click, th.Resources.fromFile(sf.SoundBufffer, "Media/click.wav"))
    fonts.acquire("MainFont", th.Resources.fromFile(sf.Font, "Media/sansation.ttf"))
except th.ResourceLoadingException as e:
    print(e)
    exit(1)

# create instances that use the resources
sprite1 = sf.Sprite(textures[Textures.BrownRectangle])
sprite2 = sf.Sprite(textures[Textures.ThorLogo])
sound = sf.Sound(sounds[Sounds.Click])
instructions("Press return to play sound, escape to quit", fonts["MainFont"], 14)

# move second sprite so that the sprites don't overlap
sprite2.move(0, sprite1.global_bounds.height)

# create render window
window = sf.RenderWindow(sf.VideoMode(872, 370), "Thor - Resources")
window.vertical_synchronization = True

running = True

while running:
    # handle events
    for event in window.events:
        if event == sf.CloseEvent:
            running = False

        elif event == sf.KeyEvent and event.pressed:
            if event.code == sf.Keyboard.ESCAPE:
                running = False
            elif event.code == sf.Keyboard.RETURN:
                sound.play()

    # draw sprites of the loaded textures
    window.clear()
    window.draw(sprite1)
    window.draw(sprite2)
    window.draw(instructions)
    window.display()
