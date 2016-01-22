//
//  UIView+Autolayout.h
//  Portfolio
//
//  Created by Francisco Magdaleno on 1/12/16.
//  Copyright © 2016 franciscojma86. All rights reserved.
//


/*
Use this helper class to create NSLayoutConstraint objects and add them to the
superview.
Before calling any if these methods, all the subviews MUST be already added to
their superviews correctly. Once the constraints are created, they will be added
to the caller view, which MUST be the highest view in the heirarchy of the
views involved (superview or above).
*/

#import <UIKit/UIKit.h>

@interface UIView (Autolayout)

typedef NS_OPTIONS(NSUInteger, ConstraintEdges)  {
    ConstraintEdgesTop = (1 << 0),
    ConstraintEdgesLeft = (1 << 1),
    ConstraintEdgesBottom = (1 << 2),
    ConstraintEdgesRight = (1 << 3),
    ConstraintEdgesBaseline = (1 << 4),
    ConstraintEdgesCenterX = (1 << 5),
    ConstraintEdgesCenterY = (1 << 6)
};

typedef NS_OPTIONS(NSUInteger, ConstraintCenters)  {
    ConstraintCentersX = (1 << 0),
    ConstraintCentersY = (1 << 1)
};

typedef NS_OPTIONS(NSUInteger, ConstraintDimensions)  {
    ConstraintDimensionsWidth = (1 << 0),
    ConstraintDimensionsHeight = (1 << 1)
};

typedef NS_OPTIONS(NSUInteger, ConstraintPositions)  {
    ConstraintPositionsOnTop = (1 << 0),
    ConstraintPositionsBelow = (1 << 1),
    ConstraintPositionsToLead = (1 << 2),
    ConstraintPositionsToTrail = (1 << 3)
};

#pragma mark -View creation
+ (UIView *)autoLayoutView;

#pragma mark -Fill subview
///Constraints the subview to the size of the superview.
- (NSArray<NSLayoutConstraint *> *)fitSubview:(UIView *)subView
                                        apply:(BOOL)apply;

///Constraints the subview to the size of the superview with an offset.
- (NSArray<NSLayoutConstraint *> *)fitSubview:(UIView *)subView
                                overalloffset:(CGFloat)overalloffset
                                        apply:(BOOL)apply;

///Constraints the subview to the size of the superview with an offset and a multiplier.
- (NSArray<NSLayoutConstraint *> *)fitSubview:(UIView *)subView
                                overalloffset:(CGFloat)overalloffset
                                   multiplier:(CGFloat)multiplier
                                        apply:(BOOL)apply;
#pragma mark -Dimensions
///Aligns two views to the same width/height.
- (NSArray<NSLayoutConstraint *> *)alignView:(UIView *)view1
                                      toView:(UIView *)view2
                                  dimensions:(ConstraintDimensions)dimensions
                                        apply:(BOOL)apply;

///Aligns two views to the same width/height with an offset and multiplier.
- (NSArray<NSLayoutConstraint *> *)alignView:(UIView *)view1
                                      toView:(UIView *)view2
                                      offset:(CGFloat)offset
                                  multiplier:(CGFloat)multiplier
                                  dimensions:(ConstraintDimensions)dimensions
                                        apply:(BOOL)apply;

///Sets the width/height dimension for the view.
- (NSArray<NSLayoutConstraint *> *)changeDimensions:(ConstraintDimensions)dimensions
                                               size:(CGFloat)size
                                        apply:(BOOL)apply;

#pragma mark -Align edges
///Align the subview to the super view edges.
- (NSArray<NSLayoutConstraint *> *)alignSubview:(UIView *)subview
                                          edges:(ConstraintEdges)edges
                                          apply:(BOOL)apply;

///Align the subview to the super view edges with and offset and multiplier.
- (NSArray<NSLayoutConstraint *> *)alignSubview:(UIView *)subview
                                         offset:(CGFloat)offset
                                     multiplier:(CGFloat)multiplier
                                          edges:(ConstraintEdges)edges
                                        apply:(BOOL)apply;

///Align a view to another view's edges.
- (NSArray<NSLayoutConstraint *> *)alignView:(UIView *)view1
                                      toView:(UIView *)view2
                                       edges:(ConstraintEdges)edges
                                        apply:(BOOL)apply;

///Align a view to another view's edges with an offset and a multiplier.
- (NSArray<NSLayoutConstraint *> *)alignView:(UIView *)view1
                                      toView:(UIView *)view2
                                      offset:(CGFloat)offset
                                  multiplier:(CGFloat)multiplier
                                       edges:(ConstraintEdges)edges
                                        apply:(BOOL)apply;
#pragma mark -Centers
///Align the subview center to the superview.
- (NSArray<NSLayoutConstraint *> *)alignSubView:(UIView *)subView
                                        centers:(ConstraintCenters)centers
                                        apply:(BOOL)apply;

///Align the subview center to the superview with an offset and multiplier.
- (NSArray<NSLayoutConstraint *> *)alignSubView:(UIView *)subView
                                         offset:(CGFloat)offset
                                     multiplier:(CGFloat)multiplier
                                        centers:(ConstraintCenters)centers
                                        apply:(BOOL)apply;

///Align the subview center to the superview.
- (NSArray<NSLayoutConstraint *> *)alignView:(UIView *)view1
                                      toView:(UIView *)view2
                                     centers:(ConstraintCenters)centers
                                        apply:(BOOL)apply;

///Align the subview center to the superview with and offset and multiplier.
- (NSArray<NSLayoutConstraint *> *)alignView:(UIView *)view1
                                      toView:(UIView *)view2
                                      offset:(CGFloat)offset
                                  multiplier:(CGFloat)multiplier
                                     centers:(ConstraintCenters)centers
                                        apply:(BOOL)apply;

#pragma mark -Position
///Position a view in relation to another view.
- (NSArray<NSLayoutConstraint *> *)arrangeView:(UIView *)view1
                                        toView:(UIView *)view2
                                      position:(ConstraintPositions)positions
                                        apply:(BOOL)apply;

///Position a view in relation to another view with and offset and multiplier.
- (NSArray<NSLayoutConstraint *> *)arrangeView:(UIView *)view1
                                        toView:(UIView *)view2
                                        offset:(CGFloat)offset
                                    multiplier:(CGFloat)multiplier
                                      position:(ConstraintPositions)positions
                                        apply:(BOOL)apply;

@end
