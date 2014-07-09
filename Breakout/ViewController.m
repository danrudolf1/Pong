//
//  ViewController.m
//  Breakout
//
//  Created by dan rudolf on 5/22/14.
//  Copyright (c) 2014 Dan Rudolf. All rights reserved.
//

#import "ViewController.h"
#import "PaddleView.h"
#import "BallView.h"

@interface ViewController ()<UICollisionBehaviorDelegate>

@property UIDynamicAnimator *dynamicAnimator;
@property UIDynamicItemBehavior *ballBehavior;
@property UIDynamicItemBehavior *paddleBehavior;
@property UIPushBehavior *pushBall;
@property UICollisionBehavior *collisionBehavior;
@property (weak, nonatomic) IBOutlet BallView *ballView;
@property (weak, nonatomic) IBOutlet PaddleView *paddleView;
@property CGPoint point;
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.point = CGPointMake(0, 560);
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.pushBall = [[UIPushBehavior alloc] initWithItems:@[self.ballView] mode:UIPushBehaviorModeInstantaneous];
    
    self.pushBall.pushDirection = CGVectorMake(0.5, 1.0);
    self.pushBall.active = YES;
    self.pushBall.magnitude = 0.05;
    [self.dynamicAnimator addBehavior:self.pushBall];

    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ballView, self.paddleView]];
    self.collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    self.collisionBehavior.collisionDelegate = self;
    [self.dynamicAnimator addBehavior:self.collisionBehavior];
    
    self.paddleBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.paddleView]];
    self.paddleBehavior.density = 500;
    self.paddleBehavior.friction = NO;
    self.paddleBehavior.allowsRotation = NO;
    [self.dynamicAnimator addBehavior:self.paddleBehavior];
    
    self.ballBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.ballView]];
    self.ballBehavior.elasticity = 1.0;
    self.ballBehavior.friction = NO;
    self.ballBehavior.density = 1;
    self.ballBehavior.allowsRotation = NO;
    [self.dynamicAnimator addBehavior:self.ballBehavior];
    
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id

    <NSCopying>)identifier atPoint:(CGPoint)p{

    if (p.y > self.point.y) {
        self.ballView.center = self.view.center;
        [self.dynamicAnimator updateItemUsingCurrentState:self.ballView];
        NSLog(@"Uh Oh");
    }
}


- (IBAction)draggedPaddle:(UIPanGestureRecognizer *)paddleDragged{
    self.paddleView.center = CGPointMake([paddleDragged locationInView:self.view].x, self.paddleView.center.y);
    [self.dynamicAnimator updateItemUsingCurrentState:self.paddleView];
}


@end
