# FutureFeedback

# Demo
https://future-feedback.herokuapp.com/
Please feel free to ask for test credentials.

![image of FF logo](https://i.imgur.com/KdiCL4z.png)

## Project FAQ

**1. What is FutureFeedback?**

FutureFeedback is a forum for users to create posts for developers to prioritize implementations of bug fixes and features. 

**#2. How does it work?**

After account creation, users may create a post and have multiple tags on it. Creation of a post involves adding tags so that moderators and engineers can filter by tags. Each post has upvotes and downvotes to gauge importance. If a post has several upvotes, it should take priority on fixing. If it has less, then it may not be a big issue.

**#3. What does this solve?**

As an application or community grows, bugs, features, and other issues become harder to track. FutureFeedback eases the friction and removes the need for engineers to search forums and see what needs to be fixed on their own.


# Features 


### Users may:

Search:
* search for users 
* create and search for tags


Index:
* sort by most upvotes/downvotes/comments
* filter by status
* login and signout
* create a new post
* vote and downvote posts

Post:
* create and edit posts with multiple tags
* comment on posts
* delete posts
* Upvote and downvote comments



## How to Install

1. Clone respository to your computer.
2. Run `bundle install` to install required gems
3. Run `brew install imagemagick` for MAC users or 4. `apt-get install imagemagick` for linux to allow intepretation of images in various formats.
4. Run `db:create`
4. Run `db:migrate`
5. Run `db:seed`
6. Run `rails s` to enter the application.

