//
//  HomeFeedViewController.h
//  instagram
//
//  Created by Gildardo Banuelos on 7/6/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeFeedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *postButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *arrayOfPosts;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

NS_ASSUME_NONNULL_END
