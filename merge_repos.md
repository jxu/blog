# Merging git repos into a linear history

Every once in a blue moon, I come up with a weird git situation where the standard git workflow is not enough.
Usually, this is rewriting the author of one of my old Github repos because I changed my username ([back in 2018 when Github still allowed you to claim inactive usernames](https://github.com/orgs/community/discussions/23495#discussioncomment-14476959) - thankfully I didn't put it off any longer). 
The old username is now taken by someone else, leading to a potentially confusing history, so I like to rewrite history to make my current account the author of all my old commits. The [`git filter-branch` script](https://gist.github.com/jxu/d947684ef28da836697580ee71f2aa92) originally came from a Github Help page that no longer exists, maybe because running it nowadays gives a disconcerting warning from git: 

> git filter-branch has a plethora of pitfalls that can produce non-obvious manglings of the intended history rewrite (and can leave you with little time to investigate such problems since it has such abysmal performance)... 

This time, I was cleaning out some of the private repos in my account, and I saw I had four similar repos for a class: 10707-assignment1, 10707-assignment2, 10707-assignment3, and 10707-assignment4. 
Naturally, I thought about lowering my repo count (in the 80s at the time of writing) by combining these into one repo. Each repo would become its own directory. 

`git subtree` is the safer and easier option, which merges in each repo to preserve history.
But history is written by the victors, and I wanted to rewrite history to give the illusion of a convenient linear history (something I've done before to a lesser extent).
This is doable because each repo is small, only authored by me (i.e. no collaborator permissions), and only on one master branch. Anything more would make the merging much more complicated.

After some experimentation and research, I determined the simplest approach is to replay one repo's commits on top of another's with rebase. Here is a summary of the actual commands:

```sh
git clone git@github.com:jxu/10707-assignment3.git
cd 10707-assignment3
git filter-repo --to-subdirectory-filter assignment3
```

[`git filter-repo`](https://github.com/newren/git-filter-repo) is the magic prepatory step that rewrites the commits so that everything takes place in a subdirectory named `assignment3`.
filter-repo replaces older tools filter-branch and BFG. It has to be installed separately.  

```sh
cd ../10707
git remote add assignment3 ../10707-assignment3
git fetch assignment3
git checkout -b assignment3-master assignment3/master
```

To prepare for the rebase, I add the assignment3 repo as a remote.

Even though I checkout `assignment3/master` like a local branch, the remote isn't a branch. I use `-b assignment3-master` to create a new local branch. Checking out a remote without creating a new branch will report "You are in 'detached HEAD' state."

```sh
git rebase master --committer-date-is-author-date 
git checkout master
git merge --ff-only assignment3-master
```

The rebase is what actually combines the commits. Afterwards, master is fast-forwarded to the new latest commit.
(The `--committer-date-is-author-date` flag needed because otherwise the CommitDate shows as today, which is [what github's web UI shows](https://github.com/orgs/community/discussions/32270).)

Looking with `gitk --all`, there actually is [a backup history at `original/refs/heads/master`](https://stackoverflow.com/questions/7654822/remove-refs-original-heads-master-from-git-repo-after-filter-branch-tree-filte), which is a good idea because doing this sort of thing is very easy to mess up. 

I'm not sure if there's an easier way to do all this, given a lot of history is being rewritten. It's a Good Thing™ that rewriting many commits isn't easy, as git is based on a hash chain of immutable commits, somewhat like a "blockchain".
