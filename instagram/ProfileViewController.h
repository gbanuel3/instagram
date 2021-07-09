//
//  ProfileViewController.h
//  instagram
//
//  Created by Gildardo Banuelos on 7/9/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) NSArray *arrayOfPosts;
@end

NS_ASSUME_NONNULL_END
