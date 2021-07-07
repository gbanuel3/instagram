//
//  ComposeViewController.h
//  instagram
//
//  Created by Gildardo Banuelos on 7/7/21.
//
 
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UITextView *captionTextField;

@end

NS_ASSUME_NONNULL_END
