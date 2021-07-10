//
//  FeedViewController.m
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/7/21.
//

#import "FeedViewController.h"
#import "LoginViewController.h"
#import "DetailsViewController.h"
#import "PostUserViewController.h"
#import "SceneDelegate.h"
#import "PostCell.h"
#import "Parse/Parse.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource, PostCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *feedPosts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.user = [PFUser currentUser];
    [self getPosts];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (IBAction)pressedLogout:(id)sender {
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    myDelegate.window.rootViewController = loginViewController;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
}
- (IBAction)pressedShare:(id)sender {
    [self performSegueWithIdentifier:@"composePostSegue" sender:nil];
}

- (void) getPosts {
    // construct query to get posts
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //[query whereKey:@"likesCount" greaterThan:@100]; Can use this as a filter later!
    query.limit = 20;
    [query includeKey:@"fullName"];
    [query orderByDescending:@"createdAt"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.feedPosts = [posts copy];
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
            [self createAlert:@"Please check your wifi connection and try again!" error:@"Unable to Load Feed"];
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual:@"postDetails"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.feedPosts[indexPath.row];
        DetailsViewController *detailViewController = [segue destinationViewController];
        detailViewController.post = post; // Passing over post to next view controller.
    }
    if ([segue.identifier isEqual:@"picToProfile"]) {
        PostUserViewController *postUserViewController = [segue destinationViewController];
        postUserViewController.user = sender; // Passing over user to next view controller.
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *currentPost = self.feedPosts[indexPath.row];
    cell.delegate = self;
    cell.post = currentPost;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedPosts.count; // User can view last 20 posts posted to Instagram
}

- (void) createAlert: (NSString *)message error:(NSString*)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:error
                                                                               message:message
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];

    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    // show alert
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
}


- (void) profilePicTap:(nonnull PostCell *)postCell didTap:(nonnull PFUser *)postUser {
    [self performSegueWithIdentifier:@"picToProfile" sender:postUser];
}

@end
