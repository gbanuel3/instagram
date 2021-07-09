//
//  CustomCameraViewController.h
//  instagram
//
//  Created by Gildardo Banuelos on 7/9/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
 
@interface CustomCameraViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (weak, nonatomic) IBOutlet UIImageView *captureImageView;
@property (weak, nonatomic) IBOutlet UIButton *didTakePhoto;
@property (strong, nonatomic) UIWindow * window;
@end

NS_ASSUME_NONNULL_END
