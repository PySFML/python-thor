from sfml import sf
from thor import th

# adds a range of frames, assuming they are aligned as rectangles in the texture
# animation:         FrameAnimation to modify
# x:                 column index of the texture rectangle
# [y_first, y_last]: bounds for row indices (if y_last < y_first, add frames in reverse order)
# duration:          relative duration of current frame (1 by default)
def add_frames(animation, x, y_first, y_last, duration=1):
    step = +1 if y_first < y_last else -1
    y_last += step # so y_last is excluded in the range

    y = y_first
    while (y != y_last):
        animation.add_frame(duration, (36*x, 39*y, 36, 39))
        y = y + step

window = sf.RenderWindow(sf.VideoMode(300, 200), "Thor - Animation")
window.vertical_synchronization = True
window.key_repeat_enabled = False

# hack
view = sf.View()
view.size = (300, 200)
view.center = (150, 100)

window.view = view


font = sf.Font.from_file("Media/sansation.ttf")

# instruction text
instructions_text =  "W:     Play walk animation (loop)\n"
instructions_text += "A:      Play attack animation\n"
instructions_text += "S:      Stop current animation\n"
instructions_text += "Esc:  Quit"
instructions = sf.Text(instructions_text, font, 14)

animation_text = sf.Text("", font, 14)
animation_text.position = (100, 150)

# load image that contains animation steps
image = sf.Image.from_file("Media/animation.png")
image.create_mask_from_color(sf.Color.WHITE)

# create texture based on sf.Image
texture = sf.Texture.from_image(image)

# create sprite which is animated
sprite = sf.Sprite(texture)
sprite.position = (100, 100)

# define walk animation
walk = th.FrameAnimation()
add_frames(walk, 0, 0, 7) # frames 0..7: right leg moves forward
add_frames(walk, 0, 6, 0) # frames 6..0: right leg moves backward

# define attack animation
attack = th.FrameAnimation()
add_frames(attack, 1, 0, 3)      # frames 0..3: lift gun
add_frames(attack, 1, 4, 4, 5.0) # frame  4   : aim (5 times normal frame duration)
for _ in range(3):
    add_frames(attack, 1, 5, 7)  # frames 5..7: fire (repeat 3 times)
add_frames(attack, 1, 4, 4, 5.0) # frame  4   : wait
add_frames(attack, 1, 3, 0)      # frame  3..1: lower gun

# define static frame for stand animation
stand = th.FrameAnimation()
add_frames(stand, 0, 0, 0)

# register animations with their corresponding durations
animator = th.Animator()
#animator.add_animation("walk", walk, sf.seconds(1))
#animator.add_animation("stand", stand, sf.seconds(1))
#animator.add_animation("attack", attack, sf.seconds(1))
animator.add_animation(0, walk, sf.seconds(1))
animator.add_animation(1, stand, sf.seconds(1))
animator.add_animation(2, attack, sf.seconds(1))

# create clock to measure frame time
frame_clock = sf.Clock()

# main loop
running = True

while(running):

    # handle events
    for event in window.events:
        if event == sf.KeyEvent and event.pressed:
            if event.code == sf.Keyboard.W:
                #animator.play_animation("walk", True)
                animator.play_animation(0, True)
            elif event.code == sf.Keyboard.A:
                #animator.play_animation("attack")
                animator.play_animation(2)
            elif event.code == sf.Keyboard.S:
                animator.stop_animation()
            elif event.code == sf.Keyboard.ESCAPE:
                running = False

        elif event == sf.CloseEvent:
            running = False

    # if no other animation is playing, play stand animation
    if not animator.is_playing_animation():
        animator.play_animation(1)
        #animator.play_animation("stand")

    # output playing animation (general case; at the moment an animation is always playing)
    if animator.is_playing_animation():
        #animation_text.string = "Animation: " + animator.get_playing_animation()
        animation_text.string = "Animation: " + str(animator.get_playing_animation())
    else:
        animation_text.string = ""

    # update animator and apply current animation state to the sprite
    animator.update(frame_clock.restart())
    animator.animate(sprite)

    # draw everything
    window.clear(sf.Color(50, 50, 50))
    window.draw(instructions);
    window.draw(animation_text);
    window.draw(sprite)
    window.display()
