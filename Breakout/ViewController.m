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
@property CGPoint pointBottom;
@property CGPoint pointTop;

@property (weak, nonatomic) IBOutlet BallView *ballView;
@property (weak, nonatomic) IBOutlet PaddleView *paddleView2;
@property (weak, nonatomic) IBOutlet PaddleView *paddleView1;
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.ballView.layer.cornerRadius = self.ballView.frame.size.height/2;
    self.ballView.layer.masksToBounds = YES;

    self.pointBottom = CGPointMake(0, self.view.frame.size.height - 10);
    self.pointTop = CGPointMake(0, 10);
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.pushBall = [[UIPushBehavior alloc] initWithItems:@[self.ballView] mode:UIPushBehaviorModeInstantaneous];
    
    self.pushBall.pushDirection = CGVectorMake(0.5, 1.0);
    self.pushBall.active = YES;
    self.pushBall.magnitude = 0.025;
    [self.dynamicAnimator addBehavior:self.pushBall];

    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ballView, self.paddleView1, self.paddleView2]];
    self.collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    self.collisionBehavior.collisionDelegate = self;
    [self.dynamicAnimator addBehavior:self.collisionBehavior];
    
    self.paddleBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.paddleView1,self.paddleView2]];
    self.paddleBehavior.density = 500;
    self.paddleBehavior.friction = NO;
    self.paddleBehavior.allowsRotation = NO;
    [self.dynamicAnimator addBehavior:self.paddleBehavior];
    
    self.ballBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.ballView]];
    self.ballBehavior.elasticity = 1.0;
    self.ballBehavior.friction = NO;
    self.ballBehavior.resistance = NO;
    self.ballBehavior.density = 1;
    self.ballBehavior.allowsRotation = NO;
    [self.dynamicAnimator addBehavior:self.ballBehavior];
    
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id

    <NSCopying>)identifier atPoint:(CGPoint)p{

    if (p.y > self.pointBottom.y) {

        NSLog(@"Player 2 Wins!");
    }

    else if (p.y < self.pointTop.y) {

        NSLog(@"player 1 Wins!");
    }
}


- (IBAction)draggedPaddleOne:(UIPanGestureRecognizer *)paddleDraggedOne{
    
    self.paddleView1.center = CGPointMake([paddleDraggedOne locationInView:self.view].x, self.paddleView1.center.y);
    [self.dynamicAnimator updateItemUsingCurrentState:self.paddleView1];
}

- (IBAction)draggedPaddleTwo:(UIPanGestureRecognizer *)paddleDraggedTwo{

    self.paddleView2.center = CGPointMake([paddleDraggedTwo locationInView:self.view].x, self.paddleView2.center.y);
    [self.dynamicAnimator updateItemUsingCurrentState:self.paddleView2];

}

@end
