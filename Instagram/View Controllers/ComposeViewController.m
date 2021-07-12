//
//  ComposeViewController.m
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/8/21.
//

#import "ComposeViewController.h"
#import "Post.h"
#import <QuartzCore/QuartzCore.h>

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *composePhotoView;
@property (weak, nonatomic) IBOutlet UITextView *composeCaptionText;
@property (weak, nonatomic) IBOutlet UIButton *fromCameraButton;
@property (weak, nonatomic) IBOutlet UIButton *fromPhotosButton;

@end

@implementation ComposeViewController

// This view controller allows users to add photos to their posts, either through taking a photo with their device's camera or by choosing a photo from their photo library, and then add a caption to the photo.

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // We want the buttons to choose where to source a photo to have rounded edges for design.
    self.fromCameraButton.layer.cornerRadius = 10;
    self.fromCameraButton.clipsToBounds = YES;
    self.fromPhotosButton.layer.cornerRadius = 10;
    self.fromPhotosButton.clipsToBounds = YES;
    // To use text view methods, we set the view controller as a delegate for the text view.
    self.composeCaptionText.delegate = self;
    // The default text is light gray, because it is meant to go away when a user types in their real text.
    self.composeCaptionText.textColor = UIColor.lightGrayColor;
    // As soon as the view loads, the image picker should show up so users can add the photo to their post.
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera; // The camera is the image source.
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; // The photo library is the code source.
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

// The below is for style purposes, so that the textview placeholder text disappears when a user starts typing and turns black, so a user knows it is their actual caption.
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (textView.textColor == UIColor.lightGrayColor) {
        textView.text = @"";
        textView.textColor = UIColor.blackColor;
    }
}

// And when a user finishes editing, we want to make sure they actually wrote something, or else we remind them again to write a caption in gray text. Otherwise, the caption is whatever they said it is.
- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqual:@""]) {
        textView.text = @"Write a caption...";
        textView.textColor = UIColor.lightGrayColor;
    }
}

// A user can tap anywhere to stop editing and make the keyboard go away.
- (IBAction)onTapAnywhere:(id)sender {
    [self.composeCaptionText endEditing:true];
}

// The below two methods give the user more power to pick or change the image they selected for their post, or in case they accidentally closed out of the image picker.
// The below is what happens when a user clicks from camera, so they can take a picture.
- (IBAction)onTapFromCamera:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }
    else {
        [self createAlert:@"Please allow camera access and try again!" error:@"Unable to Acccess Camera"];
    }
}

// The below is what happens when a user clicks from photos, so they can select or re-select a photo from their library.
- (IBAction)onTapFromPhotos:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }
    else {
        [self createAlert:@"Please allow photo library access and try again!" error:@"Unable to Acccess Photo Library"];
    }
}

// This function is to set the image in the post to the image picked or taken and to make sure it's been resized.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    //UIImage *editedImage = info[UIImagePickerControllerEditedImage]; Not sure what this line is for.
    CGSize imageSize = CGSizeMake(self.composePhotoView.frame.size.width, self.composePhotoView.frame.size.height);
    UIImage *resizedImage = [self resizeImage:originalImage withSize:imageSize];
    // Do something with the images (based on your use case)
    self.composePhotoView.image = resizedImage;
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

// If a user taps cancel, they can go back to the feed.
- (IBAction)onTapCancel:(id)sender {
    [self performSegueWithIdentifier:@"composeToFeed" sender:nil];
}

// When a user taps share, we want to post their post using the method from Post, which takes care of that for us.
- (IBAction)onTapShare:(id)sender {
    [Post postUserImage:self.composePhotoView.image withCaption:self.composeCaptionText.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            [self createAlert:@"Unable to share post. Please check your internet connection and try again!" error:@"Unable to Post"];
        }
    }];
    // Then we want to go back to our feed.
    [self performSegueWithIdentifier:@"composeToFeed" sender:nil];
}

// This function resizes images in case they are too large so they can be stored in the database.
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

// This function allows us to create alerts without rewriting the code.
- (void) createAlert: (NSString *)message error:(NSString*)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:error message:message preferredStyle:(UIAlertControllerStyleAlert)];
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    // handle response here.
    }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    // show alert
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
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
