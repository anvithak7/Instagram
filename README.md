# Project 4 - *Instagram*

**Instagram** is a photo sharing app using Parse as its backend.

Time spent: **25** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign up to create a new account using Parse authentication
- [X] User can log in and log out of his or her account
- [X] The current signed in user is persisted across app restarts
- [X] User can take a photo, add a caption, and post it to "Instagram"
- [X] User can view the last 20 posts submitted to "Instagram"
- [X] User can pull to refresh the last 20 posts submitted to "Instagram"
- [X] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [X] Run your app on your phone and use the camera to take the photo
- [ ] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [X] Show the username and creation time for each post
- [X] User can use a Tab Bar to switch between a Home Feed tab (all posts) and a Profile tab (only posts published by the current user (work in progress))
- User Profiles:
  - [X] Allow the logged in user to add and edit a profile photo
  - [X] Display the profile photo with ea h post
  - [X] Tapping on a post's username or profile photo goes to that user's profile page
- [ ] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- [ ] User can comment on a post and see all comments for each post in the post details screen.
- [X] User can like a post and see number of likes for each post in the post details screen.
- [X] Style the login page to look like the real Instagram login page.
- [ ] Style the feed to look like the real Instagram feed.
- [ ] Implement a custom camera view.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!
- [X] A user can edit their name, username, and bio.
- [X] Captions show up like on the real Instagram, with username bolded and attached to the caption.
- [X] Launch screen with Instagram font (and added Instagram font everywhere).
- [X] New user page looks like the real Instagram.
- [X] Made user interface cleaner with compose view having options to pick image from camera or from photos if user closes ImagePickerController accidentally

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. What are more effective ways of adding a scrollable collection view to the profile page (which causes the bio, etc. to scroll up too?)?
2. What are some ways to implement the UI for comments, replies, and reactions?

## Video Walkthrough

Here's a walkthrough of implemented user stories:

- Login/Persisted User/Logout Functionality
<img src='http://g.recordit.co/gNVzXSV6vH.gif' title='Login/Persistence/Logout' width='' alt='Login/Persistence/Logout' />

- Instagram New User Page Validation
<img src='http://g.recordit.co/Wxq7S27XSO.gif' title='New User Page Validation' width='' alt='New User Page Validation' />

- Taking a Photo, Adding a Caption, and Posting It to Instagram
<img src='http://g.recordit.co/xTTElvWY4r.gif' title='Taking a Photo, Adding a Caption, and Posting It to Instagram' width='' alt='Taking a Photo, Adding a Caption, and Posting It to Instagram' />

- Post Details, Like Functionality, Clicking on Profile Image/Username Leads to Profile Page of Post's User
<img src='http://g.recordit.co/LsI6DPhz1N.gif' title='Post Details, Like Functionality, Clicking on Profile Image/Username Leads to Profile Page of Post User' width='' alt='Post Details, Like Functionality, Clicking on Profile Image/Username Leads to Profile Page of Post User' />

- Pull to Refresh, Long Captions Supported, User Can View 20 Latest Posts
<blockquote lang="en"><a href="http://g.recordit.co/IVa4j6phxS.gif">Pull to Refresh, Long Captions Supported, User Can View 20 Latest Posts</a></blockquote>
<img src='http://g.recordit.co/IVa4j6phxS.gif' title='Pull to Refresh, Long Captions Supported, User Can View 20 Latest Posts' width='' alt='Pull to Refresh, Long Captions Supported, User Can View 20 Latest Posts' />

- User Login Validation and Editing Profile to Add Profile Picture and Change Name/Username/Bio
<img src='http://g.recordit.co/P4qtRtEoKM.gif' title='Editing Profile to Add Profile Picture and Change Name/Username/Bio' width='' alt='Editing Profile to Add Profile Picture and Change Name/Username/Bio' />

- Instagram on a Real Phone with Camera
<blockquote lang="en"><a href="https://imgur.com/a/hQ3XOa4.gif">Instagram on a Real Phone with Camera</a></blockquote>
<img src='https://imgur.com/a/hQ3XOa4.gif' title='Instagram on a Real Phone with Camera' width='' alt='Instagram on a Real Phone with Camera' />

- Screen Rotations and Different Phone Sizes
<blockquote lang="en"><a href="http://g.recordit.co/xm4jrqmcQp.gif">Screen Rotations and Different Phone Sizes</a></blockquote>
<img src='http://g.recordit.co/xm4jrqmcQp.gif' title='Screen Rotations and Different Phone Sizes' width='' alt='Screen Rotations and Different Phone Sizes' />

GIF created with [Kap](https://getkap.co/).

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [Parse](https://www.back4app.com/docs/get-started/welcome)
- [Parse/UI](https://github.com/parse-community/ParseUI-iOS)
- [DateTools](https://github.com/MatthewYork/DateTools)


## Notes

Describe any challenges encountered while building the app.

I faced several challenges when working on this app. Much of the initial UI (such as the table view, post cells, and pull to refresh) was a repeat from previous projects, so it was much faster to implement. There was less guidance for the optional functionalities though, so finding the syntax for those took much longer, especially when it was using a new datatype. When attaching the username to the caption in a bold font, for instance, I spent some time translating suggestions that were in Swift to Objective-C, and had to do some trial and error with Xcode’s autocomplete to figure out the syntax to do what I wanted with NSMutableAttributedStrings, as well as to find and set the properties I wanted. One challenge I had was understanding exactly how to interact with the backend, especially when combining data from multiple databases (such as user and post)–using the code suggested on the reference documentation did not update any of my databases, so I spent a lot of time trying to check over every property and characteristic to make sure there were no issues. I ended up being helped by one of my pod members, who had instead used another method to update the database which seemed to work more effectively. I have learned how to segue from a tableviewcell to another view controller, but I was unable to segue to yet another view controller upon pressing on an imageview or a label. I tried using tap gesture recognizers, but I couldn’t perform the segue after setting everything up, since the tableviewcell had no reference to what viewcontroller it was in. After asking a TA, I learned how to create a protocol for this, which helped me better understand what and how a protocol works. Thus, I was able to make the viewcontroller a delegate of the tableviewcell, so that upon tapping on something within the tableviewcell, I would call the delegate method to perform the segue I wanted and pass the necessary objects over. I also researched how to add placeholder text in a textview using start editing and end editing methods, and how to add custom fonts to Xcode. Because my app has so many view controllers, Xcode began to stop responding whenever I opened my storyboard, which delayed my development a lot, since even after restarting Xcode and my computer, making sure there were no other tabs open, and going through Xcode error debugging checklists, Xcode would just freeze and I would have to force quit it several times. This began to happen quite often in the latter parts of development, so I was interrupted every half an hour or one hour by about ten to twenty minutes until suddenly Xcode would work again. When I tried adding autolayout to style my launch screen, Xcode had an internal error, and that caused even more problems, such as turning the launch screen to a black screen and causing random errors to appear in my code. I think I understand why most people don’t use the storyboard for larger apps now. There were several smaller issues that were eventually resolved, but one I have yet to figure out is why after composing a post, the tab bar controller seems to disappear. I tried moving the segue to other view controllers which would make more sense (such as the tab bar controller that goes to the feed), but for some reason, my entire app would crash no matter where I sent the segue unless it was directly to the feed view controller. That is something I will continue to research a little. I also tried to implement a user’s own posts on their profile page with a tableView with multiple sections, but I wasn’t able to get that working in time so I deleted it for the submission. I want to discuss more about that because there has to be easier ways to implementing that and making it functional and beautiful. Some of the TAs had some suggestions, so I might try those soon. Other than that, I have learned a lot from this app, and have really enjoyed trying to style it to look like the real Instagram!

## License

    Copyright [2021] [Anvitha Kachinthaya]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
