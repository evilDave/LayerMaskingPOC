//
//  ViewController.m
//  LayerMaskingPOC
//
//  Created by David Clark on 18/02/2016.
//  Copyright (c) 2016 David Clark. All rights reserved.
//


#import "ViewController.h"


@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController {
	CALayer *_maskLayer;
	UIView *_hideableView;
	CABasicAnimation *_hideAnimation;
	CABasicAnimation *_showAnimation;
	UITapGestureRecognizer *_hideRecognizer;
}

- (void)loadView {
	UIView *view = [[UIView alloc] init];
	[self setView:view];

	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background1"]];
	[imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:imageView];
	[imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
	[imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;

	// make a demo form for the background
	UIView *lastView = nil;
	lastView = [self addLabelWithText:@"some other label" toView:self.view belowView:lastView];
	lastView = [self addTextFieldWithText:@"some text field" toView:self.view belowView:lastView];
	lastView = [self addLabelWithText:@"some other label" toView:self.view belowView:lastView];
	lastView = [self addTextFieldWithText:@"some text field" toView:self.view belowView:lastView];
	lastView = [self addTextFieldWithText:@"some text field" toView:self.view belowView:lastView];
	lastView = [self addTextFieldWithText:@"some text field" toView:self.view belowView:lastView];
	lastView = [self addLabelWithText:@"some other label" toView:self.view belowView:lastView];
	lastView = [self addTextFieldWithText:@"some text field" toView:self.view belowView:lastView];
	lastView = [self addTextFieldWithText:@"some text field" toView:self.view belowView:lastView];
	lastView = [self addTextFieldWithText:@"some text field" toView:self.view belowView:lastView];
	lastView = [self addLabelWithText:@"some other label" toView:self.view belowView:lastView];
	lastView = [self addTextFieldWithText:@"some text field" toView:self.view belowView:lastView];

	_hideableView = [[UIView alloc] init];
	[_hideableView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[_hideableView setBackgroundColor:[UIColor lightGrayColor]];
	[self.view addSubview:_hideableView];
	[_hideableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
	[_hideableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
	[_hideableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
	[_hideableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;

	UIImage *maskImage = [UIImage imageNamed:@"Mask"];
	_maskLayer = [CALayer layer];
	[_maskLayer setContents:(__bridge id)[maskImage CGImage]];
	[_hideableView.layer setMask:_maskLayer];

	_hideRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
	[_hideRecognizer setNumberOfTouchesRequired:1];
	[_hideableView addGestureRecognizer:_hideRecognizer];

	UITapGestureRecognizer *showRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showView)];
	[showRecogniser setNumberOfTouchesRequired:1];
	[self.view addGestureRecognizer:showRecogniser];

	// make a demo form for the foreground
	lastView = nil;
	lastView = [self addLabelWithText:@"a label" toView:_hideableView belowView:lastView];
	lastView = [self addTextFieldWithText:@"a text field" toView:_hideableView belowView:lastView];
	lastView = [self addTextFieldWithText:@"another text field" toView:_hideableView belowView:lastView];
	lastView = [self addTextFieldWithText:@"another text field" toView:_hideableView belowView:lastView];
	lastView = [self addLabelWithText:@"a different label" toView:_hideableView belowView:lastView];
	lastView = [self addTextFieldWithText:@"another text field" toView:_hideableView belowView:lastView];
	lastView = [self addTextFieldWithText:@"another text field" toView:_hideableView belowView:lastView];
	lastView = [self addTextFieldWithText:@"another text field" toView:_hideableView belowView:lastView];
	lastView = [self addTextFieldWithText:@"another text field" toView:_hideableView belowView:lastView];
	lastView = [self addTextFieldWithText:@"another text field" toView:_hideableView belowView:lastView];
	// instructions
	UILabel *label = [self addLabelWithText:@"(touch to show/hide view)" toView:_hideableView belowView:lastView];
	[label setFont:[UIFont fontWithName:@"HelveticaNeue-Italic" size:14]];
	[label setTextColor:[UIColor blackColor]];
}

- (void)hideView {
	CGPoint point = CGPointMake(_hideableView.frame.size.width/2, _hideableView.frame.size.height*2);
	_hideAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
	_hideAnimation.fromValue = [_maskLayer valueForKey:@"position"];
	_hideAnimation.toValue = [NSValue valueWithCGPoint:point];
	_hideAnimation.duration = 0.6;
	[_hideAnimation setDelegate:self];
	_maskLayer.position = point;

	[_maskLayer addAnimation:_hideAnimation forKey:@"position"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	[_hideableView setHidden:YES];
}

- (void)showView {
	CGPoint point = CGPointMake(_hideableView.frame.size.width/2, _hideableView.frame.origin.y);
	_showAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
	_showAnimation.fromValue = [_maskLayer valueForKey:@"position"];
	_showAnimation.toValue = [NSValue valueWithCGPoint:point];
	_showAnimation.duration = 0.6;
	_maskLayer.position = point;
	[_hideableView setHidden:NO];

	[_maskLayer addAnimation:_showAnimation forKey:@"position"];
}

- (void)viewDidLayoutSubviews {
	CGRect frame = _hideableView.frame;
	frame.size.height *= 2;
	_maskLayer.frame = frame;
	_maskLayer.position = CGPointMake(frame.size.width/2, frame.origin.y);
}

- (UITextField *)addTextFieldWithText:(NSString *)text toView:(UIView *)containerView belowView:(UIView *)belowView {
	UITextField *textField = [[UITextField alloc] init];
	[textField setTranslatesAutoresizingMaskIntoConstraints:NO];
	[textField setFont:[UIFont fontWithName:@"HelveticaNeue" size:22]];
	[textField.layer setCornerRadius:5];
	[textField.layer setBorderColor:[[UIColor grayColor] CGColor]];
	[textField.layer setBorderWidth:0.5];
	[textField setText:text];
	[textField setBackgroundColor:[UIColor whiteColor]];
	[textField setReturnKeyType:UIReturnKeyDone];
	[textField setDelegate:self];
	[containerView addSubview:textField];
	[textField.topAnchor constraintEqualToAnchor:belowView ? belowView.bottomAnchor : containerView.topAnchor constant:belowView ? 20 : 50].active = YES;
	[textField.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor constant:50].active = YES;
	[textField.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor constant:-50].active = YES;
	return textField;
}

- (UILabel *)addLabelWithText:(NSString *)text toView:(UIView *)containerView belowView:(UIView *)belowView {
	UILabel *label = [[UILabel alloc] init];
	[label setTranslatesAutoresizingMaskIntoConstraints:NO];
	[label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:22]];
	[label setTextColor:[UIColor whiteColor]];
	[label setText:text];
	[containerView addSubview:label];
	[label.topAnchor constraintEqualToAnchor:belowView ? belowView.bottomAnchor : containerView.topAnchor constant:belowView ? 20 : 50].active = YES;
	[label.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor constant:50].active = YES;
	[label.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor constant:-50].active = YES;
	return label;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

@end
