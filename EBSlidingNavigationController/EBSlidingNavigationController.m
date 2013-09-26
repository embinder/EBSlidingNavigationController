//
//  EBSlidingNavigationController.m
//  EBSlidingNavigationController
//
//  Created by Erich Binder on 9/26/13.
//  Copyright (c) 2013 Catalyst. All rights reserved.
//

#define kExposedWidth 260.0
#define kSlideTiming .25
#define kCornerRadius 4
#define kMenuCellID @"MenuCell"

#import "EBSlidingNavigationController.h"

@interface EBSlidingNavigationController ()

@property (nonatomic, strong)UITableView *menu;
@property (nonatomic, strong)NSArray *viewControllerClasses;
@property (nonatomic, strong)NSArray *viewControllerNames;
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, assign)BOOL isMenuOpen;
@property (nonatomic, assign)BOOL viewControllersAreClasses;

@property (nonatomic, assign) BOOL showPanel;
@property (nonatomic, assign) CGPoint preVelocity;

@end

@implementation EBSlidingNavigationController

- (id)initWithViewControllerClasses:(NSArray *)viewControllers andTitles:(NSArray *)titles
{
    self = [super init];
    if (self)
	{
		self.viewControllersAreClasses = YES;
		
		self.titles = [titles copy];
		self.viewControllerClasses = [viewControllers copy];
		
        [self addMenu];
    }
    return self;
}

- (id)initWithViewControllerNames:(NSArray *)viewControllers andTitles:(NSArray *)titles
{
	self = [super init];
	if (self)
	{
		self.viewControllersAreClasses = NO;
		
		self.titles = [titles copy];
		self.viewControllerNames = [viewControllers copy];
		
		[self addMenu];
	}
	return self;
}

- (void)addMenu
{
	self.menu = [UITableView new];
	self.menu.delegate = self;
	self.menu.dataSource = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.menu registerClass:[UITableViewCell class] forCellReuseIdentifier:kMenuCellID];
	self.menu.frame = self.view.bounds;
	[self.view addSubview:self.menu];
	
	UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(toggleMenuVisibility:)];
	self.navigationController.navigationItem.leftBarButtonItems = [@[menuButtonItem] arrayByAddingObjectsFromArray:self.navigationController.navigationItem.leftBarButtonItems];
	
	UIViewController *vc;
	
	if (self.viewControllersAreClasses)
	{
		vc = [self.viewControllerClasses[0] new];
	}
	else
	{
		vc = [[NSClassFromString(self.viewControllerNames[0]) alloc] init];
	}
	
	vc.navigationItem.leftBarButtonItem = menuButtonItem;
	self.navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
	
	[self addChildViewController:self.navigationController];
	[self.view addSubview:self.navigationController.view];
	self.isMenuOpen = NO;
	[self adjustContentFrameAccordingToMenuVisibility];
	[self.navigationController didMoveToParentViewController:self];
}

- (void)toggleMenuVisibility:(id)sender
{
	self.isMenuOpen = !self.isMenuOpen;
	[self adjustContentFrameAccordingToMenuVisibility];
}

- (void)adjustContentFrameAccordingToMenuVisibility
{
	CGSize size = self.navigationController.view.frame.size;
	if (self.isMenuOpen)
	{
		[self.navigationController.view.layer setCornerRadius:0.0];
		[self.navigationController.view.layer setShadowOffset:CGSizeMake(0,0)];
		
		[UIView animateWithDuration:kSlideTiming
							  delay:0
							options:UIViewAnimationOptionCurveEaseOut
						 animations:^{
							 self.navigationController.view.frame = CGRectMake(kExposedWidth, 0, size.width, size.height);
						 }
						 completion:^(BOOL finished) {
							 
						 }];
	}
	else
	{
		[self.navigationController.view.layer setCornerRadius:kCornerRadius];
		[self.navigationController.view.layer setShadowColor:[UIColor blackColor].CGColor];
		[self.navigationController.view.layer setShadowOpacity:0.8];
		[self.navigationController.view.layer setShadowOffset:CGSizeMake(-2, -2)];
		
		[UIView animateWithDuration:kSlideTiming
							  delay:0
							options:UIViewAnimationOptionCurveEaseOut
						 animations:^{
							 self.navigationController.view.frame = CGRectMake(0, 0, size.width, size.height);
						 }
						 completion:^(BOOL finished) {
							 
						 }];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMenuCellID];
	cell.textLabel.text = self.titles[indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIViewController *vc;
	
	if (self.viewControllersAreClasses)
	{
		vc = [self.viewControllerClasses[indexPath.row] new];
	}
	else
	{
		vc = [[NSClassFromString(self.viewControllerNames[indexPath.row]) alloc] init];
	}
	
	UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(toggleMenuVisibility:)];
	vc.navigationItem.leftBarButtonItems = [@[menuButtonItem] arrayByAddingObjectsFromArray:vc.navigationItem.leftBarButtonItems];
	
	[self.navigationController pushViewController:vc animated:NO];
	
	[self toggleMenuVisibility:nil];
}

@end

