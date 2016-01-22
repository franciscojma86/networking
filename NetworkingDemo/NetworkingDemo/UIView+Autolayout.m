//
//  UIView+Autolayout.m
//  Portfolio
//
//  Created by Francisco Magdaleno on 1/12/16.
//  Copyright © 2016 franciscojma86. All rights reserved.
//

#import "UIView+Autolayout.h"

@implementation UIView (Autolayout)

#pragma mark -View creation
+ (UIView *)autoLayoutView {
    UIView *view = [[UIView alloc]init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

#pragma mark -Fill subview
- (NSArray<NSLayoutConstraint *> *)fitSubview:(UIView *)subView
                                        apply:(BOOL)apply {
    return [self alignView:subView
                    toView:self
                    offset:0.0
                multiplier:1.0
                     edges:ConstraintEdgesTop |
            ConstraintEdgesRight |
            ConstraintEdgesBottom |
            ConstraintEdgesLeft
                     apply:apply];
}

- (NSArray<NSLayoutConstraint *> *)fitSubview:(UIView *)subView
                                overalloffset:(CGFloat)overalloffset
                                        apply:(BOOL)apply {
    return [self alignView:subView
                    toView:self
                    offset:overalloffset
                multiplier:1.0
                     edges:ConstraintEdgesTop |
            ConstraintEdgesRight |
            ConstraintEdgesBottom |
            ConstraintEdgesLeft
                     apply:apply];
}

- (NSArray<NSLayoutConstraint *> *)fitSubview:(UIView *)subView
                                overalloffset:(CGFloat)overalloffset
                                   multiplier:(CGFloat)multiplier
                                        apply:(BOOL)apply {
    return [self alignView:subView
                    toView:self
                    offset:overalloffset
                multiplier:multiplier
                     edges:ConstraintEdgesTop |
            ConstraintEdgesRight |
            ConstraintEdgesBottom |
            ConstraintEdgesLeft
                     apply:apply];
}

#pragma mark -Dimensions
- (NSArray<NSLayoutConstraint *> *)alignView:(UIView *)view1
                                      toView:(UIView *)view2
                                  dimensions:(ConstraintDimensions)dimensions
                                       apply:(BOOL)apply {
    return [self alignView:view1
                    toView:view2
                    offset:0.0
                multiplier:1.0
                dimensions:dimensions
                     apply:apply];
}

- (NSArray<NSLayoutConstraint *> *)changeDimensions:(ConstraintDimensions)dimensions
                                               size:(CGFloat)size
                                              apply:(BOOL)apply {
    NSMutableArray *constraints = [NSMutableArray array];
    if (dimensions & ConstraintDimensionsWidth) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:size]];
    }
    if (dimensions & ConstraintDimensionsHeight) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:size]];
    }
    if (apply) [self addConstraints:constraints];
    return constraints;
}

- (NSArray<NSLayoutConstraint *> *)alignView:(UIView *)view1
                                      toView:(UIView *)view2
                                      offset:(CGFloat)offset
                                  multiplier:(CGFloat)multiplier
                                  dimensions:(ConstraintDimensions)dimensions
                                       apply:(BOOL)apply {
    NSMutableArray *constraints = [NSMutableArray array];
    if (dimensions & ConstraintDimensionsWidth) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:view1
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view2
                                                            attribute:NSLayoutAttributeWidth
                                                           multiplier:multiplier
                                                             constant:offset]];
    }
    if (dimensions & ConstraintDimensionsHeight) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:view1
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view2
                                                            attribute:NSLayoutAttributeHeight
                                                           multiplier:multiplier
                                                             constant:offset]];
    }
    if (apply) [self addConstraints:constraints];
    return constraints;
}

#pragma mark -Align edges
- (NSArray<NSLayoutConstraint *> *)alignSubview:(UIView *)subview
                                          edges:(ConstraintEdges)edges
                                          apply:(BOOL)apply {
    NSArray *constraints = [self alignView:subview
                                    toView:self
                                    offset:0.0
                                multiplier:1.0
                                     edges:edges
                                     apply:apply];
    return constraints;
}


- (NSArray<NSLayoutConstraint *> *)alignSubview:(UIView *)subview
                                         offset:(CGFloat)offset
                                     multiplier:(CGFloat)multiplier
                                          edges:(ConstraintEdges)edges
                                          apply:(BOOL)apply {
    NSArray *constraints = [self alignView:subview
                                    toView:self
                                    offset:offset
                                multiplier:multiplier
                                     edges:edges
                                     apply:apply];
    return constraints;
}

- (NSArray<NSLayoutConstraint *> *)alignView:(UIView *)view1
                                      toView:(UIView *)view2
                                       edges:(ConstraintEdges)edges
                                       apply:(BOOL)apply {
    NSArray *constraints = [self alignView:view1
                                    toView:view2
                                    offset:0.0
                                multiplier:1.0
                                     edges:edges
                                     apply:apply];
    return constraints;
}

- (NSArray<NSLayoutConstraint *> *)alignView:(UIView *)view1
                                      toView:(UIView *)view2
                                      offset:(CGFloat)offset
                                  multiplier:(CGFloat)multiplier
                                       edges:(ConstraintEdges)edges
                                       apply:(BOOL)apply {
    NSMutableArray *constraints = [NSMutableArray array];
    
    if (edges & ConstraintEdgesTop) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:view1
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view2
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:multiplier
                                                             constant:offset]];
    }
    if (edges & ConstraintEdgesBottom) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:view1
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view2
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:multiplier
                                                             constant:-offset]];
    }
    if (edges & ConstraintEdgesRight) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:view1
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view2
                                                            attribute:NSLayoutAttributeTrailing
                                                           multiplier:multiplier
                                                             constant:-offset]];
    }
    if (edges & ConstraintEdgesLeft) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:view1
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view2
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:multiplier
                                                             constant:offset]];
    }
    if (edges & ConstraintEdgesBaseline) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:view1
                                                            attribute:NSLayoutAttributeBaseline
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view2
                                                            attribute:NSLayoutAttributeBaseline
                                                           multiplier:multiplier
                                                             constant:offset]];
    }
    if (apply) [self addConstraints:constraints];
    return constraints;
    
}


#pragma mark -Centers
- (NSArray<NSLayoutConstraint *> *)alignSubView:(UIView *)subView
                                        centers:(ConstraintCenters)centers
                                          apply:(BOOL)apply {
    return [self alignView:subView
                    toView:self
                    offset:0.0
                multiplier:1.0
                   centers:centers
                     apply:apply];
}

- (NSArray<NSLayoutConstraint *> *)alignSubView:(UIView *)subView
                                         offset:(CGFloat)offset
                                     multiplier:(CGFloat)multiplier
                                        centers:(ConstraintCenters)centers
                                          apply:(BOOL)apply {
    return [self alignView:subView
                    toView:self
                    offset:offset
                multiplier:multiplier
                   centers:centers
                     apply:apply];
}

- (NSArray<NSLayoutConstraint *> *)alignView:(UIView *)view1
                                      toView:(UIView *)view2
                                     centers:(ConstraintCenters)centers
                                       apply:(BOOL)apply {
    return [self alignView:view1
                    toView:view2
                    offset:0.0
                multiplier:1.0
                   centers:centers
                     apply:apply];
}

- (NSArray<NSLayoutConstraint *> *)alignView:(UIView *)view1
                                      toView:(UIView *)view2
                                      offset:(CGFloat)offset
                                  multiplier:(CGFloat)multiplier
                                     centers:(ConstraintCenters)centers
                                       apply:(BOOL)apply {
    NSMutableArray *constraints = [NSMutableArray array];
    if (centers & ConstraintCentersX) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:view1
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view2
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:multiplier
                                                             constant:offset]];
    }
    if (centers & ConstraintCentersY) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:view1
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view2
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:multiplier
                                                             constant:offset]];
    }
    if (apply) [self addConstraints:constraints];
    return constraints;
}

#pragma mark -Position
- (NSArray<NSLayoutConstraint *> *)arrangeView:(UIView *)view1
                                        toView:(UIView *)view2
                                      position:(ConstraintPositions)positions
                                         apply:(BOOL)apply {
    return [self arrangeView:view1
                      toView:view2
                      offset:0.0
                  multiplier:1.0
                    position:positions
                       apply:apply];
}

- (NSArray<NSLayoutConstraint *> *)arrangeView:(UIView *)view1
                                        toView:(UIView *)view2
                                        offset:(CGFloat)offset
                                    multiplier:(CGFloat)multiplier
                                      position:(ConstraintPositions)positions
                                         apply:(BOOL)apply {
    NSMutableArray *constraints = [NSMutableArray array];
    if (positions & ConstraintPositionsBelow) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:view1
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view2
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:multiplier
                                                             constant:offset]];
    }
    if (positions & ConstraintPositionsOnTop) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:view1
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view2
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:multiplier
                                                             constant:offset]];
    }
    if (positions & ConstraintPositionsToLead) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:view1
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view2
                                                            attribute:NSLayoutAttributeTrailing
                                                           multiplier:multiplier
                                                             constant:offset]];
    }
    if (positions & ConstraintPositionsToTrail) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:view1
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view2
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:multiplier
                                                             constant:offset]];
    }
    if (apply) [self addConstraints:constraints];
    return constraints;
}

@end

