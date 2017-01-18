
#GitHub
# all command are here https://git-scm.com/docs

#To assign a new directory as a main go to desirable directory and then
git init

#To know the status of progress use
git status
#if staged:
  #Files are ready to be committed.
#unstaged:
  #Files with changes that have not been prepared to be committed.
#untracked:
  #Files aren't tracked by Git yet. This usually indicates a newly created file.
#deleted:
#File has been deleted and is waiting to be removed from Git.

#To add file to the staging area type file name with extension without quotas
git add name_file.extension

	#Add all. where the dot stands for the current directory, so everything in and beneath it is added. The -A ensures even file deletions are included.
	git add -a .
	
	#You can use git reset <filename> to remove a file or files from the staging area.
	git reset name_file.extension
	
	#To add all files with the same extencion use wildcard
	git all '*.extension'
	
# Commit changes.
git commit -m "My comment will be here"

#To see log file (commits and changes)
git log
git log --summary

#Add remote repository where try-git is your name on GitHub. try_git.git is name of your repository. Origin is a name of a remote in GitHub
git remote add origin https://github.com/try-git/try_git.git

#next command tells GitHub where to put the commit
#origin - name of the remote
#master - name of current branch    \\EPBYMINSA0000.minsk.epam.com\Training Materials\EPAM Mentoring\DevOps Mentoring Program\01_Version_Control_Systems
# -u - remember the parameters. SO, next time we can use just git push
git push -u origin master

#To check the changes which were made in repository.
#Use the command 'git stash' to stash your changes, and 'git stash apply' to re-apply your changes after your pull.
git pull origin master

#To see the difference between files. Red - old, green - new.
#HEAD - The HEAD is a pointer that holds your position within all your different commits. By default HEAD points to your most recent commit, 
#Do it can be used as a quick way to reference that commit without having to look up the SHA. Like a SAVEPOINT in Oracle
git diff HEAD 

#Remember, staged files are files we have told git that are ready to be committed.
#You want to try to keep related changes together in separate commits. Using 'git diff' gives you a good overview of changes you have made and 
#lets you add files or directories one at a time and commit them separately.
git add file_path/file_name.extension

#to see the changes you just staged
git diff --staged

#To remove file
git reset file_path/file_name.extension

# To undo last changes
git checkout --file_name.extension

# To create a new branch
git branch New_branch

#TO see how many branches you have
git branch

#To see branch options
git branch -b

#To check a new branch
git checkout new_branch

#Next command helps you to remove file from the DISK and from the REPOCITORY too.
git rm '*.txt'

#To remove all files into current directory use
git rm -r folder_name

#To delete files with the commit.
git commit -am "Delete stuff"

#To merget FROM the NAME_BRANCH to the CURRENT_BRANCH.
#1. Go to the CURRENT_BRANCH
git checkout current_branch
#2. Merge it (you merge data FROM the CURRENT_BRANCH TO the NAME_BRANCH)
git merge NAME_BRANCH 

#To delete a branch
#You can either add the --force (-f) option or use -D which combines -d -f together into one command.
git branch -d branch_name

#TO pull it into remote repository
git push

