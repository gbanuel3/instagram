//
//  ComposeViewController.m
//  instagram
//
//  Created by Gildardo Banuelos on 7/7/21.
//
 
#import "ComposeViewController.h"
#import "HomeFeedViewController.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@end

@implementation ComposeViewController
 
- (IBAction)onClickCancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onClickShare:(id)sender {
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.postImage.image = originalImage;
 
    // Do something with the images (based on your use case)
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initiateCamera{
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"Camera was found and used!");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
- (IBAction)onTap:(id)sender{
    [self.view endEditing:true];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([self.captionTextField.textColor isEqual:[UIColor secondaryLabelColor]]){
        self.captionTextField.text = nil;
        self.captionTextField.textColor = [UIColor blackColor];
        
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if([self.captionTextField.text isEqual:@""]){
        self.captionTextField.text = @"Add a caption...";
        self.captionTextField.textColor = [UIColor grayColor];
    }
}

- (void)textBoxOptions{
    self.captionTextField.autocorrectionType = NO;
    self.captionTextField.text = @"Add a caption...";
    self.captionTextField.backgroundColor = [UIColor secondarySystemBackgroundColor];
    self.captionTextField.textColor = [UIColor secondaryLabelColor];
    self.captionTextField.layer.cornerRadius = 20;
    self.captionTextField.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.captionTextField.layer.shadowColor = [UIColor grayColor].CGColor;
    self.captionTextField.layer.shadowOffset = CGSizeMake(.75, .75);
    self.captionTextField.layer.shadowOpacity = .4;
    self.captionTextField.layer.shadowRadius = 20;
    self.captionTextField.layer.masksToBounds = NO;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.captionTextField.delegate = self;
    [self textBoxOptions];
    
    [self initiateCamera];
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
