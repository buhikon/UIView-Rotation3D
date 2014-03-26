//
//  UIView+Rotation3D.m
//
//  Created by Jooyoung Lee on 19/03/13.
//  Copyright (c) 2013 Jooyoung Lee. All rights reserved.
//

#import "UIView+Rotation3D.h"
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static char const * const kRotation3DStateTagKey = "kRotation3DStateKey";


@implementation UIView (Rotation3D)

@dynamic rotation3Dstate;
@dynamic rotation3DStateHidden;
@dynamic rotation3DAnimationDuration;
@dynamic rotation3DAnimationDelay;

#pragma mark - accessor
//getter
- (NSMutableDictionary *)rotation3Dstate
{
    NSMutableDictionary *rotation3Dstate = objc_getAssociatedObject(self, kRotation3DStateTagKey);
    
    if( !rotation3Dstate ) {
        rotation3Dstate = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, kRotation3DStateTagKey, rotation3Dstate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return rotation3Dstate;
}
//setter
- (void)setRotation3Dstate:(NSMutableDictionary *)rotation3Dstate
{
    objc_setAssociatedObject(self, kRotation3DStateTagKey, rotation3Dstate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)rotation3DStateHidden
{
    return [[self.rotation3Dstate objectForKey:@"rotation3DStateHidden"] boolValue];
}
- (void)setRotation3DStateHidden:(BOOL)rotation3DStateHidden
{
    [self.rotation3Dstate setObject:@(rotation3DStateHidden) forKey:@"rotation3DStateHidden"];
}
- (CGFloat)rotation3DAnimationDuration
{
    return [[self.rotation3Dstate objectForKey:@"rotation3DAnimationDuration"] floatValue];
}
- (void)setRotation3DAnimationDuration:(CGFloat)rotation3DAnimationDuration
{
    [self.rotation3Dstate setObject:@(rotation3DAnimationDuration) forKey:@"rotation3DAnimationDuration"];
}
- (CGFloat)rotation3DAnimationDelay
{
    return [[self.rotation3Dstate objectForKey:@"rotation3DAnimationDelay"] floatValue];
}
- (void)setRotation3DAnimationDelay:(CGFloat)rotation3DAnimationDelay
{
    [self.rotation3Dstate setObject:@(rotation3DAnimationDelay) forKey:@"rotation3DAnimationDelay"];
}
- (CGFloat)rotation3DPaddingPercent
{
    return [[self.rotation3Dstate objectForKey:@"rotation3DPaddingPercent"] floatValue];
}
- (void)setRotation3DPaddingPercent:(CGFloat)rotation3DPaddingPercent
{
    [self.rotation3Dstate setObject:@(rotation3DPaddingPercent) forKey:@"rotation3DPaddingPercent"];
}

#pragma mark -

- (void)showRotation3D
{
    if( !self.rotation3DStateHidden)
        [self rotation3DInitialize];
    
    [self rotation3DWithValue:0.0 duration:0.0 delay:0.0];
    [self rotation3DWithValue:-0.5 duration:self.rotation3DAnimationDuration delay:self.rotation3DAnimationDelay];
}
- (void)hideRotation3D
{
    [self rotation3DWithValue:-0.5 duration:0.0 delay:0.0];
    [self rotation3DWithValue:0.0 duration:self.rotation3DAnimationDuration delay:self.rotation3DAnimationDelay];
}

#pragma mark - Private Methods

- (void)rotation3DInitialize
{
    [self setRotation3DPaddingPercent:self.frame.origin.x / self.frame.size.width];
}

- (void)rotation3DWithValue:(CGFloat)value duration:(CGFloat)duration delay:(CGFloat)delay
{
    if( value != 0.0 )
        [self setRotation3DStateHidden:YES];
    
    if( duration == 0.0) {
        
        CATransform3D t = CATransform3DIdentity;
        t.m34 = 1.0 / -1000;
        t = CATransform3DRotate(t, value * 0.2 * M_PI, 1, 0, 0);
        t = CATransform3DRotate(t, value * M_PI, 0, 1, 0);
        
        self.layer.anchorPoint = CGPointMake(-self.rotation3DPaddingPercent, 0.5);
        
        float ypos = self.layer.position.y;
        self.layer.position = CGPointMake(0, ypos);
        
        self.layer.transform = t;
        
    }
    else {
        
        [UIView animateWithDuration:duration
                              delay:delay
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             CATransform3D t = CATransform3DIdentity;
                             t.m34 = 1.0 / -1000;
                             t = CATransform3DRotate(t, value * 0.2 * M_PI, 1, 0, 0);
                             t = CATransform3DRotate(t, value * M_PI, 0, 1, 0);
                             
                             self.layer.anchorPoint = CGPointMake(-self.rotation3DPaddingPercent, 0.5);
                             
                             float ypos = self.layer.position.y;
                             self.layer.position = CGPointMake(0, ypos);
                             
                             self.layer.transform = t;
                             
                         } completion:^(BOOL finished) {
                             if( value == 0.0 )
                                 [self setRotation3DStateHidden:NO];
                         }];
    }
    
}

@end
