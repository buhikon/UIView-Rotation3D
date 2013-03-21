UIView+Rotation3D
==========

3D Rotation for UIView

## Features

- UIView category
- Show / Hide


## How To Use


### 1. Initialize
```
view.rotation3DAnimationDuration = duration;
view.rotation3DAnimationDelay = delay;
```

### 2. Action
```
[view showRotation3D];
```
OR
```
[view hideRotation3D];
```

[![](https://raw.github.com/buhikon/UIView-Rotation3D/master/showcase.gif)](https://raw.github.com/buhikon/UIView-Rotation3D/master/showcase.gif)


## Issues

Don't change the frame of the view after calling `hideRotation3D`.
Before changing it, you should call `showRotation3D` first.

For this, you can check the state of the view by calling `view.rotation3DStateHidden`.
If the value is YES, the view is currently in HIDDEN state.


## Requirements

- QuartzCore framework in your project



## License

This is released under an MIT license.
