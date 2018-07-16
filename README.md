# AJKBanner
Customized Banner View For iOS

![alt text](https://github.com/assadjaved/AJKBanner/blob/master/AJKBannerDemo.gif)

## Features

1. Color Variations (AJKBannerBGColor)
    * Red
    * Green
    * Blue
    * Yellow
    * Orange
    * Custom

2. Animation (AJKBannerAnimation)
    * Linear
    * Springy

3. Direction (AJKBannerDirection)
    * Left
    * Right
    * Down

4. Image (AJKBannerImage)
    * Thumb
    * Checkmark
    * Exclamation
    * Cross

## Initializer

```javascript
AJKBanner.addBanner(title: String,
                    message: String,
                    bannerColor: AJKBannerBGColor,
                    direction: AJKBannerDirection,
                    animation: AJKBannerAnimation,
                    titleFontName: String?,
                    messageFontName: String?,
                    textColor: UIColor,
                    imageType: AJKBannerImage,
                    imageTint: UIColor)
```
