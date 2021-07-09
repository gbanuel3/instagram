//
//  UserViewController.h
//  instagram
//
//  Created by Gildardo Banuelos on 7/9/21.
//
 
#import <UIKit/UIKit.h>
#import "PostCell.h"
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) NSArray *arrayOfPosts;

@end

NS_ASSUME_NONNULL_END
