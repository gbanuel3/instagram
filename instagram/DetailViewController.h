//
//  DetailViewController.h
//  instagram
//
//  Created by Gildardo Banuelos on 7/8/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"


NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@property (strong, nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
