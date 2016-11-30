//
//  AppDelegate.m
//  仿微博首页动画
//
//  Created by zhangqian on 16/11/15.
//  Copyright © 2016年 zhangqian. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ToolViewController.h"
#import "SeetingViewController.h"
#import "VCViewController.h"

#import "RDVTabBarController.h"

#import "RDVTabBarItem.h"

#import "HyPopMenuView.h"

// 颜色
#define WColorRGB(r, g, b) WColorRGBA(r, g, b, 1.000f)
/**
 *  内容文字颜色
 */
#define WColorFontContent WColorRGB(153,153,153)
//获取屏幕宽高
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define APPDELEGATE         (AppDelegate *)[UIApplication sharedApplication].delegate  //入口类

@interface AppDelegate ()<HyPopMenuViewDelegate,RDVTabBarControllerDelegate>

@property (strong, nonatomic) RDVTabBarController *tabBarController;
@property (strong, nonatomic) HyPopMenuView *menu;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    HomeViewController *view = [[HomeViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:view];
    self.window.rootViewController = navi;
    
    [self creatTabBarViewcontroll];
    // Override point for customization after application launch.
    return YES;
}


- (void)creatTabBarViewcontroll{
    NSArray * nameArray = @[@"首页",@"消息",@"",@"工具箱",@"设置"];
    NSArray *selectImageArray = @[@"mainTabBar_oneSelect",@"mainTabBar_twoSelect",@"mainTabBar_threeSelect",@"mainTabBar_fourSelect",@"mainTabBar_fiveSelect"];
    NSArray *noSelectImageArray = @[@"mainTabBar_oneNoSelect",@"mainTabBar_twoNoSelect",@"mainTabBar_threeSelect",@"mainTabBar_fourNoSelect",@"mainTabBar_fiveNoSelect"];
    
    
    HomeViewController *firstViewController = [[HomeViewController alloc] init];
//    firstViewController.isRootVC = YES;
//    firstViewController.isNeedRemoteLog = YES;
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    MessageViewController *secondViewController = [[MessageViewController alloc] init];
//    secondViewController.isRootVC = YES;
//    [secondViewController getUnReadMsgNum];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    ViewController *thirdViewController = [[ViewController alloc] init];
    
    //  thirdViewController.isRootVC = YES;
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    
    
    ToolViewController *fourViewController = [[ToolViewController alloc] init];
    //fourViewController.isRootVC = YES;
    //   fourViewController.isRootVC = YES;
    //    __weak  HXHomePageController   *homePageCtrl = self;
    //    fourViewController.handlerBlock = ^ () {
    //        [homePageCtrl.childCtrl updateUserPhoto];
    //    };
    UIViewController *fourNavigationController = [[UINavigationController alloc]
                                                  initWithRootViewController:fourViewController];
    
    SeetingViewController *fiveVC = [[SeetingViewController alloc]init];
    
    
    UIViewController *fiveNC = [[UINavigationController alloc]initWithRootViewController:fiveVC];
    
    


    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    _tabBarController = tabBarController;
//    
    tabBarController.tabBar.backgroundView.layer.shadowColor =  [UIColor grayColor].CGColor;
    tabBarController.tabBar.backgroundView.layer.shadowOpacity = 0.5;// 阴影透明度
    tabBarController.tabBar.backgroundView.layer.shadowRadius = 3;// 阴影扩散的范围控制
    tabBarController.tabBar.backgroundView.layer.shadowOffset  = CGSizeMake(0,0);// 阴影的范围
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,thirdNavigationController
                                           ,fourNavigationController,fiveNC]];
   
    
    
    
    NSDictionary *unSelectedStyle = @{
                                    NSForegroundColorAttributeName: [UIColor grayColor] ,
                                    };
    
    NSDictionary *selectedStyle = @{
                                    NSForegroundColorAttributeName: [UIColor cyanColor] ,
                                    };

   
    
    NSInteger count = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        // if (count != 2) {
        [item setTitle:nameArray[count]];
        //        }else{
        //            //item.userInteractionEnabled = NO;
        //        }
        
        [item setSelectedTitleAttributes:selectedStyle];
        [item setUnselectedTitleAttributes:unSelectedStyle];
        [item setFinishedSelectedImage:[UIImage imageNamed:selectImageArray[count]] withFinishedUnselectedImage:[UIImage imageNamed:noSelectImageArray[count]]];
        if (count == 2) {
            item.selected = NO;
            UIButton *publishButton = [[UIButton alloc]init];
            //     publishButton.backgroundColor = [UIColor whiteColor];
            [publishButton setImage:[UIImage imageNamed:@"mainTabBar_threeSelect"] forState:UIControlStateNormal];
            [publishButton setImage:[UIImage imageNamed:@"mainTabBar_threeSelect"] forState:UIControlStateHighlighted];
            publishButton.backgroundColor = [UIColor whiteColor];
            [item addSubview:publishButton];
            [publishButton addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
            publishButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/5,49);
        }
        item.backgroundColor = [UIColor whiteColor];
        
        
                    [item setSelectedTitleAttributes:selectedStyle];
                    [item setUnselectedTitleAttributes:unSelectedStyle];
        count ++;
        
    }
    
    
    
    [APPDELEGATE updateRootViewController:tabBarController];
}

- (void)plusBtnClick{
    if (!_menu) {
        NSArray *imageArray = @[@"mainCenter_addCus",@"mainCenter_addCar",@"mainCenter_addLiushui",@"mainCenter_addPingGu"];
        NSArray *titleArray = @[@"新增客户",@"发布车辆",@"查看流水账",@"新增评估"];
        NSMutableArray *addSettingArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < [titleArray count]; i++) {
            PopMenuModel* model = [PopMenuModel
                                   allocPopMenuModelWithImageNameString:imageArray[i]
                                   AtTitleString:titleArray[i]
                                   AtTextColor:[UIColor grayColor]
                                   AtTransitionType:PopMenuTransitionTypeCustomizeApi
                                   AtTransitionRenderingColor:nil];
            [addSettingArray addObject:model];
        }
        _menu = [HyPopMenuView sharedPopMenuManager];
        _menu.delegate = self;
        __weak __typeof(self) weakSelf = self;
        _menu.menuButton = ^(NSInteger num){
            [weakSelf moveAddMenuButton:num];
        };
        _menu.dataSource = addSettingArray;
        _menu.popMenuSpeed = 12.0f;
        _menu.automaticIdentificationColor = false;
        _menu.animationType = HyPopMenuViewAnimationTypeViscous;
        UIImageView* topView = [[UIImageView alloc]init];
        topView.image = [UIImage imageNamed:@"mainCenter_top"];
        topView.frame = CGRectMake(20, 44, SCREEN_WIDTH - 40, (SCREEN_WIDTH - 40)/4);
        _menu.topView = topView;
        
    }
    _menu.backgroundType = HyPopMenuViewBackgroundTypeLightBlur;
    [_menu openMenu];
    
}


- (void)moveAddMenuButton:(NSInteger)num{
    UINavigationController *viewController = (UINavigationController*)[_tabBarController selectedViewController];
    if (num == 0) {
        VCViewController   *newCustomer = [[VCViewController alloc]init];
//        newCustomer.newCustomerType = HXNewCustomerTypeIncrease;
        [viewController pushViewController:newCustomer animated:YES];
    }
    if (num == 1) {
//        HXSellCarPublishVC *sellcarPublishVC = [[HXSellCarPublishVC alloc]init];
//        sellcarPublishVC.pageType = HXCarPublishTypeDefault;
//        [viewController pushViewController:sellcarPublishVC animated:YES];
    }
    if (num == 2) {
//        NSMutableDictionary *baseDic = [[NSMutableDictionary alloc]init];
//        [baseDic setObject:@"tradeFlow" forKey:@"action"];
//        [App_Hud showProgressMessage:hud_loading];
//        __weak typeof(self) weakSelf = self;
//        [CXKNetWorkings checkrootWithInformation:baseDic Success:^(id obj) {
//            
//            
//            
//            NSDictionary *memo = (NSDictionary *)obj;
//            if ([memo[@"pass"] isEqualToString:@"true"]) {
//                HXPriceStatisticalViewController *priceSVC = [[HXPriceStatisticalViewController alloc]init];
//                [viewController pushViewController:priceSVC animated:YES];
//                [App_Hud dismissHUD];
//            }else{
//                
//                [App_Hud showInfoMessage:@"当前角色暂无权限"];
//                
//            }
//            
//        } failed:^(id obj) {
//            [App_Hud showErrorMessage:obj];
//        } complete:^(id obj) {
//            NSError *error = obj;
//            [App_Hud showErrorMessage:@"请求失败,请重新尝试请求"];
//            
//        }];
    }
    if (num == 3) {
//        HXSellCarPublishVC *sellcarPublishVC = [[HXSellCarPublishVC alloc]init];
//        sellcarPublishVC.pageType = HXCarPublishTypeEvaluation;
//        [viewController pushViewController:sellcarPublishVC animated:YES];
    }
}


#pragma mark - 全局函数
- (void)updateRootViewController:(UIViewController *)ctrl {
    self.window.rootViewController = ctrl;
}


#pragma mark - Methods

//- (UIViewController *)selectedViewController {
//    return [[self viewControllers] objectAtIndex:[self selectedIndex]];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
