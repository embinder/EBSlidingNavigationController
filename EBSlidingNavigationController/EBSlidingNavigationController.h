//
//  EBSlidingNavigationController.h
//  EBSlidingNavigationController
//
//  Created by Erich Binder on 9/26/13.
//  Copyright (c) 2013 Catalyst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EBSlidingNavigationController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UINavigationController *navigationController;

- (id)initWithViewControllerClasses:(NSArray *)viewControllers andTitles:(NSArray *)titles;
- (id)initWithViewControllerNames:(NSArray *)viewControllers andTitles:(NSArray *)titles;

@end
