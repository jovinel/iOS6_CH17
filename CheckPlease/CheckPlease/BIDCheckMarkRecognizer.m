//
//  BIDCheckMarkRecognizer.m
//  CheckPlease
//
//  Created by Crescens Techstars on 12/10/13.
//  Copyright (c) 2013 Crescens Techstars. All rights reserved.
//

#import "BIDCheckMarkRecognizer.h"
#import "CGPointUtils.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

#define kMinimumCheckMarkAngle      50
#define kMaximumCheckMarkAngle      135
#define kMinimumCheckMarkLength     10

@implementation BIDCheckMarkRecognizer {
    CGPoint lastPreviousPoint;
    CGPoint lastCurrentPoint;
    CGFloat lineLengthSoFar;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    lastPreviousPoint = point;
    lastCurrentPoint = point;
    lineLengthSoFar = 0.0f;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    CGPoint currentPoint = [touch locationInView:self.view];
    CGFloat angle = angleBetweenLines(lastPreviousPoint, lastCurrentPoint, previousPoint, currentPoint);
    
    if (angle >= kMinimumCheckMarkAngle && angle <= kMaximumCheckMarkAngle && lineLengthSoFar > kMinimumCheckMarkAngle) {
        self.state = UIGestureRecognizerStateEnded;
    }
    lineLengthSoFar += distanceBetweenPoints(previousPoint, currentPoint);
    lastPreviousPoint = previousPoint;
    lastCurrentPoint = currentPoint;
}

@end
