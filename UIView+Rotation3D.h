//
//  UIView+Rotation3D.h
//
//  Created by Jooyoung Lee on 19/03/13.
//  Copyright (c) 2013 Jooyoung Lee. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Rotation3D)

@property (retain, nonatomic) NSMutableDictionary *rotation3Dstate;
@property (readonly, nonatomic) BOOL rotation3DStateHidden;
@property (assign, nonatomic) CGFloat rotation3DAnimationDuration;
@property (assign, nonatomic) CGFloat rotation3DAnimationDelay;

- (void)showRotation3D;
- (void)hideRotation3D;


@end
